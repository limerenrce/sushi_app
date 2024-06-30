// ignore_for_file: file_names, use_build_context_synchronously, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sushi_app/theme/colors.dart';
import 'package:sushi_app/services/data_service.dart';
import 'package:sushi_app/models/order_detail.dart';

class AdminOrderList extends StatefulWidget {
  const AdminOrderList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminOrderListState createState() => _AdminOrderListState();
}

class _AdminOrderListState extends State<AdminOrderList> {
  late Future<List<OrderDetail>> futureOrderDetails;

  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
  }

  void fetchOrderDetails() {
    setState(() {
      futureOrderDetails = DataService().fetchOrder();
    });
  }

  Map<int, List<OrderDetail>> groupByIdOrder(List<OrderDetail> orders) {
    final Map<int, List<OrderDetail>> groupedOrders = {};
    for (var order in orders) {
      if (groupedOrders.containsKey(order.idOrder)) {
        groupedOrders[order.idOrder]!.add(order);
      } else {
        groupedOrders[order.idOrder] = [order];
      }
    }
    return groupedOrders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        title: const Text(
          'Order List',
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Dashboard",
                style: GoogleFonts.dmSerifDisplay(
                  fontSize: 26,
                  color: primaryColor,
                ),
              ),
              Text(
                "Easily and efficiently manage all your orders.",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<OrderDetail>>(
                future: futureOrderDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No orders available'));
                  } else {
                    final groupedOrders = groupByIdOrder(snapshot.data!);
                    return Column(
                      children: groupedOrders.entries.map((entry) {
                        return OrderGroupCard(
                          idOrder: entry.key,
                          orders: entry.value,
                          onUpdate: fetchOrderDetails,
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderGroupCard extends StatelessWidget {
  final int idOrder;
  final List<OrderDetail> orders;
  final VoidCallback onUpdate;

  String formatPrice(int price) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    return formatter.format(price);
  }

  String formatPriceTot(int total) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(total);
  }

  const OrderGroupCard(
      {super.key,
      required this.idOrder,
      required this.orders,
      required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    String user = orders.first.username;
    String status = orders.first.status;
    Color statusColor =
        status.toLowerCase() == 'paid' ? Colors.green : Colors.red;

    Future<void> makePayment() async {
      try {
        // Assuming orders list has only one status, update for simplicity
        await DataService().updateOrderStatus(orders.first.idOrder);
        // Update status locally in the widget
        // ignore: avoid_function_literals_in_foreach_calls
        orders.forEach((order) {
          order.updateStatus('paid');
        });
        onUpdate();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment made successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to make payment: $e')),
        );
      }
    }

    void showConfirmationDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            width: 350,
            height: 220,
            child: Column(
              children: [
                const SizedBox(height: 8),
                Icon(Icons.payment, color: primaryColor, size: 60),
                const SizedBox(height: 8),
                const Text(
                  "Are you sure you want to make the payment?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please make sure yor already received the money before proceeding this order! Thankyou!",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: primaryColor)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: primaryColor, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context); // Close the dialog
                    await makePayment();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(40)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'OrderID#$idOrder',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
          Text('Placed by: $user'),
          const SizedBox(height: 10), // Adding some space before the header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120, // Fixed width for the item name
                child: const Text('Item',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                width: 40, // Fixed width for the quantity
                child: const Text('Qty',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                width: 60, // Fixed width for the price
                child: const Text('Price',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                width: 60, // Fixed width for the total
                child: const Text('Total',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const Divider(),
          ...orders.map((order) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120, // Fixed width for the item name
                      child: Text(
                        order.menuName,
                        softWrap: true, // Allows text to wrap to the next line
                      ),
                    ),
                    Container(
                      width: 40, // Fixed width for the quantity
                      child: Text('x${order.quantity}'),
                    ),
                    Container(
                      width: 60, // Fixed width for the price
                      child: Text(formatPrice(order.menuPrice)),
                    ),
                    Container(
                      width: 60, // Fixed width for the total
                      child:
                          Text(formatPrice(order.menuPrice * order.quantity)),
                    ),
                  ],
                ),
                const SizedBox(height: 5), // Adding some space between items
              ],
            );
            // ignore: unnecessary_to_list_in_spreads
          }).toList(),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                formatPriceTot(
                    orders.fold<int>(0, (sum, order) => sum + order.itemTotal)),
                // 'Rp.${orders.fold<int>(0, (sum, order) => sum + order.itemTotal)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          if (status.toLowerCase() ==
              'unpaid') // Show payment button if status is unpaid
            Center(
              child: ElevatedButton(
                onPressed: showConfirmationDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: const Text(
                  'Make Payment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../endpoints/endpoints.dart';
import '../models/menu.dart';

class FoodTile extends StatelessWidget {
  final Menus menus;
  final void Function()? onTap;

  const FoodTile({super.key, required this.onTap, required this.menus});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(left: 25),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //IMAGE
            Image.network(
              '${Endpoints.ngrok}/${menus.imagePath}',
              height: 105,
            ),

            //TEXT
            Text(
              menus.name,
              style: GoogleFonts.dmSerifDisplay(fontSize: 20),
            ),

            //PRICE + RATING
            SizedBox(
              width: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //PRICE
                  Text(
                    'RP ${menus.price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),

                  //RATING
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),
                      Text(
                        '${menus.rating}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

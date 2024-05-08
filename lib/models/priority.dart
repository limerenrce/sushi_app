// ignore_for_file: unused_element, constant_identifier_names

class CustPriority {
  final String name;

  CustPriority({required this.name});

  String get _name => name;
}

final List<CustPriority> _custPriority = [
  //SUSHI
  CustPriority(
    name: "Low",
  ),
  CustPriority(
    name: "Medium",
  ),
  CustPriority(
    name: "High",
  ),
];

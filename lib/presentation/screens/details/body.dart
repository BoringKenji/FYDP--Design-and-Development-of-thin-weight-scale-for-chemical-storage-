import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final int id;
  final String name;
  final String brand;
  final String cas;
  final String purchasedate;

  const Body(
      {Key? key,
      required this.id,
      required this.name,
      required this.brand,
      required this.cas,
      required this.purchasedate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
            'ID:$id \n Chemiclas:$name \n Brand:$brand \n CAS:$cas \n Purchase Date:$purchasedate',
            style: TextStyle(fontSize: 22)),
      ),
    );
  }
}

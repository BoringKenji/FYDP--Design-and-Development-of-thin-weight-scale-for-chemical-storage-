import 'package:flutter/material.dart';
import 'body.dart';

class Chemicals_Details extends StatelessWidget {
  final String id;
  final String name;
  final String brand;
  final String cas;
  final String purchasedate;
  const Chemicals_Details(
      {Key? key,
      required this.id,
      required this.name,
      required this.brand,
      required this.cas,
      required this.purchasedate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chemicals Detail'),
        elevation: 0,
      ),
      body: Body(
        id: id,
        name: name,
        brand: brand,
        cas: cas,
        purchasedate: purchasedate,
      ),
    );
  }
}

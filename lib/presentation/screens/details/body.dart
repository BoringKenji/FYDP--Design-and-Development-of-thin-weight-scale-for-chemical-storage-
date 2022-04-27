import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  final String id;
  String name;
  String brand;
  String cas;
  String purchasedate;

  Body(
      {Key? key,
      required this.id,
      required this.name,
      required this.brand,
      required this.cas,
      required this.purchasedate})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String brand = widget.brand;
    String cas = widget.cas;
    String purchasedate = widget.purchasedate;
    void update() async {
      String url =
          'https://fypd-d0e2e-default-rtdb.asia-southeast1.firebasedatabase.app/chemicals/' +
              widget.id.toString() +
              '.json';
      print(url);
      try {
        print(widget.name);
        final response = await http.put(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "ID": widget.id,
            'Name': name,
            "Brand": brand,
            "CAS": cas,
            "Purchasedate": purchasedate
          }),
        );
        print(response.body);
        if (response.statusCode == 200) {
          print("Update Done");
        } else {
          print("Fail to update  firebase");
        }
      } catch (e) {
        print(e);
      }
      Navigator.of(context).pop();
    }

    Future openDialog(String input) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text("Edit"),
              content: TextField(
                  onChanged: (value) {
                    if (input == 'name') {
                      name = value;
                    }
                    else if(input == 'brand'){
                      brand = value;
                    }
                    else if(input == 'cas'){
                      cas = value;
                    }
                    else if(input == 'purchasedate'){
                      purchasedate = value;
                    }
                  },
                  autofocus: true,
                  decoration:
                      InputDecoration(hintText: 'Enter the update data')),
              actions: [TextButton(onPressed: update, child: Text("Update"))]),
        );

    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text('ID:${widget.id} ', style: TextStyle(fontSize: 22)),
            ),
            ListTile(
              title:
                  Text('Name:${name}', style: TextStyle(fontSize: 22)),
              trailing: IconButton(
                  onPressed: () async => await openDialog('name'),
                  icon: Icon(Icons.edit)),
            ),
            ListTile(
              title:
                  Text('Brand:${brand}', style: TextStyle(fontSize: 22)),
              trailing: IconButton(
                  onPressed: () async => await openDialog('brand'),
                  icon: Icon(Icons.edit)),
            ),
            ListTile(
              title: Text('CAS:${cas} ', style: TextStyle(fontSize: 22)),
              trailing: IconButton(
                  onPressed: () async => await openDialog('cas'),
                  icon: Icon(Icons.edit)),
            ),
            ListTile(
              title: Text('Purchasedate:${purchasedate} ',
                  style: TextStyle(fontSize: 22)),
              trailing: IconButton(
                  onPressed: () async => await openDialog('purchasedate'),
                  icon: Icon(Icons.edit)),
            )
          ],
        ),
      ),
    );
  }
}

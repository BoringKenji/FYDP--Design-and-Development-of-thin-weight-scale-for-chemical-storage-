import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fydp_app/constants.dart';
import 'package:fydp_app/screens/components/body.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('FYDP'),
      backgroundColor: kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.view_in_ar),
        onPressed: () {},
      ),
    );
  }
}

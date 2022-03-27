import 'package:flutter/material.dart';
import 'tray_weight.dart';
import 'title_with_more_btn.dart';
import 'recommand_chemicals.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Tray_weight(size: size),
          TitleWithMorebtn(title: "Repository"),
          Recommand_chemicals()
        ],
      ),
    );
  }
}


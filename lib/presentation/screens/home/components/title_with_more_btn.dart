import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fydp_app/presentation/constants.dart';
import 'package:http/http.dart' as http;

class TitleWithMorebtn extends StatelessWidget {
  const TitleWithMorebtn({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          TitleWithCustomUnderline(text: title),
          Spacer(),
          TextButton(
              onPressed: () async {
                const url =
                    'https://fypd-d0e2e-default-rtdb.asia-southeast1.firebasedatabase.app/test.json?orderBy="Timestamp"&limitToLast=1';
                try {
                  final response = await http.get(Uri.parse(url));
                  if (response.statusCode == 200) {
                    print("200");
                  } else {
                    print("connection fail to firebase");
                  }
                  var extractedData = jsonDecode(response.body);
                  print(Map<String, dynamic>.from(extractedData).values.toList()[0]['Weight_in_gram']);

                } catch (e) {
                  print(e);
                }
              },
              child: const Text(
                "More",
                style: TextStyle(color: Colors.green),
              ))
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({Key? key, required this.text})
      : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(right: kDefaultPadding / 4),
                height: 7,
                color: kPrimaryColor.withOpacity(0.2),
              ))
        ],
      ),
    );
  }
}

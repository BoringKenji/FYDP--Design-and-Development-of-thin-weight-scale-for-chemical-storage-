import 'dart:async';
import 'dart:convert';
import "dart:math";

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fydp_app/presentation/constants.dart';
import '../../details/chemicals_details.dart';

class Recommand_chemicals extends StatefulWidget {
  Recommand_chemicals({
    Key? key,
  }) : super(key: key);

  @override
  State<Recommand_chemicals> createState() => _Recommand_chemicalsState();
}

class _Recommand_chemicalsState extends State<Recommand_chemicals> {
  Timer? timer;
  List<RecommendPlantCard> cardlist = [];
  var assest_list = [
    "assets/images/Green_test_tube.png",
    "assets/images/Orange_testtube.png",
    "assets/images/pink_testtube.png"
  ];
  final _random = new Random();
  @override
  void getFirebase() async {
    String url =
        'https://fypd-d0e2e-default-rtdb.asia-southeast1.firebasedatabase.app/chemicals.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print("success to get chemiclas details");
      } else {
        print("connection fail to firebase");
      }
      var extractedData = jsonDecode(response.body);
      var body = Map<String, dynamic>.from(extractedData).values.toList();
      print(body);
      cardlist.clear();
      for (int i = 0; i < body.length; i++) {
        cardlist.add(RecommendPlantCard(
          image: assest_list[i % 3],
          name: body[i]["Name"],
          id: body[i]["ID"],
          brand: body[i]["Brand"],
          cas: body[i]["CAS"],
          purchasedate: body[i]["Purchasedate"],
          precentage: 100,
        ));
      }
      // print(extractedData);
      setState(() {
        ;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState(); //
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => getFirebase());
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Expanded(
        child: Row(
          children: cardlist,
        ),
      ),
    );
  }
}

class RecommendPlantCard extends StatelessWidget {
  const RecommendPlantCard({
    Key? key,
    required this.id,
    this.name,
    required this.image,
    required this.precentage,
    this.brand,
    this.cas,
    this.purchasedate,
  }) : super(key: key);

  final String image, id;
  final int precentage;
  final String? brand, cas, purchasedate, name;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding,
      ),
      width: size.width * 0.4,
      // height: size.height * 0.4,
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Chemicals_Details(
                  id: id,
                  name: name ?? "Name",
                  brand: brand ?? "Brand",
                  cas: cas ?? "CAS",
                  purchasedate: purchasedate ?? "NA",
                ),
              ));
        },
        child: Column(
          children: [
            Image.asset(image),
            Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    )
                  ]),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$name\n".toUpperCase(),
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                            text: "$id".toUpperCase(),
                            style: TextStyle(
                                color: kPrimaryColor.withOpacity(0.5)))
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$precentage%',
                    style: Theme.of(context).textTheme.button,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

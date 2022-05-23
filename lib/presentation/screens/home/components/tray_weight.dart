import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:fydp_app/presentation/constants.dart';

class Tray_weight extends StatefulWidget {
  const Tray_weight({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<Tray_weight> createState() => _Tray_weightState();
}

class _Tray_weightState extends State<Tray_weight> {
  int numberOfData = 10;
  double weight = 0;
  final List<WeightData> chartData = [];
  Timer? timer;
  void getFirebase() async {
    String url =
        'https://fypd-d0e2e-default-rtdb.asia-southeast1.firebasedatabase.app/test.json?orderBy="Timestamp"&limitToLast=$numberOfData';
    try {
      final response = await http.get(Uri.parse(url));
      var extractedData = jsonDecode(response.body);
      var body = Map<String, dynamic>.from(extractedData).values.toList();
      chartData.clear();
      for (int i = 0; i < numberOfData; i++) {
        chartData.add(WeightData(body[i]['Weight_in_gram'].toDouble(), i));
      }
      // print(extractedData);
      setState(() {
        weight = body[body.length - 1]['Weight_in_gram'].toDouble();
      });

      //update new chemicals weight
      String tags = body[numberOfData - 1]['RFID_tags_id_array'];
      String previousTags = body[numberOfData - 2]['RFID_tags_id_array'];
      String modifyID = '';
      double modifyWeight = weight;
      for (int i = 0; i < tags.length; i = i + 8) {
        String targetID = tags.substring(i, i + 8);
        String url =
            'https://fypd-d0e2e-default-rtdb.asia-southeast1.firebasedatabase.app/chemicals/$targetID.json';
        try {
          final response = await http.get(Uri.parse(url));
          var extractedData = jsonDecode(response.body);
          var targetWeight = extractedData['weight'];
          if (!previousTags.contains(targetID)) {
            modifyID = targetID;
          } else {
            modifyWeight -= double.parse(targetWeight);
          }
        } catch (e) {
          print(e);
        }
      }
      print(weight);
      print(body[body.length - 2]['Weight_in_gram'].toDouble());
      print(modifyID);
      print(modifyWeight);
      if (modifyID == '') {
        return;
      }
      // update weight
      String modifyURL =
          'https://fypd-d0e2e-default-rtdb.asia-southeast1.firebasedatabase.app/chemicals/' +
              modifyID +
              '.json';
      String modifyWeightInString = '';
      if (modifyWeight.toString().length > 7) {
        modifyWeightInString = modifyWeight.toString().substring(0, 6);
      } else {
        modifyWeightInString = modifyWeight.toString();
      }
      try {
        final response = await http.patch(
          Uri.parse(modifyURL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "weight": modifyWeightInString,
          }),
        );
        //print(response.body);
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState(); //
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => getFirebase());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Image.asset(
              "assets/images/Tray.png",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Weight : $weight g',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFF0C9869)),
            ),
          ),
          SfCartesianChart(
            title: ChartTitle(text: "History"),
            series: <ChartSeries>[
              LineSeries<WeightData, double>(
                  dataSource: chartData,
                  xValueMapper: (WeightData weight, _) =>
                      weight.xAxis.toDouble(),
                  yValueMapper: (WeightData weight, _) => weight.weightList,
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ],
            primaryXAxis:
                NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Number of Data',
            ),
            onChanged: (val) {
              numberOfData = int.parse(val);
            },
          ),
        ],
      ),
    );
  }
}

class WeightData {
  final weightList;
  final xAxis;
  WeightData(this.weightList, this.xAxis);
}

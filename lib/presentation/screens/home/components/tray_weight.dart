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
      if (response.statusCode == 200) {
        print("200");
      } else {
        print("connection fail to firebase");
      }
      var extractedData = jsonDecode(response.body);
      var body = Map<String, dynamic>.from(extractedData).values.toList();
      chartData.clear();
      for (int i = 0; i < numberOfData; i++) {
        chartData.add(WeightData(body[i]['Weight_in_gram'].toDouble(), i));
      }
      // print(extractedData);
      setState(() {
        weight = body[body.length-1]['Weight_in_gram'].toDouble();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState(); //
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => getFirebase());
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
              'Weight : $weight',
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
            onChanged: (val){
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

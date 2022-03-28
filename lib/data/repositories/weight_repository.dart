import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weight.dart';


class WeightRepository{
  Future <Weight> getLastWeightData() async{
    const url =
        'https://fypd-d0e2e-default-rtdb.asia-southeast1.firebasedatabase.app/test.json?orderBy="Timestamp"&limitToLast=1';
    var response =await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      Weight lastweight = Weight.fromJson(data);
      return lastweight;
    }else{
      throw Exception('Failed');
    }
  }
}
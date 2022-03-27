import 'dart:convert';

import 'package:http/http.dart';

import '../dataproviders/FirebaseAPI.dart';
import '../models/Weight.dart';
class WeightRepository{
  final FirebasesAPI api = FirebasesAPI();
  Future <Weight> getLastWeightData() async{
    final Response rawData =await api.getRawWeight(); 
    final Weight weightdata = Weight.fromJson(jsonDecode(rawData.body));
    return weightdata;
  }
}
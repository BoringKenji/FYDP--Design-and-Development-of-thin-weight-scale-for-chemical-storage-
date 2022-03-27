import 'package:http/http.dart' as http;

class FirebasesAPI{
  Future<http.Response> getRawWeight() async{
        const url =
        'https://fypd-d0e2e-default-rtdb.asia-southeast1.firebasedatabase.app/test.json?orderBy="Timestamp"&limitToLast=1';
    final Future <http.Response> rawWeight = http.get(Uri.parse(url));
    return rawWeight;
  }
}
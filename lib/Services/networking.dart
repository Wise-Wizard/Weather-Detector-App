import 'package:http/http.dart' as http;
import 'dart:convert';

const API_Key = '27795ce922e262e40fe837a780a624e1';

class Network {
  Network({required this.latitude, required this.longitude});
  final String latitude;
  final String longitude;
  Future GetData() async {
    Uri uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': latitude,
      'lon': longitude,
      'appid': '$API_Key',
    });
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

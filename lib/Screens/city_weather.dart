import 'package:http/http.dart' as http;
import 'dart:convert';

const API_Key = '27795ce922e262e40fe837a780a624e1';
Future GetCityWeather(String cityname) async {
  Uri uri = Uri.https(
    'api.openweathermap.org',
    '/data/2.5/weather',
    {
      'q': cityname,
      'appid': '$API_Key',
    },
  );
  http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    String data = response.body;
    return jsonDecode(data);
  } else {
    print(response.statusCode);
  }
}

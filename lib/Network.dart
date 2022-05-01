import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  String Url;

  Networking(this.Url);

  Future<dynamic> getdata() async {
    String data;
    try {
      var url = Uri.parse(Url);
      var response = await http.post(url);
      data = response.body;
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode != 200) {
        return 404;
      }
      return jsonDecode(data);
    } catch (e) {
      return 404;
    }
  }

// 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=afdb6534c6d0b7bafec9be67b8ec84d5&units=metric'
}

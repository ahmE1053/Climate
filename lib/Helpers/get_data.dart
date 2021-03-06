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
      if (response.statusCode != 200) {
        return 404;
      }
      return jsonDecode(data);
    } catch (e) {
      return 404;
    }
  }
}

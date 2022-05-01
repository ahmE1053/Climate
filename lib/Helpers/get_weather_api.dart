import 'dart:convert';
import 'get_data.dart';
import 'location.dart';

class weather {
  Future getweather() async {
    Location loc1 = Location();
    await loc1.GetLocation();
    Networking network = Networking(
        'https://api.openweathermap.org/data/2.5/weather?lat=${loc1.latitude}&lon=${loc1.longitude}&appid=afdb6534c6d0b7bafec9be67b8ec84d5&units=metric&lang=ar');
    return network.getdata();
  }

  Future getweathercity(String city) async {
    Networking network = Networking(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=afdb6534c6d0b7bafec9be67b8ec84d5&units=metric&lang=ar');
    return network.getdata();
  }
}

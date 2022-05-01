class Convert {
  int temp = 0, tempmin = 0, tempmax = 0, windspeed = 0;
  String name = "";
  var data;
  void set(data) {
    double tempa = data['main']['temp'];
    temp = tempa.toInt();
    double tempmina = data['main']['temp_min'];
    tempmin = tempmina.toInt();
    double tempmaxa = data['main']['temp_max'];
    tempmax = tempmaxa.toInt();
    double awindspeed = data['wind']['speed'];
    windspeed = awindspeed.toInt();
    name = data['name'];
  }
}

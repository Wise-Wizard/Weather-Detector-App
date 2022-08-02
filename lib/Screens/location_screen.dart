import 'package:flutter/material.dart';
import 'package:flutter_application_2/Screens/city_screen.dart';
import 'package:flutter_application_2/Utilities/constants.dart';
import 'package:flutter_application_2/Services/weather.dart';
import 'package:flutter_application_2/Screens/city_weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.LocationWeather});
  final LocationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weathericon = '';
  String tempicon = '';
  var cityname = '';
  @override
  void initState() {
    super.initState();
    UpdateUI(widget.LocationWeather);
  }

  void UpdateUI(dynamic weatherdata) {
    if (weatherdata == null) {
      temperature = 0;
      weathericon = 'ERROR';
      tempicon = 'Unable to get Weather';
      return;
    }
    double temp = weatherdata['main']['temp'];
    temp = temp - 273.1;
    temperature = temp.toInt();
    tempicon = weather.getMessage(temperature);
    var condition = weatherdata['weather'][0]['id'];
    weathericon = weather.getWeatherIcon(condition);
    cityname = weatherdata['name'];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Rengoku.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        UpdateUI(widget.LocationWeather);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherdata = await GetCityWeather(typedName);
                        setState(() {
                          UpdateUI(weatherdata);
                        });
                        print(typedName);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$tempicon in $cityname!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

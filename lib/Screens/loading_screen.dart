import 'package:flutter/material.dart';
import 'package:flutter_application_2/Screens/location_screen.dart';
import 'package:flutter_application_2/Services/location.dart';
import 'package:flutter_application_2/Services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const API_Key = '27795ce922e262e40fe837a780a624e1';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Current_Location location = Current_Location();

  @override
  void initState() {
    super.initState();
    location.GetLocation();
  }

  void getdata() async {
    Network WebData = Network(
        latitude: location.latitude.toString(),
        longitude: location.longitude.toString());
    var weatherdata = await WebData.GetData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        LocationWeather: weatherdata,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          size: 200,
          color: Colors.purple,
        ),
      ),
    );
  }
}

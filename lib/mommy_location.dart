import 'package:baby_and_you/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class MommyLocation extends StatefulWidget {
  const MommyLocation({super.key});

  @override
  State<MommyLocation> createState() => _MommyLocationState();
}

class _MommyLocationState extends State<MommyLocation> {
  double _latitude = 0.0;
  double _longitude = 0.0;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // supply location settings to getCurrentPosition
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high));
        setState(() {
    _latitude = position.latitude;
    _longitude = position.longitude;
        });
   
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHoneydew,
      appBar: AppBar(
        backgroundColor: kHoneydew,
      ),
      body: Center(
        child: Column(
          children: [
            Text("To Find the Nearest Care Centers To You ❤️‍🩹"),
            SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  _determinePosition();
                   print("$_longitude" "$_longitude");
                },
                child: Text("Get You Location")),
            _latitude == 0.0
                ? SizedBox()
                : ElevatedButton(
                    onPressed: () {
                      launchUrl(Uri.parse(
                          "https://www.google.com/maps/search/hospital/@$_latitude,$_longitude,12z"));
                    },
                    child: Text("See The Nearset Locations To You!")),
          ],
        ),
      ),
    );
  }
}

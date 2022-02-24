import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ninja_way/constants.dart';
import 'package:ninja_way/widgets/stepper_widget.dart';

void main() => runApp(const NinjaWayApp());

class NinjaWayApp extends StatefulWidget {
  const NinjaWayApp({Key? key}) : super(key: key);

  @override
  _NinjaWayAppState createState() => _NinjaWayAppState();
}

class _NinjaWayAppState extends State<NinjaWayApp> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(1.30822042654265, 103.773315219931);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NunitoSans',
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'NunitoSans',
              fontSizeFactor: 1,
            ),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: primaryColor,
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: primaryColor,
            onPrimary: Colors.white,
            secondary: primaryLightColor,
            onSecondary: Colors.black,
            error: Colors.black,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ninja Way'),
          backgroundColor: primaryColor,
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: 0.6,
              minChildSize: 0.2,
              initialChildSize: 0.2,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: const StepperWidget());
              },
            ),
          ],
        ),
      ),
    );
  }
}

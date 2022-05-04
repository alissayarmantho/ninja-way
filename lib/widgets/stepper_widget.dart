import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ninja_way/controller/map_controller.dart';
import 'package:ninja_way/services/base_api.dart';
import 'package:ninja_way/widgets/primary_button.dart';
import 'package:ninja_way/widgets/secondary_button.dart';
import 'package:url_launcher/url_launcher.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key? key}) : super(key: key);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.find<MapController>();
    return Stepper(
      physics: const ClampingScrollPhysics(),
      currentStep: _index,
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Row(
          children: <Widget>[
            PrimaryButton(
              key: UniqueKey(),
              text: "Navigation",
              press: () async {
                var oriIndex = _index - 1;
                LatLng ori;
                if (oriIndex < 0) {
                  await mapController.getCurrentLocation();
                  ori = LatLng(mapController.currLat.value,
                      mapController.currLong.value);
                } else {
                  ori = mapController.waypointsLatLong[_index];
                }
                var destIndex = _index + 1;
                if (destIndex >= mapController.waypointsLatLong.length) {
                  destIndex = 0;
                }
                LatLng dest = mapController.waypointsLatLong[destIndex];
                double oriLat = ori.latitude;
                double oriLong = ori.longitude;
                double destLat = dest.latitude;
                double destLong = dest.longitude;
                var url =
                    'https://www.google.com/maps/dir/?api=1&origin=$oriLat,$oriLong&destination=$destLat,$destLong&travelmode=driving&dir_action=navigate';
                launch(url);
              },
              widthRatio: 0.30,
              marginLeft: 0,
              marginRight: 5,
            ),
            SecondaryButton(
              key: UniqueKey(),
              text: "Notify",
              press: () async {
                await BaseApi.get(
                    url:
                        "https://us-central1-ninja-van-terminator.cloudfunctions.net/sendUpdateToCustomer");
              },
              widthRatio: 0.20,
              marginLeft: 0,
              marginRight: 5,
            ),
            TextButton(
              onPressed: _index > 0 ? details.onStepCancel : null,
              child: const Text('Back'),
            ),
          ],
        );
      },
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
            mapController.setActiveIndex(_index);
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
            mapController.setActiveIndex(_index);
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
          mapController.setActiveIndex(index);
        });
      },
      steps: mapController.waypointsAddress.map((String item) {
        return Step(
            title: Text(item),
            content: Container(alignment: Alignment.center, child: Text(item)));
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninja_way/controller/map_controller.dart';
import 'package:ninja_way/services/api_constants.dart';
import 'package:ninja_way/widgets/primary_button.dart';
import 'package:ninja_way/widgets/secondary_button.dart';
import 'package:ninja_way/services/base_api.dart';

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
              press: () async {},
              widthRatio: 0.30,
              marginLeft: 0,
              marginRight: 5,
            ),
            SecondaryButton(
              key: UniqueKey(),
              text: "Next",
              press: details.onStepContinue ?? () async {
                await BaseApi.get(url: "https://api.telegram.org/bot5120850223:AAFUsekiH6KESimwcxDTQ-4y21XMywFMwdQ/sendMessage");
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
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
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

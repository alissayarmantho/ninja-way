import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninja_way/controller/map_controller.dart';
import 'package:ninja_way/widgets/stepper_widget.dart';

class MapDraggableScrollSheet extends StatefulWidget {
  const MapDraggableScrollSheet({Key? key}) : super(key: key);

  @override
  _MapDraggableScrollSheetState createState() =>
      _MapDraggableScrollSheetState();
}

class _MapDraggableScrollSheetState extends State<MapDraggableScrollSheet> {
  final double _initialSheetChildSize = 0.3;
  double _dragScrollSheetExtent = 0;

  double _widgetHeight = 0;
  double _fabPosition = 0;
  final double _fabPositionPadding = 10;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Size size = MediaQuery.of(context).size;
      setState(() {
        _fabPosition = _initialSheetChildSize * size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final MapController mapController = Get.put<MapController>(MapController());
    return Stack(
      children: [
        Positioned(
          bottom: _fabPosition + _fabPositionPadding,
          right: _fabPositionPadding,
          child: FloatingActionButton(
            child: const Icon(Icons.my_location),
            onPressed: mapController.refocus,
          ),
        ),
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (DraggableScrollableNotification notification) {
            setState(() {
              _widgetHeight = size.height;
              _dragScrollSheetExtent = notification.extent;

              _fabPosition = _dragScrollSheetExtent * _widgetHeight;
            });
            return true;
          },
          child: DraggableScrollableSheet(
            maxChildSize: 0.6,
            minChildSize: 0.2,
            initialChildSize: _initialSheetChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 15,
                      blurRadius: 15,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return const StepperWidget();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';

class ProfileMap extends StatelessWidget {
  const ProfileMap({super.key, required this.controller});

  final MapController controller;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: Get.width,
        height: Get.height * 0.3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: OSMFlutter(
            controller: controller,
            osmOption: OSMOption(
              enableRotationByGesture: true,
              zoomOption: ZoomOption(
                initZoom: 16,
                minZoomLevel: 3,
                maxZoomLevel: 19,
                stepZoom: 1.0,
              ),
              userLocationMarker: UserLocationMaker(
                personMarker: MarkerIcon(
                  icon: Icon(
                    Icons.location_history_rounded,
                    color: Colors.red,
                    size: 48,
                  ),
                ),
                directionArrowMarker: MarkerIcon(
                  icon: Icon(
                    Icons.double_arrow,
                    size: 48,
                  ),
                ),
              ),
              roadConfiguration: RoadOption(
                roadColor: Colors.yellowAccent,
              ),
            ),
          ),
        ),
      );
}

import 'package:departuretimes/shared/constants/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/home_controller.dart';
import '../widgets/food_truck_list.dart';
import '../widgets/radius_selector.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StringsConstants.appName)),
      body: Stack(
        children: [
          Obx(() => GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.selectedLocation.value,
                  zoom: 14,
                ),
                onMapCreated: controller.onMapCreated,
                onLongPress: controller.onMapLongPress,
                markers: controller.markers,
              )),
          DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.25,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            RadiusSelector(
                              radius: controller.radius,
                              onChanged: controller.updateRadius,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: controller.fetchNearbyFoodTrucks,
                                    child: Text(StringsConstants.findTrucks),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.setSuggestedLocation();
                                    },
                                    child: Text(StringsConstants.gotoSuggested),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      FoodTruckList(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

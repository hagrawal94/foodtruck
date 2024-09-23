import 'package:departuretimes/modules/home/controllers/home_controller.dart';
import 'package:departuretimes/shared/constants/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodTruckList extends StatelessWidget {
  final HomeController controller = Get.find();
  final ScrollController scrollController = ScrollController();

  FoodTruckList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.foodTrucks.isEmpty) {
        return Text(StringsConstants.noFoodTrucksFound);
      }
      return ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        itemCount: controller.foodTrucks.length,
        itemBuilder: (context, index) {
          final truck = controller.foodTrucks[index];
          return ListTile(
            title: Text(truck.applicant),
            subtitle: Text(truck.fooditems ?? StringsConstants.noFoodItems),
            trailing: Text(truck.status),
            tileColor: truck == controller.selectedFoodTruck.value
                ? Colors.grey[300]
                : null,
            onTap: () {
              controller.selectedFoodTruck.value = truck;
            },
          );
        },
      );
    });
  }
}

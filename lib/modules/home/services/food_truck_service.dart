import 'dart:convert';

import 'package:departuretimes/modules/home/models/food_truck_model.dart';
import 'package:departuretimes/shared/api/api_config.dart';
import 'package:departuretimes/shared/api/base_provider.dart';
import 'package:flutter/material.dart';

class FoodTruckService {
  Future<List<FoodTruck>> getNearbyFoodTrucks(
      double lat, double lng, int radius) async {
    try {
      final response = await BaseHttpProvider()
          .getRequest(Config.getFoodTrucks, queryParameters: {
        'lat': lat.toString(),
        'lng': lng.toString(),
        'radius': radius.toString(),
      });
      return FoodTruck.fromList(jsonDecode(response.body));
    } catch (e) {
      debugPrint('Failed to fetch nearby food trucks: $e');
      throw Exception('Failed to fetch nearby food trucks: $e');
    }
  }
}

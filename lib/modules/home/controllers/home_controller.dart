import 'package:departuretimes/modules/home/models/food_truck_model.dart';
import 'package:departuretimes/modules/home/services/food_truck_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  final FoodTruckService _foodTruckService = Get.find<FoodTruckService>();

  final selectedLocation = const LatLng(0, 0).obs;
  final markers = <Marker>{}.obs;
  final radius = 1000.obs;
  final foodTrucks = <FoodTruck>[].obs;
  final selectedFoodTruck = Rx<FoodTruck?>(null);

  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onMapLongPress(LatLng position) {
    selectedLocation.value = position;
    _updateMarker();
  }

  void updateRadius(int value) {
    radius.value = value;
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      _setDefaultLocation();
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied.');
        _setDefaultLocation();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions are permanently denied.');
      _setDefaultLocation();
      return;
    }

    // If permissions are granted, get the current location
    final position = await Geolocator.getCurrentPosition();
    selectedLocation.value = LatLng(position.latitude, position.longitude);
    _updateMarker();
    mapController
        ?.animateCamera(CameraUpdate.newLatLng(selectedLocation.value));
  }

  void _setDefaultLocation() {
    selectedLocation.value =
        const LatLng(37.7749, -122.4194); // Default to San Francisco
    _updateMarker();
    mapController
        ?.animateCamera(CameraUpdate.newLatLng(selectedLocation.value));
  }

  void _updateMarker() {
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId('selected_location'),
      position: selectedLocation.value,
    ));
  }

  Future<void> fetchNearbyFoodTrucks() async {
    try {
      final trucks = await _foodTruckService.getNearbyFoodTrucks(
        selectedLocation.value.latitude,
        selectedLocation.value.longitude,
        radius.value,
      );
      foodTrucks.value = trucks;
      _updateFoodTruckMarkers();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch food trucks: $e');
    }
  }

  void _updateFoodTruckMarkers() {
    markers.clear();
    for (var truck in foodTrucks) {
      markers.add(Marker(
        markerId: MarkerId(truck.permit),
        position: LatLng(
            double.parse(truck.latitude!), double.parse(truck.longitude!)),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          truck.facilitytype == 'Truck'
              ? BitmapDescriptor.hueBlue
              : BitmapDescriptor.hueGreen,
        ),
        onTap: () {
          selectedFoodTruck.value = truck;
        },
      ));
    }
    // add a marker for the selected location
    markers.add(Marker(
      markerId: const MarkerId('selected_location'),
      position: selectedLocation.value,
    ));
  }

  void setSuggestedLocation() {
    selectedLocation.value =
        const LatLng(37.76537066931712, -122.40390784821223);
    _updateMarker();
    mapController
        ?.animateCamera(CameraUpdate.newLatLng(selectedLocation.value));
  }
}

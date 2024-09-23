import 'package:json_annotation/json_annotation.dart';

part 'food_truck_model.g.dart';

@JsonSerializable()
class FoodTruck {
  final String applicant;
  final String? facilitytype;
  final String? cnn;
  final String? locationdescription;
  final String? address;
  final String? blocklot;
  final String? block;
  final String? lot;
  final String permit;
  final String status;
  final String? fooditems;
  final String? x;
  final String? y;
  final String? latitude;
  final String? longitude;
  final String? schedule;
  final String? dayshours;
  final DateTime? approved;
  final String? received;
  final String? priorpermit;
  final DateTime? expirationdate;
  final Location location;

  FoodTruck({
    required this.applicant,
    this.facilitytype,
    this.cnn,
    this.locationdescription,
    this.address,
    this.blocklot,
    this.block,
    this.lot,
    required this.permit,
    required this.status,
    this.fooditems,
    this.x,
    this.y,
    this.latitude,
    this.longitude,
    this.schedule,
    this.dayshours,
    this.approved,
    this.received,
    this.priorpermit,
    this.expirationdate,
    required this.location,
  });

  factory FoodTruck.fromJson(Map<String, dynamic> json) =>
      _$FoodTruckFromJson(json);
  Map<String, dynamic> toJson() => _$FoodTruckToJson(this);

  static List<FoodTruck> fromList(List<dynamic> list) {
    return list.map((item) => FoodTruck.fromJson(item)).toList();
  }
}

@JsonSerializable()
class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

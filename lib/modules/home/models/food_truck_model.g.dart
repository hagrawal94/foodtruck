// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_truck_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodTruck _$FoodTruckFromJson(Map<String, dynamic> json) => FoodTruck(
      applicant: json['applicant'] as String,
      facilitytype: json['facilitytype'] as String?,
      cnn: json['cnn'] as String?,
      locationdescription: json['locationdescription'] as String?,
      address: json['address'] as String?,
      blocklot: json['blocklot'] as String?,
      block: json['block'] as String?,
      lot: json['lot'] as String?,
      permit: json['permit'] as String,
      status: json['status'] as String,
      fooditems: json['fooditems'] as String?,
      x: json['x'] as String?,
      y: json['y'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      schedule: json['schedule'] as String?,
      dayshours: json['dayshours'] as String?,
      approved: json['approved'] == null
          ? null
          : DateTime.parse(json['approved'] as String),
      received: json['received'] as String?,
      priorpermit: json['priorpermit'] as String?,
      expirationdate: json['expirationdate'] == null
          ? null
          : DateTime.parse(json['expirationdate'] as String),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FoodTruckToJson(FoodTruck instance) => <String, dynamic>{
      'applicant': instance.applicant,
      'facilitytype': instance.facilitytype,
      'cnn': instance.cnn,
      'locationdescription': instance.locationdescription,
      'address': instance.address,
      'blocklot': instance.blocklot,
      'block': instance.block,
      'lot': instance.lot,
      'permit': instance.permit,
      'status': instance.status,
      'fooditems': instance.fooditems,
      'x': instance.x,
      'y': instance.y,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'schedule': instance.schedule,
      'dayshours': instance.dayshours,
      'approved': instance.approved?.toIso8601String(),
      'received': instance.received,
      'priorpermit': instance.priorpermit,
      'expirationdate': instance.expirationdate?.toIso8601String(),
      'location': instance.location,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

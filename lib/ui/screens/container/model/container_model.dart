import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/models/rx.dart';

class ContainerModel {
  final int sensor_id;
  final int fullness_rate;
  final int last_data;
  final int temperature;
  final DateTime up_to_date;
  final String name;
  final Rx<GeoPoint> location;
  final Rx<bool> is_relocated;
  final Rxn<BitmapDescriptor> icon;

  ContainerModel._({
    required this.sensor_id,
    required this.fullness_rate,
    required this.last_data,
    required this.temperature,
    required this.up_to_date,
    required this.name,
    required this.location,
    required this.is_relocated,
    required this.icon,
  });

  factory ContainerModel.fromJson(Map<dynamic, dynamic> json) {
    return ContainerModel._(
      sensor_id: (json['sensor_id'] as num).toInt(),
      fullness_rate: (json['fullness_rate'] as num).toInt(),
      last_data: (json['last_data'] as num).toInt(),
      temperature: (json['temperature'] as num).toInt(),
      up_to_date: DateTime.fromMillisecondsSinceEpoch((json['up_to_date'] as Timestamp).millisecondsSinceEpoch.toInt()),
      name: json['name'] as String,
      location: Rx<GeoPoint>(json['location'] as GeoPoint),
      is_relocated: Rx<bool>(json['is_relocated'] as bool),
      icon: Rxn<BitmapDescriptor>(),
    );
  }
}

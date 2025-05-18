
import 'dart:convert';


class Location {
  const Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });


  final int id;
  final String name;
  final double latitude;
  final double longitude;

  String get toParams => 'lat=$latitude&lon=$longitude';
}

class GeocodingResult {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final double elevation;
  final String featureCode;
  final String countryCode;
  final int admin1Id;
  final int admin2Id;
  final String timezone;
  final int population;
  final int countryId;
  final String country;
  final String admin1;
  final String admin2;

  GeocodingResult({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.featureCode,
    required this.countryCode,
    required this.admin1Id,
    required this.admin2Id,
    required this.timezone,
    required this.population,
    required this.countryId,
    required this.country,
    required this.admin1,
    required this.admin2,
  });

  GeocodingResult copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    double? elevation,
    String? featureCode,
    String? countryCode,
    int? admin1Id,
    int? admin2Id,
    String? timezone,
    int? population,
    int? countryId,
    String? country,
    String? admin1,
    String? admin2,
  }) =>
      GeocodingResult(
        id: id ?? this.id,
        name: name ?? this.name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        elevation: elevation ?? this.elevation,
        featureCode: featureCode ?? this.featureCode,
        countryCode: countryCode ?? this.countryCode,
        admin1Id: admin1Id ?? this.admin1Id,
        admin2Id: admin2Id ?? this.admin2Id,
        timezone: timezone ?? this.timezone,
        population: population ?? this.population,
        countryId: countryId ?? this.countryId,
        country: country ?? this.country,
        admin1: admin1 ?? this.admin1,
        admin2: admin2 ?? this.admin2,
      );

  factory GeocodingResult.fromJson(String str) => GeocodingResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GeocodingResult.fromMap(Map<String, dynamic> json) => GeocodingResult(
    id: json["id"],
    name: json["name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    elevation: json["elevation"]?.toDouble(),
    featureCode: json["feature_code"],
    countryCode: json["country_code"],
    admin1Id: json["admin1_id"],
    admin2Id: json["admin2_id"],
    timezone: json["timezone"],
    population: json["population"],
    countryId: json["country_id"],
    country: json["country"],
    admin1: json["admin1"] ?? '',
    admin2: json["admin2"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "elevation": elevation,
    "feature_code": featureCode,
    "country_code": countryCode,
    "admin1_id": admin1Id,
    "admin2_id": admin2Id,
    "timezone": timezone,
    "population": population,
    "country_id": countryId,
    "country": country,
    "admin1": admin1,
    "admin2": admin2,
  };

  Location get location => Location(id: id, name: name, latitude: latitude, longitude: longitude);


}
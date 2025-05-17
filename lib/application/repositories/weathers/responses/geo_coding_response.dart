import 'dart:convert';

import '../models/geocoding_result.dart';

class GeoCodingResponse {
  final List<GeocodingResult> results;

  GeoCodingResponse({
    required this.results,
  });

  GeoCodingResponse copyWith({
    List<GeocodingResult>? results,
  }) =>
      GeoCodingResponse(
        results: results ?? this.results,
      );

  factory GeoCodingResponse.fromJson(String str) => GeoCodingResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GeoCodingResponse.fromMap(Map<String, dynamic> json) => GeoCodingResponse(
    results:json["results"] == null ? [] : List<GeocodingResult>.from(json["results"].map((x) => GeocodingResult.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "results": List<dynamic>.from(results.map((x) => x.toMap())),
  };
}
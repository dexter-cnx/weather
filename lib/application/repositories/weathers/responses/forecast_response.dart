import 'dart:convert';

import '../models/forecast.dart';
import '../models/weather.dart';


class ForecastResponse {
  final String cod;
  final int message;
  final int cnt;
  final List<ListElement> list;
  final City city;

  ForecastResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  ForecastResponse copyWith({
    String? cod,
    int? message,
    int? cnt,
    List<ListElement>? list,
    City? city,
  }) =>
      ForecastResponse(
        cod: cod ?? this.cod,
        message: message ?? this.message,
        cnt: cnt ?? this.cnt,
        list: list ?? this.list,
        city: city ?? this.city,
      );

  factory ForecastResponse.fromJson(String str) => ForecastResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ForecastResponse.fromMap(Map<String, dynamic> json) => ForecastResponse(
    cod: json["cod"],
    message: json["message"],
    cnt: json["cnt"],
    list: json["list"] == null ? []  : List<ListElement>.from(json["list"].map((x) => ListElement.fromMap(x))),
    city: City.fromMap(json["city"] ?? {}),
  );

  Map<String, dynamic> toMap() => {
    "cod": cod,
    "message": message,
    "cnt": cnt,
    "list": List<dynamic>.from(list.map((x) => x.toMap())),
    "city": city.toMap(),
  };

  List<WeatherInformation> get weatherInformationList => list.map((e)=> e.weatherInformation).toList();
}
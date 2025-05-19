import 'dart:convert';

import 'package:weather/application/repositories/weathers/models/models.dart';

import '../models/weather_units.dart';

WeatherCondition  getCondition(int code) {
  if (code >= 200 && code <600) {
    return WeatherCondition.rainy;
  }
  if (code >= 600 && code < 700) {
    return WeatherCondition.snowy;
  }
  if (code == 800) {
    return WeatherCondition.clear;
  } else if (code > 800) {
    return WeatherCondition.cloudy;
  }
  return WeatherCondition.unknown;
}

class WeatherResponse {
  final Coord coord;
  final List<WeatherStatus> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  final Rain rain;

  WeatherResponse({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
    required this.rain,
  });

  WeatherResponse copyWith({
    Coord? coord,
    List<WeatherStatus>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
    Rain? rain,
  }) =>
      WeatherResponse(
        coord: coord ?? this.coord,
        weather: weather ?? this.weather,
        base: base ?? this.base,
        main: main ?? this.main,
        visibility: visibility ?? this.visibility,
        wind: wind ?? this.wind,
        clouds: clouds ?? this.clouds,
        dt: dt ?? this.dt,
        sys: sys ?? this.sys,
        timezone: timezone ?? this.timezone,
        id: id ?? this.id,
        name: name ?? this.name,
        cod: cod ?? this.cod,
        rain: rain ?? this.rain,
      );

  factory WeatherResponse.fromJson(String str) => WeatherResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WeatherResponse.fromMap(Map<String, dynamic> json) => WeatherResponse(
    coord: Coord.fromMap(json["coord"] ?? {}),
    weather: List<WeatherStatus>.from(json["weather"].map((x) => WeatherStatus.fromMap(x))),
    base: json["base"],
    main: Main.fromMap(json["main"] ?? {}),
    visibility: json["visibility"],
    wind: Wind.fromMap(json["wind"] ?? {}),
    clouds: Clouds.fromMap(json["clouds"] ?? {}),
    dt: json["dt"],
    sys: Sys.fromMap(json["sys"] ?? {}),
    timezone: json["timezone"],
    id: json["id"],
    name: json["name"],
    cod: json["cod"],
    rain: Rain.fromMap(json['rain'] ?? {}),
  );

  Map<String, dynamic> toMap() => {
    "coord": coord.toMap(),
    "weather": List<dynamic>.from(weather.map((x) => x.toMap())),
    "base": base,
    "main": main.toMap(),
    "visibility": visibility,
    "wind": wind.toMap(),
    "clouds": clouds.toMap(),
    "dt": dt,
    "sys": sys.toMap(),
    "timezone": timezone,
    "id": id,
    "name": name,
    "cod": cod,
    "rain": rain,
  };

  WeatherInformation get weatherInformation => WeatherInformation(
    temperature: main.temp,
    humidity: main.humidity,
    condition:getCondition(weather.isNotEmpty ? weather.first.id : 0 ),
    dateTime: DateTime.fromMillisecondsSinceEpoch( dt * 1000 ),
  );
}

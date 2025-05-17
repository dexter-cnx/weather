import 'dart:convert';

import 'weather_units.dart';

class ListElement {
  final int dt;
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Sys sys;
  final DateTime dtTxt;
  final Rain rain;

  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
    required this.rain,
  });

  ListElement copyWith({
    int? dt,
    Main? main,
    List<Weather>? weather,
    Clouds? clouds,
    Wind? wind,
    int? visibility,
    double? pop,
    Sys? sys,
    DateTime? dtTxt,
    Rain? rain,
  }) =>
      ListElement(
        dt: dt ?? this.dt,
        main: main ?? this.main,
        weather: weather ?? this.weather,
        clouds: clouds ?? this.clouds,
        wind: wind ?? this.wind,
        visibility: visibility ?? this.visibility,
        pop: pop ?? this.pop,
        sys: sys ?? this.sys,
        dtTxt: dtTxt ?? this.dtTxt,
        rain: rain ?? this.rain,
      );

  factory ListElement.fromJson(String str) => ListElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
    dt: json["dt"],
    main: Main.fromMap(json["main"] ?? {}),
    weather:json["weather"] == null ? [] : List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
    clouds: Clouds.fromMap(json["clouds" ?? {}]),
    wind: Wind.fromMap(json["wind"] ?? {}),
    visibility: json["visibility"],
    pop: json["pop"]?.toDouble(),
    sys: Sys.fromMap(json["sys"] ?? {}),
    dtTxt: DateTime.parse(json["dt_txt"]),
    rain: Rain.fromMap(json["rain"] ?? {}),
  );

  Map<String, dynamic> toMap() => {
    "dt": dt,
    "main": main.toMap(),
    "weather": List<dynamic>.from(weather.map((x) => x.toMap())),
    "clouds": clouds.toMap(),
    "wind": wind.toMap(),
    "visibility": visibility,
    "pop": pop,
    "sys": sys.toMap(),
    "dt_txt": dtTxt.toIso8601String(),
    "rain": rain.toMap(),
  };
}
class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  City copyWith({
    int? id,
    String? name,
    Coord? coord,
    String? country,
    int? population,
    int? timezone,
    int? sunrise,
    int? sunset,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        coord: coord ?? this.coord,
        country: country ?? this.country,
        population: population ?? this.population,
        timezone: timezone ?? this.timezone,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
      );

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    coord: Coord.fromMap(json["coord"]  ?? {}),
    country: json["country"] ?? '',
    population: json["population"] ?? 0,
    timezone: json["timezone"] ?? 0,
    sunrise: json["sunrise"] ?? 0,
    sunset: json["sunset"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "coord": coord.toMap(),
    "country": country,
    "population": population,
    "timezone": timezone,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}
import 'dart:convert';

class Clouds {
  final int all;

  Clouds({
    required this.all,
  });

  Clouds copyWith({
    int? all,
  }) =>
      Clouds(
        all: all ?? this.all,
      );

  factory Clouds.fromJson(String str) => Clouds.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Clouds.fromMap(Map<String, dynamic> json) => Clouds(
    all: json["all"]  ?? 0.0,
  );

  Map<String, dynamic> toMap() => {
    "all": all ,
  };
}

class Coord {
  final double lon;
  final double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  Coord copyWith({
    double? lon,
    double? lat,
  }) =>
      Coord(
        lon: lon ?? this.lon,
        lat: lat ?? this.lat,
      );

  factory Coord.fromJson(String str) => Coord.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Coord.fromMap(Map<String, dynamic> json) => Coord(
    lon: json["lon"]?.toDouble()  ?? 0.0,
    lat: json["lat"]?.toDouble()  ?? 0.0,
  );

  Map<String, dynamic> toMap() => {
    "lon": lon,
    "lat": lat,
  };
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  Main copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
    int? seaLevel,
    int? grndLevel,
  }) =>
      Main(
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity,
        seaLevel: seaLevel ?? this.seaLevel,
        grndLevel: grndLevel ?? this.grndLevel,
      );

  factory Main.fromJson(String str) => Main.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Main.fromMap(Map<String, dynamic> json) => Main(
    temp: json["temp"]?.toDouble()  ?? 0.0,
    feelsLike: json["feels_like"]?.toDouble()  ?? 0.0,
    tempMin: json["temp_min"]?.toDouble()  ?? 0.0,
    tempMax: json["temp_max"]?.toDouble()  ?? 0.0,
    pressure: json["pressure"]  ?? 0,
    humidity: json["humidity"]  ?? 0,
    seaLevel: json["sea_level"]  ?? 0,
    grndLevel: json["grnd_level"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "humidity": humidity,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
  };
}

class Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  Sys copyWith({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) =>
      Sys(
        type: type ?? this.type,
        id: id ?? this.id,
        country: country ?? this.country,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
      );

  factory Sys.fromJson(String str) => Sys.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sys.fromMap(Map<String, dynamic> json) => Sys(
    type: json["type"] ?? 0,
    id: json["id"]  ?? 0,
    country: json["country"]  ?? '',
    sunrise: json["sunrise"]  ?? 0,
    sunset: json["sunset"]  ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "type": type,
    "id": id,
    "country": country,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}

class WeatherStatus {
  final int id;
  final String main;
  final String description;
  final String icon;



  WeatherStatus({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  WeatherStatus copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      WeatherStatus(
        id: id ?? this.id,
        main: main ?? this.main,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );

  factory WeatherStatus.fromJson(String str) => WeatherStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WeatherStatus.fromMap(Map<String, dynamic> json) => WeatherStatus(
    id: json["id"] ?? 0,
    main: json["main"]  ?? '',
    description: json["description"]  ?? '',
    icon: json["icon"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  Wind copyWith({
    double? speed,
    int? deg,
    double? gust,
  }) =>
      Wind(
        speed: speed ?? this.speed,
        deg: deg ?? this.deg,
        gust: gust ?? this.gust,
      );

  factory Wind.fromJson(String str) => Wind.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Wind.fromMap(Map<String, dynamic> json) => Wind(
    speed: json["speed"]?.toDouble() ?? 0.0,
    deg: json["deg"] ?? 0,
    gust: json["gust"]?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toMap() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}



class Rain {
  final double the3H;

  Rain({
    required this.the3H,
  });

  Rain copyWith({
    double? the3H,
  }) =>
      Rain(
        the3H: the3H ?? this.the3H,
      );

  factory Rain.fromJson(String str) => Rain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rain.fromMap(Map<String, dynamic> json) => Rain(
    the3H: json["3h"]?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toMap() => {
    "3h": the3H,
  };
}


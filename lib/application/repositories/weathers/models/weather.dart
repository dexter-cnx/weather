import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

extension TemperatureConversion on double {
  double kelvinToFahrenheit() => (this * 9 / 5) - 459.67;
  double kelvinToCelsius() => this - 273.15;

}
enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;

  double fromKelvin(double kelvin) => switch(this) {
    TemperatureUnits.fahrenheit =>  kelvin.kelvinToFahrenheit(),
    TemperatureUnits.celsius => kelvin.kelvinToCelsius(),
  };
}


enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

@JsonSerializable()
class WeatherInformation extends Equatable {

  final double temperature;
  final int humidity;

  final WeatherCondition condition;

  final DateTime dateTime;

  const WeatherInformation( {required this.temperature,required  this.humidity,required  this.condition,required  this.dateTime,});

  factory WeatherInformation.fromJson(Map<String, dynamic> json) =>
      _$WeatherInformationFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherInformationToJson(this);
  static final empty = WeatherInformation(
      temperature: 0.0,
      humidity: 0,
      condition: WeatherCondition.unknown,
      dateTime: DateTime.fromMillisecondsSinceEpoch(0),

  );

  @override
  List<Object> get props => [temperature,humidity,condition,dateTime];
}


@JsonSerializable()
class Weather extends Equatable {


  const Weather({
    required this.location,
    required this.weatherInfo,
  });



  // factory Weather.fromRepository(weather_repository.Weather weather) {
  //   return Weather(
  //     condition: weather.condition,
  //     lastUpdated: DateTime.now(),
  //     location: weather.location,
  //     temperature: Temperature(value: weather.temperature),
  //   );
  // }

  static final empty = Weather(
    location: '--',
    weatherInfo: WeatherInformation.empty
  );

  //final WeatherCondition condition;
  final String location;
  final WeatherInformation weatherInfo;

  @override
  List<Object> get props => [ location, weatherInfo ];

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  Weather copyWith({
    String? location,
    WeatherInformation? weatherInfo,
  }) {
    return Weather(
      location: location ?? this.location,
      weatherInfo: weatherInfo ?? this.weatherInfo,
    );
  }

  factory Weather.fromRepository(Weather weather) => weather;


}


@JsonSerializable()
class Forecast extends Equatable {


  const Forecast({
    required this.location,
    required this.weatherInfos,
  });



  // factory Weather.fromRepository(weather_repository.Weather weather) {
  //   return Weather(
  //     condition: weather.condition,
  //     lastUpdated: DateTime.now(),
  //     location: weather.location,
  //     temperature: Temperature(value: weather.temperature),
  //   );
  // }

  static final empty = Forecast(
      location: '--',
      weatherInfos: []
  );

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastToJson(this);

  //final WeatherCondition condition;
  final String location;
  final List<WeatherInformation> weatherInfos;

  @override
  List<Object> get props => [ location, weatherInfos ];



  Forecast copyWith({
    String? location,
    List<WeatherInformation>? weatherInfos,
  }) {
    return Forecast(
      location: location ?? this.location,
      weatherInfos: weatherInfos ?? this.weatherInfos,
    );
  }
}
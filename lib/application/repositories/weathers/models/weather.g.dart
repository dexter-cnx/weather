// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherInformation _$WeatherInformationFromJson(Map<String, dynamic> json) =>
    WeatherInformation(
      temperature: (json['temperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$WeatherInformationToJson(WeatherInformation instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'dateTime': instance.dateTime.toIso8601String(),
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.unknown: 'unknown',
};

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      location: json['location'] as String,
      weatherInfo: WeatherInformation.fromJson(
          json['weatherInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'location': instance.location,
      'weatherInfo': instance.weatherInfo,
    };

Forecast _$ForecastFromJson(Map<String, dynamic> json) => Forecast(
      location: json['location'] as String,
      weatherInfos: (json['weatherInfos'] as List<dynamic>)
          .map((e) => WeatherInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'location': instance.location,
      'weatherInfos': instance.weatherInfos,
    };

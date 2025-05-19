import 'package:flutter/material.dart';

import '../../repositories/weathers/models/models.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key, required this.condition});

  static const _iconSize = 75.0;

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Text(
      condition.toEmoji,
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

class WeatherIconLabel extends StatelessWidget {
  const WeatherIconLabel({super.key, required this.condition});

  static const _iconSize = 75.0;

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          condition.toEmoji,
          style: const TextStyle(fontSize: _iconSize),
        ),
        Positioned.fill(
          child: Text(
            condition.name,
            style: const TextStyle(fontSize: 13),
          ),)

      ],
    );
  }
}

extension on WeatherCondition {
  String get toEmoji {
    switch (this) {
      case WeatherCondition.clear:
        return '☀️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.cloudy:
        return '☁️';
      case WeatherCondition.snowy:
        return '🌨️';
      case WeatherCondition.unknown:
        return '❓';
    }
  }
}
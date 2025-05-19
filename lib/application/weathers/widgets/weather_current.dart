import 'package:flutter/material.dart';
import 'package:weather/application/weathers/widgets/weather_icon.dart';

import '../../repositories/weathers/models/models.dart';

class WeatherCurrent extends StatelessWidget {
  final Weather weather;
  final TemperatureUnits units;
  const WeatherCurrent({super.key,required this.weather,required this.units});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 48),
          WeatherIconLabel(condition: weather.weatherInfo.condition),
          Text(
            weather.location,
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w200,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                weather.weatherInfo.formattedTemperature(units),
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              RichText(
                text: TextSpan(
                    text: 'Humidity\n',
                    style: theme.textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: '${weather.weatherInfo.humidity} %',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]
                ),textAlign: TextAlign.end,
              ),
            ],
          ),
          //RichText(text: text),
          Text(
            '''Last Updated at ${TimeOfDay.fromDateTime(weather.weatherInfo.dateTime).format(context)}''',
          ),
        ],
      ),
    );
  }
}

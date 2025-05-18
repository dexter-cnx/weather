import 'package:equatable/equatable.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../repositories/weathers/weathers.dart';

part 'weather_cubit.g.dart';
part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherState());

  final WeatherRepository _weatherRepository;

  Future<void> fetchWeather(String city) async {
    if (city.isNotEmpty) {
      emit(state.copyWith(status: WeatherStatus.loading));
      try {


        final weather = Weather.fromRepository(
          await _weatherRepository.getWeatherByCityName(city),
        );
        // final weather = Forecast.fromRepository(
        //   await _weatherRepository.get(city),
        // );

        emit(
          state.copyWith(
            status: WeatherStatus.success,
            weather: weather,
          ),
        );
      } on Exception {
        emit(state.copyWith(status: WeatherStatus.failure));
      }
    }
    // if (city == null || city.isEmpty) return;
    //
    // emit(state.copyWith(status: WeatherStatus.loading));
    //
    // try {
    //   final weather = Weather.fromRepository(
    //     await _weatherRepository.getWeather(city),
    //   );
    //   final units = state.temperatureUnits;
    //   final value = units.isFahrenheit
    //       ? weather.temperature.value.toFahrenheit()
    //       : weather.temperature.value;
    //
    //   emit(
    //     state.copyWith(
    //       status: WeatherStatus.success,
    //       temperatureUnits: units,
    //       weather: weather.copyWith(temperature: Temperature(value: value)),
    //     ),
    //   );
    // } on Exception {
    //   emit(state.copyWith(status: WeatherStatus.failure));
    // }
  }

  Future<void> refreshWeather() async {
    // if (!state.status.isSuccess) return;
    // if (state.weather == Weather.empty) return;
    // try {
    //   final weather = Weather.fromRepository(
    //     await _weatherRepository.getWeather(state.weather.location),
    //   );
    //   final units = state.temperatureUnits;
    //   final value = units.isFahrenheit
    //       ? weather.temperature.value.toFahrenheit()
    //       : weather.temperature.value;
    //
    //   emit(
    //     state.copyWith(
    //       status: WeatherStatus.success,
    //       temperatureUnits: units,
    //       weather: weather.copyWith(temperature: Temperature(value: value)),
    //     ),
    //   );
    // } on Exception {
    //   emit(state);
    // }
  }

  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    emit(state.copyWith(temperatureUnits: units));
  }



  @override
  WeatherState fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic> toJson(WeatherState state) => state.toJson();
}



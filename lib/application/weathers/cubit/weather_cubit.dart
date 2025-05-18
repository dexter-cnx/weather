import 'package:equatable/equatable.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../application.dart';
import '../../repositories/weathers/weathers.dart';

part 'weather_cubit.g.dart';
part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherState());

  final WeatherRepository _weatherRepository;

  Future<void> fetchWeather(String city) async {
    if (city.isNotEmpty) {
      try {
        final location = await _weatherRepository.locationSearch(city);

        fetchWeatherByLocation(location);
      } on Exception  {
        emit(state.copyWith(status: WeatherStatus.failure));
      }
    }
  }

  set index(int index) {
    if (state.status.isSuccess) {
      emit(state.copyWith(currentIndex: index));
    }
  }

  Future<Location> getLocationByCity(String city) async {
    return await _weatherRepository.locationSearch(city);
  }

  Future<void> fetchWeatherByLocation(Location location) async {
    if (location.name.isNotEmpty) {
      emit(state.copyWith(status: WeatherStatus.loading));
      try {


        final weather = Weather.fromRepository(
          await _weatherRepository.getWeatherByLocation(location),
        );
        final forecast = Forecast.fromRepository(
          await _weatherRepository.getForecastByLocation(location),
        );

        emit(
          state.copyWith(
            status: WeatherStatus.success,
            weather: weather,
            forecast: forecast,
          ),
        );
      } on Exception  {
        emit(state.copyWith(status: WeatherStatus.failure));
      }
    }
  }

  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return;
    if (state.weather == Weather.empty && state.forecast == Forecast.empty) return;
    try {
      final location = await _weatherRepository.locationSearch(state.weather.location );

      final weather = Weather.fromRepository(
        await _weatherRepository.getWeatherByLocation(location),
      );
      final forecast = Forecast.fromRepository(
        await _weatherRepository.getForecastByLocation(location),
      );

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          weather: weather,
          forecast: forecast,
        ),
      );

    } on Exception {
      emit(state);
    }
  }

  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;
    logger.i(units.name);

    emit(state.copyWith(temperatureUnits: units));
  }

  @override
  WeatherState fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic> toJson(WeatherState state) => state.toJson();
}



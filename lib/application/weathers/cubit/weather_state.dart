part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

@JsonSerializable()
final class WeatherState extends Equatable {
  WeatherState( {
    this.status = WeatherStatus.initial,
    this.temperatureUnits = TemperatureUnits.celsius,
    this.currentIndex = 0,
    Weather? weather,
    Forecast? forecast,
  }) : weather = weather ?? Weather.empty, forecast = forecast ?? Forecast.empty;

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);

  final WeatherStatus status;
  final Weather weather;
  final Forecast forecast;

  final int currentIndex;

  final TemperatureUnits temperatureUnits;


  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    Forecast? forecast,
    Weather? weather,
    int? currentIndex,
  }) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      forecast: forecast ?? this.forecast,
      weather: weather ?? this.weather,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  @override
  List<Object?> get props => [status,  weather, forecast , temperatureUnits ,currentIndex];
}

# Weather - Weather forecast application

Weather is a Weather forecast application , user can enter city name and see how the weather will be for today for both current time amd whole-day forecast.

## Supported Platforms
- Android
- iOS
- Web
- 


## Installation
**Requirements**:
- Flutter SDK v3.29.3+
- Dart 3.7.2

1. Install Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
2. Clone the repository:

git clone https://github.com/dexter-cnx/weather.git

3. Navigate to the project folder and install dependencies:

cd weather
flutter pub get

4. Run the app on your desired platform:
- Connect your device or start an emulator.

flutter run

## Testing

-To run unit tests:

flutter test

-To run app tests:

flutter test  test/app_test.dart

-To run location modules tests:

flutter test  test/location

-To run search modules tests:

flutter test  test/search

-To run weather modules tests:

flutter test  test/weather


## Build
- Android
  flutter build aab
 - or 
 flutter build apk

- iOS
  flutter build ios

- Web
  flutter build web


# Flut Cast

> FlutCast is your ultimate weather companion powered by Flutter. Stay ahead of the forecast with real-time weather updates for your favorite cities. Explore current conditions, hourly forecasts, and long-range predictions effortlessly. With features like city selection, login, and favorites, FlutCast makes it easy to stay informed about the weather no matter where you are. Download now and experience the seamless integration of weather information and Flutter technology.
---

## API Usage

FlutCast utilizes the [One Call API 3.0][one_call] provided by a third-party weather service to retrieve weather data. This API offers extensive weather information including current weather conditions, hourly forecasts, and daily forecasts for any location around the world.

### Subscription and Usage Limits

To access the [One Call API 3.0][one_call], you need to subscribe to the service and provide your payment information. Upon subscription, you'll receive 1000 free API calls per day. Please note that exceeding this limit may result in additional charges based on the pricing plan of the service provider.

For more information about subscription plans, usage limits, and pricing, please visit the official website of the [weather service provider][openweathermap].

---

## Key Features:

- **City Selection:** Choose specific cities from around the world and instantly view detailed weather information for each selected location. Whether you're planning a trip or simply curious about the weather elsewhere, FlutCast has you covered.

- **Authentication:** Safeguard your account and securely access FlutCast through the authentication process.

- **Favorite Cities:** Keep track of your most frequently visited or preferred cities by adding them to your favorites list. Easily access weather updates for these cities with just a tap, ensuring you're always prepared for changing conditions.

- **Advanced Internationalization System (i18n):** FlutCast provides seamless support for multiple languages through its advanced internationalization system. Enjoy a localized experience tailored to your language and region, ensuring clarity and ease of use for users around the globe.

---
## Getting Started 🚀

> First, create the file `launch.json` in the `.vscode` folder following the example `launch.json.example`, and add the values of the `dart-define (Environment variables)` in the `toolArgs` parameter.

Now you must execute the following commands to obtain the packages and generate the necessary code:

- Get flutter dependencies in the project
```sh
$ make fc_packages
# or
$ flutter pub get
```
- Generate neccessary code 
```sh
$ make fc_build
# or
$ dart run build_runner build --delete-conflicting-outputs
```
- Generate localizations
```sh
$ make fc_slang
# or 
$ dart run slang
```
- Generate neccesary code in package FC Api Client
```sh
$ make fc_api_client_build
# or
$ cd packages/fc_api_client && dart run build_runner build --delete-conflicting-outputs
```
- Generate neccesary code in package FC Common
```sh
$ fc_common_build:
# or
$ cd packages/fc_common && dart run build_runner build --delete-conflicting-outputs
```
- Generate neccesary code in package FC Api Domain
```sh
$ make fc_domain_build
# or
$ cd packages/fc_domain && dart run build_runner build --delete-conflicting-outputs
```
---


This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```
_\*Flut Cast works on Android and iOS._

---

## Working with Translations 🌐

This project relies on [slang][slang_link] type-safe i18n solution using JSON files.

### Adding Strings

1. To add a new localizable strings, open the `myFeatureName.json` file at `lib/i18n/en/myFeatureName.json`.

```json
{
    "appName": "Flut Cast"
}
```

2. Then add a new key/value and description

```json
{
    "appName": "Flut Cast"
}
```

3. Use the new string

```dart
import 'package:flut_cast/i18n/translations.g.dart';

@override
Widget build(BuildContext context) {
  return Text(texts.misc.appName);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new Json file in `lib/i18n`.

```
├── i18n
│   ├── en
│   │   ├── misc.json
│   │   ├── myFeature.json
│   ├── es
│   │   ├── misc.json
│   │   ├── myFeature.json
```

2. Add the translated strings to each `.json` file:

> IMPORTANT: slang does not support \_ or - for file names. You must use camelcase. Example `myFeatureName.json`

`i18n/en/myFeatureName.json`

```json
{
    "appName": "Flut Cast",
    "temperature": "Temperature"
}
```

`i18n/es/myFeatureName.json`

```json
{
    "appName": "Flut Cast",
    "temperature": "Temperatura"
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

```sh
$ make fc_slang
# or
$ dart run slang
```

---

## Contributions
Contributions to this project are welcome! Whether it's bug fixes, feature enhancements, or documentation improvements, feel free to submit a pull request.

---

## License
This project is licensed under the MIT License - see the [LICENSE][licence_link] file for details.

---

> Feel free to customize and expand upon this README description based on the specifics of your project!

[slang_link]:https://pub.dev/packages/slang
[licence_link]: https://github.com/br-programmer/flut_cast/blob/main/LICENSE
[one_call]: https://openweathermap.org/api/one-call-3
[openweathermap]: https://openweathermap.org/api/

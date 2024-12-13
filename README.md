# Flutter Locations
`flutter_locations` is an easy to use userstory that provides a map where locations are shown with a marker and a card showing more information about all the markers in view.

Through the configuration of the userstory most things can be customized to your liking. The map is using platform_maps_flutter to show a map that is based on the platform that is running the app. This means that on iOS it will show Apple Maps and on Android/Web it will show Google Maps. For use on desktop and during development there is an option to use OpenStreetMaps variant.


## Setup

The example app that is in the example folder is a good starting point to see how the userstory can be used. To use the userstory in your own app you can add the following to your pubspec.yaml file:

```yaml
dependencies:
  flutter_locations:
    hosted: https://forgejo.internal.iconica.nl/api/packages/internal/pub
    version: `^latest_version`
```

For the example the platform files need to be generated. This can be done by running the following commands in the example folder:
```bash
flutter create .
```

In the LocationMapOptions class you can enable/disable the google maps implementation that is displayed in the app.
In this example it is set to true so that open maps is used instead of google maps because it does not require an API key.
So before setting it to false you need to provide a google maps API key in the AndroidManifest.xml file. For apple it will automatically switch to apple maps.

```dart
LocationMapOptions(
    enableOpenMapsTileLayer: true,
)
```

For the features of this userstory permissions are required for each platform.

<details>
<summary>Android</summary>
```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

</details>
<details>
<summary>iOS</summary>
```xml
```

</details>
<details>
<summary>macos</summary>
```xml
For macos you need to add the following entitlements to the macos/Runner/DebugProfile.entitlements and macos/Runner/Release.entitlements files:

```xml
<key>com.apple.security.network.client</key>
<true/>
```
<details>
<summary>Web</summary>
```xml
```
</details>
<details>
<summary>Windows</summary>
```xml
```
</details>
<details>
<summary>Linux</summary>
```xml
```
</details>

See [Geolocator permissions](https://pub.dev/packages/geolocator#usage) for more information about the permissions that are required for the geolocator package that is used.
See [Flutter maps documentation](https://docs.fleaflet.dev/getting-started/installation) for more information about the underlying flutter_map package that is used.


## How to use

You can add the userstory to your app by adding the following code to your widget tree:
```dart
LocationsUserStory(
          options: LocationsOptions(
            respositoryInterface: LocationsLocalRepository(density: 7),
            mapOptions: const LocationsMapOptions(
              zoom: 7,
              initialLocation: Location(
                latitude: 52.2056435,
                longitude: 5.2,
              ),
            ),
          ),
        ),
``` 

A full example is in the example folder.

## Issues
Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_locations/pulls) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute
If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](../CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_locations/pulls).

## Author
This `flutter_locations` for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>


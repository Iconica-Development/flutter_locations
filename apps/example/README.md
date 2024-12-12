# Flutter location example

This app demonstrates the flutter locations userstory.

You can create the app by running the following command:

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

The following permissions are required in the AndroidManifest.xml file:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

For macos you need to add the following entitlements to the macos/Runner/DebugProfile.entitlements and macos/Runner/Release.entitlements files:

```xml
<key>com.apple.security.network.client</key>
<true/>
```

See [Flutter maps documentation](https://docs.fleaflet.dev/getting-started/installation) for more information.


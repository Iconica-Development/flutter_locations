import "package:device_preview/device_preview.dart";
import "package:flutter/material.dart";
import "package:flutter_locations/flutter_locations.dart";
import "package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart";

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      isToolbarVisible: true,
      availableLocales: const [
        Locale("en_US"),
        Locale("nl_NL"),
      ],
      builder: (_) => const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        builder: DevicePreview.appBuilder,
        locale: DevicePreview.locale(context),
        supportedLocales: const [
          Locale("en", "US"),
          Locale("nl", "NL"),
        ],
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: LocationsUserStory(
          options: LocationsOptions(
            respositoryInterface: LocationsLocalRepository(density: 7),
            mapOptions: LocationsMapOptions(
              zoom: 7,
              initialLocation: const Location(
                latitude: 52.2056435,
                longitude: 5.2,
              ),
              // Openmaps works without an API key
              enableOpenMapsTileLayer: true,
              tileProvider: CancellableNetworkTileProvider(),
            ),
          ),
        ),
      );
}

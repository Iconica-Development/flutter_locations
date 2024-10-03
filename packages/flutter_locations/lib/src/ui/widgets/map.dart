import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_locations/src/util/scope.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:platform_maps_flutter/platform_maps_flutter.dart"
    as platform_maps;

/// A map that can display locations.
class LocationsMap extends HookWidget {
  ///
  const LocationsMap({
    super.key,
  });

  ///

  @override
  Widget build(BuildContext context) {
    var options = LocationsScope.of(context).options.mapOptions;
    var defaultZoom = (options.initialLocation == null) ? 7.25 : 10.0;
    var controller = useState(MapController());
    var platformMapController =
        useState<platform_maps.PlatformMapController?>(null);

    Widget buildPlatformSpecificMap() => platform_maps.PlatformMap(
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: false,
          initialCameraPosition: platform_maps.CameraPosition(
            target: platform_maps.LatLng(
              options.initialLocation?.latitude ?? 0,
              options.initialLocation?.longitude ?? 0,
            ),
            zoom: options.zoom ?? 10.0,
          ),
          onMapCreated: (controller) {
            platformMapController.value = controller;
          },
        );

    var search = options.searchBuilder(context, print, Icons.search);
    var initialLocation = options.initialLocation ?? const LatLng(0, 0);
    var initialZoom = options.zoom ?? defaultZoom;

    var layers = [
      ...options.additionalLayers,
    ];

    var mapControls = Wrap(
      spacing: options.controlsSpacing,
      direction: Axis.vertical,
      children: [
        options.controlBuilder(
          context,
          Icons.pin_drop,
          () {},
        ),
        options.controlBuilder(
          context,
          Icons.gps_fixed,
          () {},
        ),
        options.controlBuilder(
          context,
          Icons.add,
          () => controller.value.move(
            controller.value.camera.center,
            controller.value.camera.zoom + 1,
          ),
        ),
        options.controlBuilder(
          context,
          Icons.remove,
          () => controller.value.move(
            controller.value.camera.center,
            controller.value.camera.zoom - 1,
          ),
        ),
      ],
    );

    // ignore: avoid_positional_boolean_parameters
    Future<void> alignMaps(MapCamera position, bool hasGesture) async =>
        await platformMapController.value?.moveCamera(
          platform_maps.CameraUpdate.newCameraPosition(
            platform_maps.CameraPosition(
              target: platform_maps.LatLng(
                position.center.latitude,
                position.center.longitude,
              ),
              zoom: position.zoom,
            ),
          ),
        );

    void initializeMaps() {
      controller.value.move(
        initialLocation,
        initialZoom,
      );
      options.onMapReady?.call();
    }

    return Scaffold(
      floatingActionButtonLocation: options.controlsPosition,
      floatingActionButton: (options.showControls) ? mapControls : null,
      body: Stack(
        children: [
          Stack(
            children: [
              buildPlatformSpecificMap(),
              FlutterMap(
                mapController: controller.value,
                options: MapOptions(
                  onPositionChanged: alignMaps,
                  backgroundColor: Colors.transparent,
                  initialCenter: initialLocation,
                  initialZoom: initialZoom,
                  onMapReady: initializeMaps,
                ),
                children: layers,
              ),
              search,
            ],
          ),
        ],
      ),
    );
  }
}

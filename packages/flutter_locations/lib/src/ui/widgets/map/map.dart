import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_locations/flutter_locations.dart";
import "package:flutter_locations/src/util/scope.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart";
import "package:latlong2/latlong.dart";
import "package:platform_maps_flutter/platform_maps_flutter.dart"
    as platform_maps;

/// A map that can display locations.
class LocationsMap extends HookWidget {
  /// [LocationsMap] constructor
  const LocationsMap({
    required this.controller,
    required this.locationStream,
    required this.onSetBounds,
    super.key,
  });

  /// [MapController] used for map movement.
  final MapController controller;

  /// Variable [LocationItem] stream based on filter.
  final Stream<List<LocationItem>> locationStream;

  /// Callback used to set the bounds in the parent widget
  final void Function(LatLngBounds) onSetBounds;

  @override
  Widget build(BuildContext context) {
    var options = LocationsScope.of(context).options.mapOptions;
    var defaultZoom = (options.initialLocation == null) ? 7.25 : 10.0;
    var platformMapController =
        useState<platform_maps.PlatformMapController?>(null);
    var markers = useState(<Marker>[]);

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

    var initialLocation =
        options.initialLocation ?? const Location(latitude: 0, longitude: 0);
    var initialLatLng =
        LatLng(initialLocation.latitude, initialLocation.longitude);
    var initialZoom = options.zoom ?? defaultZoom;

    locationStream.listen(
      (locationItems) => markers.value = locationItems
          .map(
            (e) => Marker(
              point: LatLng(e.location.latitude, e.location.longitude),
              child: options.markerBuilder(context, e),
            ),
          )
          .toList(),
    );

    var layers = [
      MarkerClusterLayerWidget(
        options: MarkerClusterLayerOptions(
          markers: markers.value,
          maxClusterRadius: 45,
          size: const Size(40, 40),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(50),
          maxZoom: 15,
          builder: (context, markers) => DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                markers.length.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      ...options.additionalLayers,
    ];

    // ignore: avoid_positional_boolean_parameters
    Future<void> alignMaps(MapCamera position, bool hasGesture) async {
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
      onSetBounds(position.visibleBounds);
    }

    void initializeMaps() {
      controller.move(
        initialLatLng,
        initialZoom,
      );
      options.onMapReady?.call();
    }

    return Stack(
      children: [
        buildPlatformSpecificMap(),
        FlutterMap(
          mapController: controller,
          options: MapOptions(
            onPositionChanged: alignMaps,
            backgroundColor: Colors.transparent,
            initialCenter: initialLatLng,
            initialZoom: initialZoom,
            onMapReady: initializeMaps,
          ),
          children: layers,
        ),
      ],
    );
  }
}

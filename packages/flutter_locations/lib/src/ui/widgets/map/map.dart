import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_locations/src/config/flutter_locations_config.dart";
import "package:flutter_locations/src/util/scope.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart";
import "package:platform_maps_flutter/platform_maps_flutter.dart"
    as platform_maps;

/// A map that can display locations.
class LocationsMap extends HookWidget {
  ///
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
    var locationsOptions = LocationsScope.of(context).options;
    var mapOptions = locationsOptions.mapOptions;
    var config = locationsOptions.mapConfiguration;
    var defaultZoom = config.initialCameraZoom;
    var initialZoom = mapOptions.zoom ?? defaultZoom;
    var initialLocation = config.initialCameraPosition;
    var controller = useState(MapController());

    var platformMapController =
        useState<platform_maps.PlatformMapController?>(null);
    var markers = useState(<Marker>[]);

    // ignore: lines_longer_than_80_chars, flutter_style_todos
    // TODO: config.poiListStyle is not used and can only be used directly in component GoogleMap.style, controller setMapStyle is deprecated.
    Widget buildPlatformSpecificMap() => platform_maps.PlatformMap(
          myLocationEnabled: config.isMyLocationEnabled,
          zoomControlsEnabled: config.isZoomCameraControlEnabled,
          zoomGesturesEnabled: config.isZoomCameraControlEnabled,
          minMaxZoomPreference: platform_maps.MinMaxZoomPreference(
            config.minimumCameraZoomLevel,
            config.maximumCameraZoomLevel,
          ),
          rotateGesturesEnabled: config.isRotateCameraControlEnabled,
          scrollGesturesEnabled: config.isMoveCameraControlEnabled,
          tiltGesturesEnabled: config.isTiltCameraControlEnabled,
          trafficEnabled: config.isTrafficEnabled,
          compassEnabled: config.isCompassShown,
          mapType: switch (config.mapType) {
            MapType.normal => platform_maps.MapType.normal,
            MapType.satellite => platform_maps.MapType.satellite,
            MapType.hybrid => platform_maps.MapType.hybrid,
          },
          initialCameraPosition: platform_maps.CameraPosition(
            target: platform_maps.LatLng(
              initialLocation.latitude,
              initialLocation.longitude,
            ),
            zoom: initialZoom,
            tilt: config.initialCameraTilt,
            bearing: config.initialCameraBearing,
          ),
          onMapCreated: (controller) {
            platformMapController.value = controller;
          },
        );

    var search = mapOptions.searchBuilder(context, print, Icons.search);

    locationStream.listen(
      (locationItems) => markers.value = locationItems
          .map(
            (e) => Marker(
              point: LatLng(e.location.latitude, e.location.longitude),
              child: mapOptions.markerBuilder(context, e),
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
      ...mapOptions.additionalLayers,
    ];

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
      mapOptions.onMapReady?.call();
    }

    return Stack(
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
    );
  }
}

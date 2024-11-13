import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_locations/flutter_locations.dart";
import "package:flutter_locations/src/util/scope.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:platform_maps_flutter/platform_maps_flutter.dart"
    as platform_maps;

/// A map that can display locations.
class LocationsMap extends HookWidget {
  ///
  const LocationsMap({
    this.controller,
    super.key,
  });

  ///
  final MapController? controller;

  ///

  @override
  Widget build(BuildContext context) {
    var repository = LocationsScope.of(context).options.respositoryInterface;
    var options = LocationsScope.of(context).options.mapOptions;
    var defaultZoom = (options.initialLocation == null) ? 7.25 : 10.0;
    var mapController = useState(controller ?? MapController());
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

    var bounds = useState<LatLngBounds?>(null);
    var query = useState("");

    var search = options.searchBuilder(
      context,
      (value) => query.value = value,
      Icons.search,
    );

    repository
        .getLocations(
          filter: LocationsFilter(
            bounds: bounds.value != null
                ? LocationBounds(
                    northWest: Location(
                      latitude: bounds.value!.north,
                      longitude: bounds.value!.west,
                    ),
                    southEast: Location(
                      latitude: bounds.value!.south,
                      longitude: bounds.value!.east,
                    ),
                  )
                : null,
            query: query.value.isNotEmpty ? query.value : null,
          ),
        )
        .listen(
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
      MarkerLayer(markers: markers.value),
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
      bounds.value = position.visibleBounds;
    }

    void initializeMaps() {
      mapController.value.move(
        initialLatLng,
        initialZoom,
      );
      options.onMapReady?.call();
    }

    return Scaffold(
      floatingActionButtonLocation: options.controlsOptions.controlsPosition,
      floatingActionButton: (options.controlsOptions.showControls)
          ? options.controlsOptions
              .controlsBuilder(context, mapController.value)
          : null,
      body: Stack(
        children: [
          Stack(
            children: [
              buildPlatformSpecificMap(),
              FlutterMap(
                mapController: mapController.value,
                options: MapOptions(
                  onPositionChanged: alignMaps,
                  backgroundColor: Colors.transparent,
                  initialCenter: initialLatLng,
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

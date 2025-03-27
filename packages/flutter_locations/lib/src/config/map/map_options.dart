import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:flutter/material.dart";
import "package:flutter_locations/src/config/map/controls_options.dart";
import "package:flutter_locations/src/ui/widgets/defaults/map/marker.dart";
import "package:flutter_locations/src/ui/widgets/defaults/map/search.dart";
import "package:flutter_map/flutter_map.dart";

/// Class holding all the options for [LocationsUserStory]
class LocationsMapOptions {
  /// [LocationsMapOptions] constructor
  const LocationsMapOptions({
    this.zoom,
    this.maxZoom = 18.0,
    this.minZoom = 3.0,
    this.initialLocation = const Location(latitude: 0, longitude: 0),
    this.additionalLayers = const [],
    this.onMapReady,
    this.searchBuilder = DefaultLocationsMapSearch.builder,
    this.markerBuilder = DefaultLocationsMapMarker.builder,
    this.controlsOptions = const LocationsMapControlsOptions.empty(),
    this.enableOpenMapsTileLayer = false,
    this.tileProvider,
  });

  ///
  const LocationsMapOptions.empty({
    this.additionalLayers = const [],
    this.initialLocation = const Location(latitude: 0, longitude: 0),
    this.zoom,
    this.maxZoom = 18.0,
    this.minZoom = 3.0,
    this.onMapReady,
    this.searchBuilder = DefaultLocationsMapSearch.builder,
    this.markerBuilder = DefaultLocationsMapMarker.builder,
    this.controlsOptions = const LocationsMapControlsOptions.empty(),
    this.enableOpenMapsTileLayer = false,
    this.tileProvider,
  });

  /// The layers containing everything other than the actual tilelayer.
  final List<Widget> additionalLayers;

  /// The location the map centers on initially.
  final Location? initialLocation;

  /// A callback which is triggered when the map has loaded.
  final VoidCallback? onMapReady;

  /// A double containing the zoom level currently used by the MapController.
  final double? zoom;

  /// A double containing the maximum zoom level for the map if not set it will
  /// default to 18.0.
  /// Setting this higher might cause the map to zoom in further than the native
  /// maps can handle.
  final double maxZoom;

  /// A double containing the minimum zoom level for the map if not set it will
  /// default to 3.0.
  /// Setting this lower might cause the map to zoom out further than the native
  /// maps can handle.
  final double minZoom;

  /// Builds the search bar
  final LocationMapSearchBuilder searchBuilder;

  ///
  final LocationMapMarkerBuilder markerBuilder;

  ///
  final LocationsMapControlsOptions controlsOptions;

  /// Enables the open maps tile layer from flutter_map that uses openstreetmap.
  /// If this is set to true, the platform maps will be disabled.
  final bool enableOpenMapsTileLayer;

  /// [TileProvider] used of the openmaps tile layer. This can be used to add
  /// CancellableNetworkTileProvider or other tile providers to improve
  /// performance without creating a dependency in flutter_locations.
  final TileProvider? tileProvider;
}

///
typedef LocationMapSearchBuilder = Widget Function(
  BuildContext context,
  ValueChanged<String> onInput,
  IconData icon,
);

///
typedef LocationMapMarkerBuilder = Widget Function(
  BuildContext context,
  LocationItem locationItem,
);

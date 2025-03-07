import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:flutter/material.dart";
import "package:flutter_locations/src/config/map/controls_options.dart";
import "package:flutter_locations/src/ui/widgets/defaults/map/marker.dart";
import "package:flutter_locations/src/ui/widgets/defaults/map/search.dart";

/// Class holding all the options for [LocationsUserStory]
class LocationsMapOptions {
  /// [LocationsMapOptions] constructor
  const LocationsMapOptions({
    this.zoom,
    this.initialLocation = const Location(latitude: 0, longitude: 0),
    this.additionalLayers = const [],
    this.onMapReady,
    this.searchBuilder = DefaultLocationsMapSearch.builder,
    this.markerBuilder = DefaultLocationsMapMarker.builder,
    this.controlsOptions = const LocationsMapControlsOptions.empty(),
  });

  ///
  const LocationsMapOptions.empty({
    this.additionalLayers = const [],
    this.initialLocation = const Location(latitude: 0, longitude: 0),
    this.zoom,
    this.onMapReady,
    this.searchBuilder = DefaultLocationsMapSearch.builder,
    this.markerBuilder = DefaultLocationsMapMarker.builder,
    this.controlsOptions = const LocationsMapControlsOptions.empty(),
  });

  /// The layers containing everything other than the actual tilelayer.
  final List<Widget> additionalLayers;

  /// The location the map centers on initially.
  final Location? initialLocation;

  /// A callback which is triggered when the map has loaded.
  final VoidCallback? onMapReady;

  /// A double containing the zoom level currently used by the MapController.
  final double? zoom;

  /// Builds the search bar
  final LocationMapSearchBuilder searchBuilder;

  ///
  final LocationMapMarkerBuilder markerBuilder;

  ///
  final LocationsMapControlsOptions controlsOptions;
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

import "package:flutter/material.dart";
import "package:flutter_locations/src/ui/widgets/defaults/map_controls.dart";
import "package:flutter_locations/src/ui/widgets/defaults/map_search.dart";

/// Class holding all the options for [LocationsUserStory]
class LocationsMapOptions {
  /// [LocationsMapOptions] constructor
  const LocationsMapOptions({
    this.zoom,
    this.additionalLayers = const [],
    this.onMapReady,
    this.controlBuilder = DefaultLocationsMapControl.builder,
    this.controlsSpacing = 4.0,
    this.searchBuilder = DefaultLocationsMapSearch.builder,
    this.controlsPosition = FloatingActionButtonLocation.endFloat,
  });

  ///
  const LocationsMapOptions.empty({
    this.additionalLayers = const [],
    this.zoom,
    this.onMapReady,
    this.controlsPosition = FloatingActionButtonLocation.endFloat,
    this.controlsSpacing = 4.0,
    this.controlBuilder = DefaultLocationsMapControl.builder,
    this.searchBuilder = DefaultLocationsMapSearch.builder,
  });

  /// The layers containing everything other than the actual tilelayer.
  final List<Widget> additionalLayers;

  /// A callback which is triggered when the map has loaded.
  final VoidCallback? onMapReady;

  /// A double containing the zoom level currently used by the MapController.
  final double? zoom;

  /// The location of the map controls
  final FloatingActionButtonLocation controlsPosition;

  /// Builds the individual controls
  final LocationMapControlBuilder controlBuilder;

  /// Builds the search bar
  final LocationMapSearchBuilder searchBuilder;

  /// The space between control elements
  final double controlsSpacing;
}

///
typedef LocationMapControlBuilder = Widget Function(
  BuildContext context,
  IconData icon,
  VoidCallback onTap,
);

///
typedef LocationMapSearchBuilder = Widget Function(
  BuildContext context,
  ValueChanged<String> onInput,
  IconData icon,
);

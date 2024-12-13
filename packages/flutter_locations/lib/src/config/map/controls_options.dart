import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:flutter/material.dart";
import "package:flutter_locations/src/ui/widgets/defaults/map/controls.dart";
import "package:flutter_map/flutter_map.dart";

/// Class holding all the options for [LocationsUserStory]
class LocationsMapControlsOptions {
  /// [LocationsMapControlsOptions] constructor
  const LocationsMapControlsOptions({
    this.showControls = true,
    this.controlsSpacing = 4.0,
    this.controlsPosition = FloatingActionButtonLocation.endFloat,
    this.controlsBuilder = DefaultLocationsMapControls.builder,
    this.controlBuilder = DefaultLocationsMapControl.builder,
    List<MapControl>? controls,
  }) : _controls = controls;

  ///
  const LocationsMapControlsOptions.empty({
    this.showControls = true,
    this.controlsSpacing = 4.0,
    this.controlsPosition = FloatingActionButtonLocation.endFloat,
    this.controlsBuilder = DefaultLocationsMapControls.builder,
    this.controlBuilder = DefaultLocationsMapControl.builder,
    List<MapControl>? controls,
  }) : _controls = controls;

  /// Should the zoom controls be shown or hidden.
  final bool showControls;

  /// The space between control elements
  final double controlsSpacing;

  /// The location of the map controls
  final FloatingActionButtonLocation controlsPosition;

  ///
  final LocationMapControlsBuilder controlsBuilder;

  /// Builds the individual controls
  final LocationMapControlBuilder controlBuilder;

  /// List of map controls
  final List<MapControl>? _controls;

  /// Gets a list of [MapControl]s only returns an empty list
  /// when controls is explicitly set to []
  List<MapControl> get controls =>
      _controls ?? LocationsMapControlsOptions.defaultControls();

  /// The default [MapControl]s
  static List<MapControl> defaultControls() => [
        MapControl.pinDrop(),
        MapControl.gps(),
        MapControl.zoomIn(),
        MapControl.zoomOut(),
      ];
}

///
class MapControl {
  ///
  MapControl({
    required this.onPressed,
    this.child,
    this.icon,
    this.controller,
    Stream<bool> Function(LocationsRepositoryInterface)? enabled,
  })  : enabled = enabled ?? ((_) => Stream.value(false)),
        assert(
          !(child != null && icon != null),
          "You need to pass either an icon or a child",
        );

  /// Pin drop [MapControl]
  factory MapControl.pinDrop() => MapControl(
        icon: Icons.pin_drop,
        onPressed: (controller, repository) async =>
            repository.toggleCurrentLocationMarker(),
        enabled: (repository) => repository.isCurrentLocationMarkerEnabled(),
      );

  /// Gps [MapControl]
  factory MapControl.gps() => MapControl(
        icon: Icons.gps_fixed,
        onPressed: (_, __) {},
      );

  /// Zoom in [MapControl]
  factory MapControl.zoomIn() => MapControl(
        icon: Icons.add,
        onPressed: (controller, __) => controller.move(
          controller.camera.center,
          controller.camera.zoom + 1,
        ),
      );

  /// Zoom out [MapControl]
  factory MapControl.zoomOut() => MapControl(
        icon: Icons.remove,
        onPressed: (controller, __) => controller.move(
          controller.camera.center,
          controller.camera.zoom - 1,
        ),
      );

  ///
  final void Function(
    MapController controller,
    LocationsRepositoryInterface repository,
  ) onPressed;

  ///
  final MapController? controller;

  ///
  final Widget? child;

  ///
  final IconData? icon;

  /// Whether the control is enabled, this is a stream to allow the control to
  /// update without the user clicking.
  /// By default, this is always false. Because not all controls have an enabled
  /// state
  final Stream<bool> Function(LocationsRepositoryInterface) enabled;
}

/// The interface for building a control collection
/// [repository] is the location repository and is used for some of the controls
/// to interact with the map through the repository.
typedef LocationMapControlsBuilder = Widget Function(
  BuildContext context,
  MapController controller,
  LocationsRepositoryInterface repository,
);

/// The interface for building a map control
typedef LocationMapControlBuilder = Widget Function(
  BuildContext context,
  IconData icon,
  VoidCallback onTap,
  Stream<bool> enabled,
);

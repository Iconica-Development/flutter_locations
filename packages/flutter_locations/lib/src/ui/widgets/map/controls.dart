import "package:flutter/material.dart";
import "package:flutter_locations/src/util/scope.dart";
import "package:flutter_map/flutter_map.dart";

/// Wrapper for the map controls builder
class LocationsMapControls extends StatelessWidget {
  /// [LocationsMapControls] constructor
  const LocationsMapControls({
    required this.mapController,
    super.key,
  });

  /// [MapController] that is acted upon by the controls.
  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    var options = LocationsScope.of(context).options;
    var controlOptions = options.mapOptions.controlsOptions;
    var repository = options.respositoryInterface;
    return controlOptions.showControls
        ? controlOptions.controlsBuilder(
            context,
            mapController,
            repository,
          )
        : const SizedBox.shrink();
  }
}

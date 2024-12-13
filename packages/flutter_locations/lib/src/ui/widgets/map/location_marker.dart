import "package:flutter/material.dart";
import "package:flutter_locations/src/util/scope.dart";
import "package:flutter_map_location_marker/flutter_map_location_marker.dart";

///
class CurrentLocationMarker extends StatelessWidget {
  ///
  const CurrentLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    var options = LocationsScope.of(context).options;
    var repository = options.respositoryInterface;
    var currentLocationMarkerEnabled =
        repository.isCurrentLocationMarkerEnabled();

    return StreamBuilder<bool>(
      stream: currentLocationMarkerEnabled,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return CurrentLocationLayer(
            alignDirectionOnUpdate: AlignOnUpdate.never,
            headingStream: const Stream.empty(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

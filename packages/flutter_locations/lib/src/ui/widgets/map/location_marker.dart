import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_locations/src/util/scope.dart";
import "package:flutter_map_location_marker/flutter_map_location_marker.dart";

/// A widget that displays the current location marker and dynamically aligns
/// the position based on the repository state.
class CurrentLocationMarker extends HookWidget {
  ///
  const CurrentLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    var options = LocationsScope.of(context).options;
    var repository = options.respositoryInterface;

    var currentLocationMarkerEnabled = useStream(
      repository.isCurrentLocationMarkerEnabled(),
      initialData: true,
    );

    var isGpsFollowActive =
        useStream(repository.isGpsFollowActive(), initialData: true);

    if (!(currentLocationMarkerEnabled.data ?? false)) {
      return const SizedBox.shrink();
    }

    return CurrentLocationLayer(
      // force the widget to rebuild when the gps follow state changes
      key: ValueKey(isGpsFollowActive.data),
      alignPositionOnUpdate: isGpsFollowActive.data ?? false
          ? AlignOnUpdate.always
          : AlignOnUpdate.never,
      alignDirectionOnUpdate: AlignOnUpdate.never,
      headingStream: const Stream.empty(),
    );
  }
}

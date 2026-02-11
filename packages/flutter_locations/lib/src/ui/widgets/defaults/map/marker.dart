import "package:flutter/material.dart";
import "package:flutter_locations/flutter_locations.dart";

/// The default marker widget.
class DefaultLocationsMapMarker extends StatelessWidget {
  /// Constructor receiving a [LocationItem].
  const DefaultLocationsMapMarker({
    required this.locationItem,
    super.key,
  });

  /// Location information
  final LocationItem locationItem;

  /// Marker building function
  static Widget builder(
    BuildContext context,
    LocationItem locationItem,
  ) =>
      DefaultLocationsMapMarker(locationItem: locationItem);

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.surfaceTint,
          ),
          height: 10,
          width: 10,
        ),
      );
}

///
class DefaultLocationsMapMarkerCluster extends StatelessWidget {
  ///
  const DefaultLocationsMapMarkerCluster({
    required this.markers,
    super.key,
  });

  ///
  final List<Marker> markers;

  ///
  static Widget builder(
    BuildContext context,
    List<Marker> markers,
  ) =>
      DefaultLocationsMapMarkerCluster(markers: markers);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surfaceTint,
        ),
        child: Center(
          child: Text(
            markers.length.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
}

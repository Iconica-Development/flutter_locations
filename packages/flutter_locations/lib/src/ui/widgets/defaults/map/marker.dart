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
            color: Theme.of(context).primaryColor,
          ),
          height: 10,
          width: 10,
        ),
      );
}

import "package:flutter/material.dart";
import "package:flutter_locations/flutter_locations.dart";
import "package:flutter_locations/src/util/scope.dart";

/// Widget holding the builder.
class LocationsList extends StatelessWidget {
  /// [LocationsList] Constructor
  const LocationsList({
    required this.locationStream,
    super.key,
  });

  /// Stream of locations.
  final Stream<List<LocationItem>> locationStream;

  @override
  Widget build(BuildContext context) {
    var options = LocationsScope.of(context).options.listOptions;
    return options.listBuilder(context, locationStream);
  }
}

import "package:flutter/material.dart";
import "package:flutter_locations/src/config/locations_options.dart";
import "package:flutter_locations/src/ui/widgets/home.dart";
import "package:flutter_locations/src/util/scope.dart";

/// Entry widget receiving builder.
class LocationsUserStory extends StatelessWidget {
  ///[LocationsUserStory] constructor
  const LocationsUserStory({
    required this.options,
    super.key,
  });

  /// Options for the [LocationsUserStory].
  final LocationsOptions options;

  @override
  Widget build(BuildContext context) => LocationsScope(
        options: options,
        child: options.builder(context, const LocationsHome()),
      );
}

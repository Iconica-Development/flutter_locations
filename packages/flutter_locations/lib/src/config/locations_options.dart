import "package:flutter/material.dart";
import "package:flutter_locations/flutter_locations.dart";
import "package:flutter_locations/src/ui/widgets/defaults/base_screen.dart";

/// Class holding all the options for [LocationsUserStory].
class LocationsOptions {
  /// [LocationsOptions] constructor
  LocationsOptions({
    this.translations = const LocationsTranslations.empty(),
    this.builder = DefaultLocationsBaseScreen.builder,
    this.mapOptions = const LocationsMapOptions.empty(),
    LocationsRepositoryInterface? respositoryInterface,
  }) : respositoryInterface =
            respositoryInterface ?? LocationsLocalRepository();

  /// The implementation for communicating with the persistance layer
  final LocationsRepositoryInterface respositoryInterface;

  /// The default translations used.
  final LocationsTranslations translations;

  /// Builder for customizing map environment.
  final LocationsBaseScreenBuilder builder;

  /// The map options.
  final LocationsMapOptions mapOptions;
}

///
typedef LocationsBaseScreenBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

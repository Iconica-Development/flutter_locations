import "package:flutter/material.dart";
import "package:flutter_locations/src/config/flutter_locations_config.dart";
import "package:flutter_locations/src/config/locations_translations.dart";
import "package:flutter_locations/src/config/map_options.dart";
import "package:flutter_locations/src/ui/widgets/defaults/base_screen.dart";

/// Class holding all the options for [LocationsUserStory].
class LocationsOptions {
  /// [LocationsOptions] constructor
  LocationsOptions({
    this.translations = const LocationsTranslations.empty(),
    this.builder = DefaultLocationsBaseScreen.builder,
    this.mapOptions = const LocationsMapOptions.empty(),
    this.mapConfiguration = const PlatformMapConfiguration.empty(),
  });

  /// The default translations used.
  final LocationsTranslations translations;

  /// Builder for customizing map environment.
  final LocationsBaseScreenBuilder builder;

  /// The map options.
  final LocationsMapOptions mapOptions;

  /// The platform independent map configuration.
  final PlatformMapConfiguration mapConfiguration;
}

///
typedef LocationsBaseScreenBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

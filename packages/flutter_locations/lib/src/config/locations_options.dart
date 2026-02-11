// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";
import "package:flutter_locations/flutter_locations.dart";
import "package:flutter_locations/src/config/list/list_options.dart";
import "package:flutter_locations/src/ui/widgets/defaults/base_screen.dart";

/// Class holding all the options for [LocationsUserStory].
class LocationsOptions {
  /// [LocationsOptions] constructor
  LocationsOptions({
    this.translations = const LocationsTranslations.empty(),
    this.builder = DefaultLocationsBaseScreen.builder,
    this.mapOptions = const LocationsMapOptions.empty(),
    this.listOptions = const LocationsListOptions.empty(),
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

  /// The list options.
  final LocationsListOptions listOptions;

  LocationsOptions copy(LocationsOptions Function(LocationsOptions old) copy) =>
      copy(this);

  LocationsOptions copyWith({
    LocationsRepositoryInterface? respositoryInterface,
    LocationsTranslations? translations,
    LocationsBaseScreenBuilder? builder,
    LocationsMapOptions? mapOptions,
    LocationsListOptions? listOptions,
  }) =>
      LocationsOptions(
        respositoryInterface: respositoryInterface ?? this.respositoryInterface,
        translations: translations ?? this.translations,
        builder: builder ?? this.builder,
        mapOptions: mapOptions ?? this.mapOptions,
        listOptions: listOptions ?? this.listOptions,
      );
}

///
typedef LocationsBaseScreenBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

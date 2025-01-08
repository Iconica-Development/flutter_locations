import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:flutter/material.dart";
import "package:flutter_locations/src/config/list/item_options.dart";
import "package:flutter_locations/src/ui/widgets/defaults/list/list.dart";

/// Class holding all the options for [LocationsListOptions]
class LocationsListOptions {
  /// [LocationsListOptions] constructor
  const LocationsListOptions({
    this.listBuilder = DefaultLocationsList.builder,
    this.listItemOptions = const LocationsListItemOptions.empty(),
    this.minimumHeight = 0,
  });

  ///
  const LocationsListOptions.empty({
    this.listBuilder = DefaultLocationsList.builder,
    this.listItemOptions = const LocationsListItemOptions.empty(),
    this.minimumHeight = 100.0,
  });

  /// The builder function for the list.
  final LocationsListBuilder listBuilder;

  /// The minimum height used when the panel is shut.
  final double minimumHeight;

  /// The options for the list items
  final LocationsListItemOptions listItemOptions;
}

/// Interface for [DefaultLocationsList]
typedef LocationsListBuilder<T extends LocationItem> = Widget Function(
  BuildContext context,
  Stream<List<T>> location,
);

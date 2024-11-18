import "package:flutter/material.dart";
import "package:flutter_locations/flutter_locations.dart";
import "package:flutter_locations/src/ui/widgets/defaults/list/item.dart";

/// Class holding all the options for [LocationsListItemOptions]
class LocationsListItemOptions {
  /// [LocationsListItemOptions] constructor
  const LocationsListItemOptions({
    this.listBuilder = DefaultLocationsListItem.builder,
  });

  ///
  const LocationsListItemOptions.empty({
    this.listBuilder = DefaultLocationsListItem.builder,
  });

  /// The builder function for the list.
  final LocationsListItemBuilder listBuilder;
}

/// Interface for LocationListItems
typedef LocationsListItemBuilder<T extends LocationItem> = Widget Function(
  BuildContext context,
  T location,
);

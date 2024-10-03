import "dart:async";

import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:rxdart/subjects.dart";

/// Local in memory implementation of the locations repository.
class LocationsLocalRepository
    implements LocationsRepositoryInterface<DefaultLocationItem> {
  /// Create a singleton locations repository containing locations in the
  /// netherlands
  factory LocationsLocalRepository() =>
      _instance ??= LocationsLocalRepository.forArea(
        northWest: const Location(latitude: 52.490028, longitude: 4.829669),
        southEast: const Location(latitude: 51.884544, longitude: 6.535011),
        density: 50,
      );

  /// Instantiates a local Locations repository with initial locations in a
  /// given geographical area.
  factory LocationsLocalRepository.forArea({
    required Location northWest,
    required Location southEast,
    int density = 10,
  }) {
    assert(
      northWest.latitude > southEast.latitude,
      "northWest property should be north of the southEast",
    );

    if (density < 1) {
      return LocationsLocalRepository.withItems(items: []);
    }

    var startY = southEast.latitude;
    var endY = northWest.latitude;
    var startX = northWest.longitude;
    var endX = southEast.longitude;
    if (endX < startX) {
      endX += 360;
    }
    var xStep = (endX - startX) / density;
    var yStep = (endY - startY) / density;

    var items = <DefaultLocationItem>[];

    var index = 0;
    for (var x = 0; x < density; x++) {
      for (var y = 0; y < density; y++) {
        index++;
        var location = Location(
          longitude: xStep * x + startX,
          latitude: yStep * y + startY,
        );

        items.add(
          DefaultLocationItem(
            location: location.normalizeLongitude(),
            locationId: "$index",
          ),
        );
      }
    }

    return LocationsLocalRepository.withItems(items: items);
  }

  /// Instantiates a local Locations repository for a set of items;
  LocationsLocalRepository.withItems({
    required List<DefaultLocationItem> items,
  }) : _items = items {
    _locationsStream.add(_items);
  }

  static LocationsLocalRepository? _instance;

  final List<DefaultLocationItem> _items;

  final StreamController<List<DefaultLocationItem>> _locationsStream =
      BehaviorSubject<List<DefaultLocationItem>>();
  @override
  Stream<List<DefaultLocationItem>> getLocations({
    LocationsFilter? filter,
  }) =>
      _locationsStream.stream
          .map((locations) => filter?.filterItems(locations) ?? locations);

  @override
  Stream<DefaultLocationItem> getLocationForId(String locationId) =>
      getLocations().map(
        (locations) => locations.firstWhere(
          (location) => location.locationId == locationId,
          orElse: () {
            throw LocationForIdDoesNotExistException(locationId);
          },
        ),
      );
}

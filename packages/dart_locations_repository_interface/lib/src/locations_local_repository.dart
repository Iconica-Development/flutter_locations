import "dart:async";

import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:rxdart/subjects.dart";

///
final List<String> placeNames = [
  "The Book Nook",
  "Golden Grain Bakery",
  "Van Dijk Fashion House",
  "Toy Paradise",
  "Fresh & Green Market",
  "Step by Step Shoe Store",
  "The Bike Shop",
  "The Flower Studio",
  "Sunlight Jewelry",
  "Laptop Lounge",
  "The Good Life Cheese Farm",
  "The Cooking Corner",
  "Brilliant Optics",
  "The Bedroom Shop",
  "Letterpress Books",
  "The Home Haven",
  "Little Joy Coffee Bar",
  "The Butcher's Block",
  "The Fishery",
  "Healthy Living Pharmacy",
  "Jewelry Heaven",
  "Tech World",
  "The Woodworker’s Den",
  "The Surprise Gift Shop",
  "The Kids' Room",
  "Flash Photo Studio",
  "Fast Pass Sports",
  "The Wine Cellar",
  "Green Bliss Garden Center",
  "Denim Palace",
  "The Paint Pot",
  "Atmosphere & Style Home Decor",
  "Old & Treasured Antiques",
  "The Music Temple",
  "The Hop Bell Brewery",
  "Scented Treasures Perfume",
  "Flavor Kingdom Cooking Studio",
  "The Fabric Shop",
  "The Playhouse",
  "The Ice Cream Parlor",
  "Art Room Gallery",
  "The Cheese Master",
  "The Beauty Studio",
  "The Farmer’s Market",
  "Pet Heaven Animal Dreams",
  "The Bag Shop",
  "The Treehouse Kids' Clothing",
  "Night Watch Sleep Comfort",
  "The Game Chest",
  "The Travel Café",
];

/// Local in memory implementation of the locations repository.
class LocationsLocalRepository
    implements LocationsRepositoryInterface<DefaultLocationItem> {
  /// Create a singleton locations repository containing locations in the
  /// netherlands
  factory LocationsLocalRepository({int density = 50}) =>
      _instance ??= LocationsLocalRepository.forArea(
        northWest: const Location(latitude: 52.490028, longitude: 4.829669),
        southEast: const Location(latitude: 51.884544, longitude: 6.535011),
        density: density,
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
            locationTitle: placeNames[index % placeNames.length],
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

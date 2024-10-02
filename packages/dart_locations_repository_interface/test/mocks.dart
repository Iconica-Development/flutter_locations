import "dart:math";

import "package:dart_locations_repository_interface/src/locations_models.dart";
import "package:dart_locations_repository_interface/src/locations_repository_interface.dart";
import "package:mocktail/mocktail.dart";

class TestLocationItem implements LocationItem {
  TestLocationItem({
    required this.location,
    required this.locationId,
  });

  factory TestLocationItem.nextScoped(String scope) {
    var oldIndex = _scopedIndexes.putIfAbsent(scope, () => 0);
    var newIndex = oldIndex + 1;
    _scopedIndexes[scope] = newIndex;

    var random = Random(newIndex);

    return TestLocationItem(
      location: Location(
        longitude: random.nextDouble(),
        latitude: random.nextDouble(),
      ),
      locationId: "Location($scope, $newIndex)",
    );
  }

  static final Map<String, int> _scopedIndexes = {};

  @override
  final Location location;
  @override
  final String locationId;

  TestLocationItem update() =>
      TestLocationItem(location: location, locationId: locationId);
}

class MockedLocationsRepository extends Mock
    implements LocationsRepositoryInterface<TestLocationItem> {}

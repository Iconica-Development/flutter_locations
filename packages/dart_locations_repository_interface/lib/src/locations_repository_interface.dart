import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";

/// Interface defining the contract between the location service and the various
/// types of datasources
abstract interface class LocationsRepositoryInterface<T extends LocationItem> {
  /// Retrieves a list of locations
  Stream<List<T>> getLocations({
    LocationsFilter? filter,
  });

  /// Retrieves a single location
  Stream<T> getLocationForId(String locationId);

  /// Checks if the current location marker is enabled
  Stream<bool> isCurrentLocationMarkerEnabled();

  /// Sets the current location marker to be enabled or disabled
  Future<void> toggleCurrentLocationMarker();
}

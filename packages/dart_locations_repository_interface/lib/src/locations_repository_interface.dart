import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";

/// Interface defining the contract between the location service and the various
/// types of datasources
abstract interface class LocationsRepositoryInterface<T extends LocationItem> {
  /// Retrieves a list of locations
  Stream<List<T>> getLocations();

  /// Retrieves a single location
  Stream<T> getLocationForId(String locationId);
}

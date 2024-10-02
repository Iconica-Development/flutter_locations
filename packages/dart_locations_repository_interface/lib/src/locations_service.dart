import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";

/// A service defining common api on how to deal with content at locations
/// within the context of a geographical area.
class LocationsService<T extends LocationItem> {
  /// Constructs a service
  LocationsService({
    required LocationsRepositoryInterface<T> locationsRepositoryInterface,
  }) : _locationsRepositoryInterface = locationsRepositoryInterface;

  /// Constructs a service using a singleton repository with fixed local data.
  static LocationsService<DefaultLocationItem> localDefault() =>
      LocationsService(
        locationsRepositoryInterface: LocationsLocalRepository(),
      );

  final LocationsRepositoryInterface<T> _locationsRepositoryInterface;

  /// Checks if the internal interface uses the location
  bool get isLocalData =>
      _locationsRepositoryInterface is LocationsLocalRepository;

  /// Gets all locations through a stream
  Stream<List<T>> getLocations() =>
      _locationsRepositoryInterface.getLocations();

  /// Gets a specific location with [locationId] through a stream.
  ///
  /// Throws a [LocationForIdDoesNotExistException] if no location was found
  Stream<T> getLocationForId(String locationId) =>
      _locationsRepositoryInterface.getLocationForId(locationId);
}

import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";

/// A service defining common api on how to deal with content at locations
/// within the context of a geographical area.
class LocationsService<T extends LocationItem> {
  /// Constructs a service
  const LocationsService({
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
  Stream<List<T>> getLocations({
    LocationsFilter? filter,
  }) =>
      _locationsRepositoryInterface.getLocations(
        filter: filter,
      );

  /// Gets a specific location with [locationId] through a stream.
  ///
  /// Throws a [LocationForIdDoesNotExistException] if no location was found
  Stream<T> getLocationForId(String locationId) =>
      _locationsRepositoryInterface.getLocationForId(locationId);

  /// Stream that emits a boolean value indicating if the current location
  /// marker is enabled
  Stream<bool> isCurrentLocationMarkerEnabled() =>
      _locationsRepositoryInterface.isCurrentLocationMarkerEnabled();

  /// Toggles the current location marker
  Future<void> toggleCurrentLocationMarker() =>
      _locationsRepositoryInterface.toggleCurrentLocationMarker();
}

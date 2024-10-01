import "package:dart_locations_repository_interface/src/locations_local_repository.dart";
import "package:dart_locations_repository_interface/src/locations_repository_interface.dart";

/// A service defining common api on how to deal with content at locations
/// within the context of a geographical area.
class LocationsService {
  /// Constructs a service
  LocationsService({
    required LocationsRepositoryInterface locationsRepositoryInterface,
  }) : _locationsRepositoryInterface = locationsRepositoryInterface;

  final LocationsRepositoryInterface _locationsRepositoryInterface;

  /// Checks if the internal interface uses the location
  bool get isLocalData =>
      _locationsRepositoryInterface is LocationsLocalRepository;
}

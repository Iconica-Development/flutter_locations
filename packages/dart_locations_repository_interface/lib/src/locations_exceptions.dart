/// Thrown when location for a specific [locationId] is not found
class LocationForIdDoesNotExistException implements Exception {
  /// Instantiate this exception
  LocationForIdDoesNotExistException(this.locationId);

  /// The id that was used in the lookup
  final String locationId;

  @override
  String toString() => "LocationForIdDoesNotExistException: "
      "Location for $locationId was not found";
}

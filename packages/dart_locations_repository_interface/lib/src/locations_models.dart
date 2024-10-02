/// A single representation of an item at a location
abstract interface class LocationItem {
  /// The real-world location to which this item is bound
  Location get location;

  /// The identifier for this object, used to bind this to other representations
  /// of the same object.
  ///
  /// Should at all times be unique within the context of this domain.
  String get locationId;
}

/// A single entry for a location
class DefaultLocationItem implements LocationItem {
  /// Instantiates an item on a location
  ///
  /// The [locationId] and [location] are required to identify what and where.
  ///
  /// Additional parameters can be given, but are not required
  DefaultLocationItem({
    required this.location,
    required this.locationId,
    this.locationImageUrl,
    this.locationDescription,
    this.locationTitle,
  });

  @override
  final Location location;
  @override
  final String locationId;

  /// Optional image bound to this location
  final String? locationImageUrl;

  /// Optional title bound to this location
  final String? locationTitle;

  /// Optional description bound to this location
  final String? locationDescription;
}

/// This defines the information needed to know where a physical location can
/// be found in the world.
class Location {
  /// Instantiation of a Location
  const Location({
    required this.latitude,
    required this.longitude,
  }) : assert(
          90 >= latitude && latitude >= -90,
          "Latitude can only between -90 and 90",
        );

  /// Creates a Location instance where extremes for the longitude are
  /// automatically put between the allowed values of -180 and 180.
  factory Location.normalized({
    required double latitude,
    required double longitude,
  }) =>
      Location(latitude: latitude, longitude: longitude).normalizeLongitude();

  /// Representation of a read world latitude
  final double latitude;

  /// Representation of a real world longitude
  final double longitude;

  /// Removes any extremes on coordinates that go past the extremes.
  ///
  /// For example, a coordinate at 175 longitude that spans 10 longitude could
  /// end with a simple calculation at 185 longitude, which does not exist.
  /// In actuality this becomes -175 longitude, a -360 degrees.
  Location normalizeLongitude() {
    var longitude = this.longitude.remainder(360.0);
    if (longitude >= 180) {
      longitude -= 360.0;
    } else if (longitude <= -180) {
      longitude += 360.0;
    }

    return Location(
      longitude: longitude,
      latitude: latitude,
    );
  }
}

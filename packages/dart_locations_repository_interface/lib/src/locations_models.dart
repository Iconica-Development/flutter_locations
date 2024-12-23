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

/// LocationName Mixin
abstract mixin class LocationNameMixin {
  /// Optional title bound to location
  String? get locationTitle;
}

/// LocationDescription Mixin
abstract mixin class LocationDescriptionMixin {
  /// Optional description bound to location
  String? get locationDescription;
}

/// LocationZoom
abstract mixin class LocationZoomMixin {
  /// The minimal amount of zoom required to see this location.
  double? get minZoomLevel;
}

///
abstract interface class TypedLocationItem
    with LocationNameMixin, LocationDescriptionMixin, LocationZoomMixin
    implements LocationItem {}

/// A single entry for a location
class DefaultLocationItem implements TypedLocationItem {
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
    this.minZoomLevel,
  });

  @override
  final Location location;

  @override
  final String locationId;

  /// Optional image bound to this location
  final String? locationImageUrl;

  @override
  final String? locationTitle;

  @override
  final String? locationDescription;

  @override
  final double? minZoomLevel;
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

/// A bounds made of geographical data.
///
/// Used to filter [LocationItem]s that exist within the given bounds.
class LocationBounds {
  /// Create new LocationBounds
  LocationBounds({
    required this.northWest,
    required this.southEast,
  }) : assert(
          northWest.latitude > southEast.latitude,
          "northWest should be north of southEast",
        );

  /// The upper left corner of the area
  final Location northWest;

  /// The lower right corner of the area
  final Location southEast;

  /// Check if the [location] is within these bounds.
  ///
  /// This handles the situation when the bounds crosses the antimeridian
  bool contains(Location location) {
    if (location.latitude > northWest.latitude ||
        location.latitude < southEast.latitude) {
      return false;
    }

    /// Handle antimeridian surpassing areas.
    ///
    if (northWest.longitude > southEast.longitude) {
      return location.longitude <= southEast.longitude ||
          location.longitude >= northWest.longitude;
    }

    return northWest.longitude <= location.longitude &&
        location.longitude <= southEast.longitude;
  }
}

/// Filter used to reduce the amount of results seen
class LocationsFilter {
  /// Create a filter to use in filtering Locations
  const LocationsFilter({
    this.bounds,
    this.query,
    this.zoom,
  });

  /// The bounds within which the locations should be found
  final LocationBounds? bounds;

  /// The string on which the location should be filtered.
  final String? query;

  /// The zoom on which the locations should be filtered.
  final double? zoom;

  /// Filters items based on the given parameters
  ///
  /// Used for local filtering of items. It is better to have your repository
  /// handle the filtering, idealy server side to reduce the amount of data
  /// communicated.
  List<T> filterItems<T extends LocationItem>(
    List<T> items,
  ) {
    Iterable<T> toFilter = List.from(items);
    if (bounds != null) {
      toFilter =
          toFilter.where((location) => bounds!.contains(location.location));
    }

    if (query != null) {
      bool queryFilter(location) {
        var queriedStrings = [
          if (location is LocationNameMixin) location.locationTitle,
          if (location is LocationDescriptionMixin)
            location.locationDescription,
        ];

        return queriedStrings
            .where(
              (queryString) =>
                  queryString != null &&
                  queryString
                      .toLowerCase()
                      .contains(query!.trim().toLowerCase()),
            )
            .isNotEmpty;
      }

      toFilter = toFilter.where(queryFilter);
    }

    if (zoom != null) {
      bool zoomFilter(location) {
        if (location is! LocationZoomMixin) return true;
        return zoom! >= (location.minZoomLevel ?? 0);
      }

      toFilter = toFilter.where(zoomFilter);
    }

    return toFilter.toList();
  }
}

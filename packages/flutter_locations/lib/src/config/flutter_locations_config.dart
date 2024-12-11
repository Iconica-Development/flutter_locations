import "package:latlong2/latlong.dart";
export "package:latlong2/latlong.dart" show LatLng;

/// The type of the map
enum MapType {
  /// The normal map
  normal,

  /// The satellite map
  satellite,

  /// The hybrid map
  hybrid,
}

/// The configuration for the flutter locations
class PlatformMapConfiguration {
  /// Constructs a configuration
  const PlatformMapConfiguration({
    required this.initialCameraPosition,
    this.mapType = MapType.normal,
    this.isCameraControlShown = false,
    this.isTrafficEnabled = false,
    this.minimumCameraZoomLevel = 0.0,
    this.maximumCameraZoomLevel = 21.0,
    this.isZoomCameraControlEnabled = false,
    this.isRotateCameraControlEnabled = false,
    this.isMoveCameraControlEnabled = false,
    this.isTiltCameraControlEnabled = false,
    this.isCompassShown = false,
    this.isMyLocationEnabled = false,
    this.initialCameraZoom = 15.0,
    this.initialCameraTilt = 0.0,
    this.initialCameraBearing = 0.0,
    this.poiListStyle = const [],
  })  : assert(
          initialCameraZoom >= minimumCameraZoomLevel,
          """The initial camera zoom must be greater than or equal to the minimum camera zoom level""",
        ),
        assert(
          initialCameraZoom <= maximumCameraZoomLevel,
          // ignore: lines_longer_than_80_chars
          """The initial camera zoom must be less than or equal to the maximum camera zoom level""",
        ),
        assert(
          (!isCameraControlShown &&
                  (isZoomCameraControlEnabled ||
                      isRotateCameraControlEnabled ||
                      isMoveCameraControlEnabled)) ||
              isCameraControlShown,
          "At least one of the camera controls must be enabled",
        );

  /// Constructs an empty configuration
  const PlatformMapConfiguration.empty()
      : initialCameraPosition = const LatLng(0, 0),
        mapType = MapType.normal,
        isCameraControlShown = false,
        isTrafficEnabled = false,
        minimumCameraZoomLevel = 0.0,
        maximumCameraZoomLevel = 21.0,
        isZoomCameraControlEnabled = false,
        isRotateCameraControlEnabled = false,
        isMoveCameraControlEnabled = false,
        isTiltCameraControlEnabled = false,
        isCompassShown = false,
        isMyLocationEnabled = false,
        initialCameraZoom = 15.0,
        initialCameraTilt = 0.0,
        initialCameraBearing = 0.0,
        poiListStyle = const [];

  /// The type of the map
  final MapType mapType;

  /// If the camera control should be shown
  /// Default: false
  final bool isCameraControlShown;

  /// If the traffic should be enabled
  /// Default: false
  final bool isTrafficEnabled;

  /// The minimum camera zoom level
  /// Default: 0.0
  final double minimumCameraZoomLevel;

  /// The maximum camera zoom level
  /// Default: 21.0
  final double maximumCameraZoomLevel;

  /// If the zoom camera control should be enabled
  /// Default: false
  final bool isZoomCameraControlEnabled;

  /// If the rotate camera control should be enabled
  /// Default: false
  final bool isRotateCameraControlEnabled;

  /// If the move camera control should be enabled
  /// Default: false
  final bool isMoveCameraControlEnabled;

  /// If the tilt camera control should be enabled
  /// Default: false
  final bool isTiltCameraControlEnabled;

  /// If the compass should be shown
  /// Default: false
  final bool isCompassShown;

  /// If the my location should be enabled
  /// Default: false
  final bool isMyLocationEnabled;

  /// The initial camera zoom
  /// Default: 15.0
  final double initialCameraZoom;

  /// The initial camera tilt
  /// 0.0 means straight down and 90.0 means straight up
  /// Default: 0.0
  final double initialCameraTilt;

  /// The initial camera bearing
  /// 0.0 means North and 90.0 means East
  /// Default: 0.0
  final double initialCameraBearing;

  /// The initial camera position
  final LatLng initialCameraPosition;

  /// The style of the points of interest
  final List<PlatformMapStyleFeature> poiListStyle;
}

/// The configuration for the points of interest.
/// The different types of features can be found on https://developers.google.com/maps/documentation/javascript/style-reference
class PlatformMapStyleFeature {
  /// Constructs a style feature
  PlatformMapStyleFeature({
    required this.stylers,
    this.featureType = "all",
    this.elementType = "all",
  });

  /// The type of the feature
  /// Default: all
  final String featureType;

  /// The type of the element
  /// Default: all
  final String elementType;

  /// The stylers of the feature
  final List<Map<String, String>> stylers;

  /// Converts the object to a map
  Map toJson() => {
        "featureType": featureType,
        "elementType": elementType,
        "stylers": stylers,
      };
}

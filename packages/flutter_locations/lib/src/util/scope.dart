import "package:flutter/widgets.dart";
import "package:flutter_locations/flutter_locations.dart";

///
class LocationsScope extends InheritedWidget {
  ///
  const LocationsScope({
    required this.options,
    required super.child,
    super.key,
  });

  ///
  final LocationsOptions options;

  @override
  bool updateShouldNotify(LocationsScope oldWidget) =>
      oldWidget.options != options;

  ///
  static LocationsScope of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LocationsScope>()!;
}

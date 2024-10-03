import "package:flutter/material.dart";
import "package:flutter_locations/src/util/scope.dart";

/// Default base screen for the flutter Locations
class DefaultLocationsBaseScreen extends StatelessWidget {
  /// Create a base screen
  const DefaultLocationsBaseScreen({
    required this.child,
    super.key,
  });

  /// Builder as a default option
  static Widget builder(
    BuildContext context,
    Widget child,
  ) =>
      DefaultLocationsBaseScreen(
        child: child,
      );

  /// Content of the page
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var translations = LocationsScope.of(context).options.translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.appbarTitle),
      ),
      body: child,
    );
  }
}

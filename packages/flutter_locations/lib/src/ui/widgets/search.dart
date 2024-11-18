import "package:flutter/material.dart";
import "package:flutter_locations/src/util/scope.dart";

/// The widget holding the search builder.
class LocationsSearch extends StatelessWidget {
  /// [LocationsSearch] constructor
  const LocationsSearch({
    required this.onSearch,
    super.key,
  });

  /// Executed when a search is called.
  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    var options = LocationsScope.of(context).options.mapOptions;
    return options.searchBuilder(
      context,
      onSearch,
      Icons.search,
    );
  }
}

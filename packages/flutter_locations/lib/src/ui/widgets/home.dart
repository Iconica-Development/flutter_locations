import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_locations/flutter_locations.dart";
import "package:flutter_locations/src/ui/widgets/list.dart";
import "package:flutter_locations/src/ui/widgets/map/controls.dart";
import "package:flutter_locations/src/ui/widgets/map/map.dart";
import "package:flutter_locations/src/ui/widgets/search.dart";
import "package:flutter_locations/src/util/scope.dart";
import "package:flutter_map/flutter_map.dart";

/// A map that can display locations.
class LocationsHome extends HookWidget {
  /// [LocationsHome] constructor
  const LocationsHome({
    this.controller,
    super.key,
  });

  /// A passable [MapController] for external controlling.
  final MapController? controller;

  @override
  Widget build(BuildContext context) {
    var repository = LocationsScope.of(context).options.respositoryInterface;
    var options = LocationsScope.of(context).options.mapOptions;

    var bounds = useState<LatLngBounds?>(null);
    var query = useState("");

    var mapController = useState(controller ?? MapController());

    void setBounds(LatLngBounds newBounds) => bounds.value = newBounds;
    void setQuery(String value) => query.value = value;

    var locationStream = repository.getLocations(
      filter: LocationsFilter(
        bounds: bounds.value != null
            ? LocationBounds(
                northWest: Location(
                  latitude: bounds.value!.north,
                  longitude: bounds.value!.west,
                ),
                southEast: Location(
                  latitude: bounds.value!.south,
                  longitude: bounds.value!.east,
                ),
              )
            : null,
        query: query.value.isNotEmpty ? query.value : null,
      ),
    );

    return Stack(
      children: [
        Scaffold(
          floatingActionButtonLocation:
              options.controlsOptions.controlsPosition,
          floatingActionButton:
              LocationsMapControls(mapController: mapController.value),
          body: Stack(
            children: [
              LocationsMap(
                locationStream: locationStream,
                controller: mapController.value,
                onSetBounds: setBounds,
              ),
            ],
          ),
        ),
        LocationsList(
          locationStream: locationStream,
        ),
        LocationsSearch(
          onSearch: setQuery,
        ),
      ],
    );
  }
}

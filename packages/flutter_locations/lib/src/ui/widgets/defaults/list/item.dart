import "package:flutter/material.dart";
import "package:flutter_locations/flutter_locations.dart";

/// An entry in a locations list.
class DefaultLocationsListItem<T extends LocationItem> extends StatelessWidget {
  /// [DefaultLocationsListItem] constructor
  const DefaultLocationsListItem({
    required this.location,
    super.key,
  });

  /// The location this [DefaultLocationsListItem] is representing
  final T location;

  /// A builder function
  static Widget builder(
    BuildContext context,
    LocationItem location,
  ) =>
      DefaultLocationsListItem(location: location);

  @override
  Widget build(BuildContext context) {
    var location = this.location as TypedLocationItem;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ColoredBox(
                color: Colors.grey,
                child: SizedBox(
                  height: 132.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0).copyWith(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      location.locationTitle!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      location.locationDescription!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

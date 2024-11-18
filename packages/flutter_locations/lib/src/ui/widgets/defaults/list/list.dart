import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_locations/flutter_locations.dart";
import "package:flutter_locations/src/util/scope.dart";

/// A widget that lists the locations.
class DefaultLocationsList<T extends LocationItem> extends HookWidget {
  /// [DefaultLocationsList] constructor.
  const DefaultLocationsList({
    required this.locationStream,
    super.key,
  });

  /// Received filteres streams
  final Stream<List<T>> locationStream;

  /// A builder function
  static Widget builder<T extends LocationItem>(
    BuildContext context,
    Stream<List<T>> locationStream,
  ) =>
      DefaultLocationsList(
        locationStream: locationStream,
      );

  @override
  Widget build(BuildContext context) {
    var options =
        LocationsScope.of(context).options.listOptions.listItemOptions;

    var locations = useState(<Widget>[]);

    locationStream.listen(
      (locationItems) => locations.value = locationItems
          .map(
            (e) => options.listBuilder(context, e),
          )
          .toList(),
    );

    var height = useState(200.0);
    var toggle = useState(false);
    var interaction = useState(false);

    var borderRadius = (toggle.value)
        ? BorderRadius.zero
        : const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          );

    var planeColor = const Color(0xFFFFFFFF);
    var borderColor = const Color(0xFF9E9E9E);
    var handleBarColor = toggle.value ? Colors.transparent : borderColor;
    var borderSide = BorderSide(
      width: 1.0,
      color: borderColor,
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: interaction.value ? Duration.zero : Durations.short2,
            curve: Curves.easeInOut,
            height: height.value,
            decoration: BoxDecoration(
              border: Border(
                top: borderSide,
                left: borderSide,
                right: borderSide,
              ),
              borderRadius: borderRadius,
              color: planeColor,
            ),
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onVerticalDragUpdate: (details) {
                    interaction.value = true;
                    var screenHeight = MediaQuery.sizeOf(context).height;
                    height.value = (screenHeight - details.globalPosition.dy)
                        .clamp(10, screenHeight);
                  },
                  onVerticalDragEnd: (details) {
                    var screenHeight = MediaQuery.sizeOf(context).height;

                    var highDownwardVelocity =
                        details.velocity.pixelsPerSecond.dy > 2000;
                    var highUpwardVelocity =
                        details.velocity.pixelsPerSecond.dy < -2000;

                    var pastHalfway =
                        details.globalPosition.dy > screenHeight / 2;

                    toggle.value = toggle.value
                        ? !(highDownwardVelocity || pastHalfway)
                        : (highUpwardVelocity || !pastHalfway);

                    height.value = (toggle.value) ? screenHeight : 100;
                    interaction.value = false;
                  },
                  child: SizedBox(
                    height: 20,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 54.0,
                          height: 4.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: handleBarColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  // TODO(Quirille): Values should be determined from search builder / options
                  padding: EdgeInsets.only(top: toggle.value ? 80.0 : 20.0),
                  child: ListView(
                    physics: toggle.value
                        ? null
                        : const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22.0,
                    ),
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          // TODO(Quirille): localizations should be defined.
                          "Nearby",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...locations.value,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

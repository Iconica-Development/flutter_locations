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
    var theme = Theme.of(context);
    var listOptions = LocationsScope.of(context).options.listOptions;
    var listItemOptions = listOptions.listItemOptions;

    var minimumHeight = listOptions.minimumHeight;

    var locations = useState(<Widget>[]);

    locationStream.listen(
      (locationItems) => locations.value = locationItems
          .map(
            (e) => listItemOptions.listBuilder(context, e),
          )
          .toList(),
    );

    var screenHeight = MediaQuery.sizeOf(context).height;
    var height = useState(minimumHeight);
    var toggle = useState(false);
    var interaction = useState(false);

    var borderRadius = (toggle.value)
        ? BorderRadius.zero
        : const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          );

    void verticalDragUpdate(DragUpdateDetails details) {
      interaction.value = true;
      var screenHeight = MediaQuery.sizeOf(context).height;
      height.value = (screenHeight - details.globalPosition.dy).clamp(
        10,
        screenHeight,
      );
    }

    void verticalDragEnd(DragEndDetails details) {
      var highDownwardVelocity = details.velocity.pixelsPerSecond.dy > 2000;
      var highUpwardVelocity = details.velocity.pixelsPerSecond.dy < -2000;
      var pastHalfway = details.globalPosition.dy > screenHeight / 2;

      toggle.value = toggle.value
          ? !(highDownwardVelocity || pastHalfway)
          : (highUpwardVelocity || !pastHalfway);

      height.value = (toggle.value) ? screenHeight : minimumHeight;
      interaction.value = false;
    }

    var transformationTween =
        Tween(begin: 0.0, end: 1.0).transform(height.value / screenHeight);

    var extraPaddingTween =
        Tween(begin: 20.0, end: 80.0).transform(transformationTween);

    var durationValue = interaction.value ? Duration.zero : Durations.short2;

    var planeColor = theme.colorScheme.surface;
    var borderColor = theme.colorScheme.surfaceContainerHighest
        .withAlpha((255 * (1.0 - transformationTween)).toInt());
    var handleBarColor = borderColor;

    var borderSide = BorderSide(
      width: 1.0,
      color: borderColor,
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          AnimatedContainer(
            curve: Curves.easeInOut,
            duration: durationValue,
            height: height.value,
            decoration: BoxDecoration(
              border: Border(
                top: borderSide,
                left: borderSide,
                right: borderSide,
              ),
              borderRadius: borderRadius * (1.0 - transformationTween),
              color: planeColor,
            ),
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onVerticalDragUpdate: verticalDragUpdate,
                  onVerticalDragEnd: verticalDragEnd,
                  child: SizedBox(
                    height: 20,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedContainer(
                          duration: durationValue,
                          height: 4.0,
                          width: 54.0,
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
                  padding: EdgeInsets.only(top: extraPaddingTween),
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

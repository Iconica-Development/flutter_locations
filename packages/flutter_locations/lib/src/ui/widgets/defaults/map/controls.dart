import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_locations/src/util/scope.dart";
import "package:flutter_map/flutter_map.dart";

/// The default Control widget.
class DefaultLocationsMapControl extends HookWidget {
  /// Constructor receiving an onTap callback and icon.
  const DefaultLocationsMapControl({
    required this.onTap,
    required this.icon,
    super.key,
  });

  /// Callback is fired on tap/click/press.
  final VoidCallback onTap;

  /// Icon shown in the center of the control.
  final IconData icon;

  /// The builder function
  static Widget builder(
    BuildContext context,
    IconData icon,
    VoidCallback onTap,
  ) =>
      DefaultLocationsMapControl(
        icon: icon,
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    var isHovered = useState(false);

    var theme = Theme.of(context);
    return MouseRegion(
      onHover: (value) => isHovered.value = true,
      onExit: (event) => isHovered.value = false,
      child: SizedBox(
        height: 36.0,
        width: 36.0,
        child: FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: onTap,
          hoverColor: theme.colorScheme.surface,
          backgroundColor: theme.colorScheme.surface,
          mini: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Icon(
            icon,
            color: isHovered.value
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onSurfaceVariant,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}

/// The default controls wrapper.
class DefaultLocationsMapControls extends StatelessWidget {
  /// Contructor receiving the map controller.
  const DefaultLocationsMapControls({
    required this.controller,
    super.key,
  });

  /// A [MapController] that allows the controls to communicate with the map.
  final MapController controller;

  /// The builder function.
  static Widget builder(BuildContext context, MapController controller) =>
      DefaultLocationsMapControls(
        controller: controller,
      );

  @override
  Widget build(BuildContext context) {
    var options = LocationsScope.of(context).options.mapOptions.controlsOptions;

    return Wrap(
      spacing: options.controlsSpacing,
      direction: Axis.vertical,
      children: [
        for (final control in options.controls) ...[
          control.child ??
              options.controlBuilder(
                context,
                control.icon!,
                () => control.onPressed(controller),
              ),
        ],
      ],
    );
  }
}

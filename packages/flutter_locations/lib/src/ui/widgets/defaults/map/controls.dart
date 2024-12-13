import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_locations/src/util/scope.dart";
import "package:flutter_map/flutter_map.dart";

/// The default Control widget.
class DefaultLocationsMapControl extends HookWidget {
  /// Constructor receiving an onTap callback, icon, and enabled state.
  const DefaultLocationsMapControl({
    required this.onTap,
    required this.icon,
    required this.enabled,
    super.key,
  });

  /// Callback is fired on tap/click/press.
  final VoidCallback onTap;

  /// Icon shown in the center of the control.
  final IconData icon;

  /// Stream that determines if the control is enabled.
  final Stream<bool> enabled;

  /// The builder function
  static Widget builder(
    BuildContext context,
    IconData icon,
    VoidCallback onTap,
    Stream<bool> enabled,
  ) =>
      DefaultLocationsMapControl(
        icon: icon,
        onTap: onTap,
        enabled: enabled,
      );

  @override
  Widget build(BuildContext context) {
    var isHovered = useState(false);
    var isEnabled = useStream(enabled, initialData: true);

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
          backgroundColor: isEnabled.data ?? false
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surface,
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
    required this.repository,
    super.key,
  });

  /// A [MapController] that allows the controls to communicate with the map.
  final MapController controller;

  /// a [LocationsRepositoryInterface] that allows the controls to communicate
  /// with the repository.
  final LocationsRepositoryInterface repository;

  /// The builder function.
  static Widget builder(
    BuildContext context,
    MapController controller,
    LocationsRepositoryInterface repository,
  ) =>
      DefaultLocationsMapControls(
        controller: controller,
        repository: repository,
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
                () => control.onPressed(controller, repository),
                control.enabled(repository),
              ),
        ],
      ],
    );
  }
}

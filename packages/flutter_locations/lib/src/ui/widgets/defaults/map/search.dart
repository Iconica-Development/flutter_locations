import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_locations/src/util/scope.dart";

/// The default search widget provided.
class DefaultLocationsMapSearch extends HookWidget {
  /// Constructor receiving onSubmit callback and an icon
  const DefaultLocationsMapSearch({
    required this.onSubmit,
    this.icon,
    super.key,
  });

  /// Callback that is fired on submit.
  final ValueChanged<String> onSubmit;

  /// Icon that is used in the searchbar.
  final IconData? icon;

  /// Builderfunction that returns the widget.
  static Widget builder(
    BuildContext context,
    ValueChanged<String> onSubmit,
    IconData icon,
  ) =>
      DefaultLocationsMapSearch(
        icon: icon,
        onSubmit: onSubmit,
      );

  @override
  Widget build(BuildContext context) {
    var translations = LocationsScope.of(context).options.translations;
    var controller = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: SizedBox(
        height: 43.0,
        child: TextField(
          controller: controller,
          onSubmitted: onSubmit,
          decoration: InputDecoration(
            hintText: translations.searchInputPlaceholder,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 11.0, 0.0, 10.0),
            suffixIcon: IconButton(
              onPressed: () => onSubmit(controller.value.text),
              icon: Icon(
                icon ?? Icons.search,
                size: 24.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

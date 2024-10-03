import "package:flutter/material.dart";
import "package:flutter_locations/src/util/scope.dart";

///
class DefaultLocationsMapSearch extends StatelessWidget {
  ///
  const DefaultLocationsMapSearch({
    required this.onInput,
    required this.icon,
    super.key,
  });

  ///
  final ValueChanged<String> onInput;

  ///
  final IconData icon;

  ///
  static Widget builder(
    BuildContext context,
    ValueChanged<String> onInput,
    IconData icon,
  ) =>
      DefaultLocationsMapSearch(
        icon: icon,
        onInput: onInput,
      );

  @override
  Widget build(BuildContext context) {
    var translations = LocationsScope.of(context).options.translations;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: SizedBox(
        height: 43.0,
        child: TextField(
          onChanged: onInput,
          decoration: InputDecoration(
            hintText: translations.searchInputPlaceholder,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 11.0, 0.0, 10.0),
            suffixIcon: Icon(
              icon,
              size: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}

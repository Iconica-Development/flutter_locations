// SPDX-FileCopyrightText: 2024 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

/// Class that holds all translatable strings for the [LocationsUserStory]
class LocationsTranslations {
  /// Constructor with required values.
  /// if you want a default use `empty` constructor.
  const LocationsTranslations({
    required this.appbarTitle,
    required this.searchInputPlaceholder,
  });

  /// LocationsTranslations constructor where everything is optional.
  const LocationsTranslations.empty({
    this.appbarTitle = "Locations",
    this.searchInputPlaceholder = "Search...",
  });

  /// App bar title shown
  final String appbarTitle;

  /// The text used as a placeholder is the search.
  final String searchInputPlaceholder;
}

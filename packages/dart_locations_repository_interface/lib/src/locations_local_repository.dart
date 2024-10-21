import "dart:async";

import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:rxdart/subjects.dart";

///
final List<(String, String)> places = [
  (
    "The Book Nook",
    "A cozy bookstore filled with a curated selection of literary classics, "
        "bestsellers, and hidden gems, perfect for book lovers seeking their "
        "next great read."
  ),
  (
    "Golden Grain Bakery",
    "A charming bakery specializing in freshly baked breads, pastries, and "
        "artisan treats, made with locally sourced ingredients and a touch of "
        "love."
  ),
  (
    "Van Dijk Fashion House",
    "An upscale boutique offering the latest trends in fashion and "
        "accessories, tailored to meet the style needs of the modern "
        "individual."
  ),
  (
    "Toy Paradise",
    "A vibrant toy store filled with an extensive range of toys, games, and "
        "educational products designed to inspire creativity and imagination "
        "in children."
  ),
  (
    "Fresh & Green Market",
    "An organic grocery store dedicated to providing fresh produce, "
        "sustainable products, and healthy snacks, promoting a wholesome "
        "lifestyle."
  ),
  (
    "Step by Step Shoe Store",
    "A family-owned shoe store offering a wide selection of stylish and "
        "comfortable footwear for all ages, with personalized fitting services."
  ),
  (
    "The Bike Shop",
    "Your go-to destination for all things cycling, offering a range of bikes, "
        "accessories, and expert repairs to keep you on the road."
  ),
  (
    "The Flower Studio",
    "A floral shop that crafts stunning bouquets and arrangements for every "
        "occasion, using seasonal blooms and sustainable practices."
  ),
  (
    "Sunlight Jewelry",
    "A boutique jeweler specializing in handcrafted, ethically sourced jewelry "
        "that adds a touch of elegance and sparkle to any outfit."
  ),
  (
    "Laptop Lounge",
    "A tech-savvy hub offering a range of laptops, accessories, and expert "
        "support, catering to both students and professionals."
  ),
  (
    "The Good Life Cheese Farm",
    "A local cheese shop offering a delightful variety of artisanal cheeses "
        "made from the freshest milk, along with charcuterie and gourmet "
        "pairings."
  ),
  (
    "The Cooking Corner",
    "A culinary store featuring high-quality kitchenware, gourmet ingredients, "
        "and cooking classes for food enthusiasts of all levels."
  ),
  (
    "Brilliant Optics",
    "An optical store providing a range of stylish eyewear and personalized "
        "eye care services to help you see and look your best."
  ),
  (
    "The Bedroom Shop",
    "A home decor store specializing in bedroom furnishings, linens, and "
        "accessories that transform your space into a cozy retreat."
  ),
  (
    "Letterpress Books",
    "A quaint bookstore dedicated to letterpress printed books, offering a "
        "unique collection of artisanal prints and literary treasures."
  ),
  (
    "The Home Haven",
    "A home goods store offering a wide selection of decor, furniture, and "
        "accessories to create a warm and inviting living space."
  ),
  (
    "Little Joy Coffee Bar",
    "A cozy coffee shop serving specialty coffees, teas, and baked goods, "
        "perfect for a relaxing break or a casual meet-up."
  ),
  (
    "The Butcher's Block",
    "A local butcher shop providing high-quality meats, artisanal sausages, "
        "and expert advice for all your cooking needs."
  ),
  (
    "The Fishery",
    "A fresh seafood market offering a variety of sustainably sourced fish "
        "and seafood, along with cooking tips and recipes."
  ),
  (
    "Healthy Living Pharmacy",
    "A pharmacy focused on holistic health, offering natural remedies, "
        "vitamins, and wellness products alongside traditional medications."
  ),
  (
    "Jewelry Heaven",
    "An exquisite jewelry store showcasing a wide range of fine jewelry, "
        "from engagement rings to statement pieces for any occasion."
  ),
  (
    "Tech World",
    "A tech retailer offering the latest gadgets, electronics, and "
        "accessories, with knowledgeable staff to assist with your tech needs."
  ),
  (
    "The Woodworker’s Den",
    "A woodworking shop providing quality tools, supplies, and workshops for "
        "both novice and experienced woodworkers."
  ),
  (
    "The Surprise Gift Shop",
    "A delightful gift store featuring unique and thoughtful gifts for every "
        "occasion, making gift-giving a joy."
  ),
  (
    "The Kids' Room",
    "A charming children's store filled with toys, books, and decor that make "
        "every child's room a special place."
  ),
  (
    "Flash Photo Studio",
    "A photography studio specializing in capturing life's special moments "
        "through professional photography services and prints."
  ),
  (
    "Fast Pass Sports",
    "A sporting goods store offering a wide range of equipment and apparel "
        "for all your athletic needs, from casual to competitive."
  ),
  (
    "The Wine Cellar",
    "A sophisticated wine shop featuring an extensive selection of wines "
        "from around the world, along with expert tasting recommendations."
  ),
  (
    "Green Bliss Garden Center",
    "A garden center offering a variety of plants, gardening supplies, and "
        "expert advice for green thumbs of all levels."
  ),
  (
    "Denim Palace",
    "A stylish denim retailer providing a variety of jeans and casual wear "
        "for every body type and fashion taste."
  ),
  (
    "The Paint Pot",
    "An art supply store dedicated to providing quality paints, brushes, and "
        "materials for artists of all skill levels."
  ),
  (
    "Atmosphere & Style Home Decor",
    "A home decor store offering curated collections that enhance the ambiance "
        "of any space with style and elegance."
  ),
  (
    "Old & Treasured Antiques",
    "An antique shop specializing in unique vintage finds and collectibles "
        "that tell a story and add character to your home."
  ),
  (
    "The Music Temple",
    "A music store offering instruments, accessories, and expert lessons for "
        "musicians of all ages and skill levels."
  ),
  (
    "The Hop Bell Brewery",
    "A local brewery crafting a variety of beers with unique flavors, offering "
        "tastings and tours to share the brewing experience."
  ),
  (
    "Scented Treasures Perfume",
    "A fragrance boutique specializing in handcrafted perfumes and scented "
        "products that elevate your personal style."
  ),
  (
    "Flavor Kingdom Cooking Studio",
    "A cooking studio offering hands-on classes and culinary experiences that "
        "celebrate flavors from around the world."
  ),
  (
    "The Fabric Shop",
    "A fabric store providing a wide selection of fabrics, sewing supplies, "
        "and classes for sewing enthusiasts."
  ),
  (
    "The Playhouse",
    "A toy and game store offering a curated selection of educational toys, "
        "board games, and activities for family fun."
  ),
  (
    "The Ice Cream Parlor",
    "A nostalgic ice cream shop serving a variety of delicious flavors, "
        "sundaes, and sweet treats to delight your taste buds."
  ),
  (
    "Art Room Gallery",
    "A contemporary art gallery showcasing local and international artists, "
        "offering exhibitions, workshops, and art sales."
  ),
  (
    "The Cheese Master",
    "A specialty cheese shop offering an exquisite selection of cheeses and "
        "gourmet accompaniments, perfect for cheese lovers."
  ),
  (
    "The Beauty Studio",
    "A beauty salon offering a range of services, from haircuts to skincare "
        "treatments, for a complete pampering experience."
  ),
  (
    "The Farmer’s Market",
    "A vibrant market featuring local produce, handmade goods, and artisanal "
        "products, promoting sustainable living."
  ),
  (
    "Pet Heaven Animal Dreams",
    "A pet store providing high-quality pet products, food, and accessories, "
        "along with adoption services for furry friends."
  ),
  (
    "The Bag Shop",
    "A stylish boutique offering a variety of bags, purses, and accessories "
        "to complement any outfit."
  ),
  (
    "The Treehouse Kids' Clothing",
    "A children’s clothing store featuring stylish and comfortable apparel "
        "for kids of all ages."
  ),
  (
    "Night Watch Sleep Comfort",
    "A sleep specialty store offering mattresses, bedding, and sleep products "
        "designed for optimal comfort and rest."
  ),
  (
    "The Game Chest",
    "A gaming store providing a wide selection of video games, board games, "
        "and gaming accessories for enthusiasts of all ages."
  ),
  (
    "The Travel Café",
    "A café that combines the love of travel and coffee, serving global "
        "flavors and providing travel inspiration through décor."
  ),
];

/// Local in memory implementation of the locations repository.
class LocationsLocalRepository
    implements LocationsRepositoryInterface<DefaultLocationItem> {
  /// Create a singleton locations repository containing locations in the
  /// netherlands
  factory LocationsLocalRepository({int density = 50}) =>
      _instance ??= LocationsLocalRepository.forArea(
        northWest: const Location(latitude: 52.490028, longitude: 4.829669),
        southEast: const Location(latitude: 51.884544, longitude: 6.535011),
        density: density,
      );

  /// Instantiates a local Locations repository with initial locations in a
  /// given geographical area.
  factory LocationsLocalRepository.forArea({
    required Location northWest,
    required Location southEast,
    int density = 10,
  }) {
    assert(
      northWest.latitude > southEast.latitude,
      "northWest property should be north of the southEast",
    );

    if (density < 1) {
      return LocationsLocalRepository.withItems(items: []);
    }

    var startY = southEast.latitude;
    var endY = northWest.latitude;
    var startX = northWest.longitude;
    var endX = southEast.longitude;
    if (endX < startX) {
      endX += 360;
    }
    var xStep = (endX - startX) / density;
    var yStep = (endY - startY) / density;

    var items = <DefaultLocationItem>[];

    var index = 0;
    for (var x = 0; x < density; x++) {
      for (var y = 0; y < density; y++) {
        index++;
        var location = Location(
          longitude: xStep * x + startX,
          latitude: yStep * y + startY,
        );

        var place = places[index % places.length];

        items.add(
          DefaultLocationItem(
            location: location.normalizeLongitude(),
            locationId: "$index",
            locationTitle: place.$1,
            locationDescription: place.$2,
          ),
        );
      }
    }

    return LocationsLocalRepository.withItems(items: items);
  }

  /// Instantiates a local Locations repository for a set of items;
  LocationsLocalRepository.withItems({
    required List<DefaultLocationItem> items,
  }) : _items = items {
    _locationsStream.add(_items);
  }

  static LocationsLocalRepository? _instance;

  final List<DefaultLocationItem> _items;

  final StreamController<List<DefaultLocationItem>> _locationsStream =
      BehaviorSubject<List<DefaultLocationItem>>();
  @override
  Stream<List<DefaultLocationItem>> getLocations({
    LocationsFilter? filter,
  }) =>
      _locationsStream.stream
          .map((locations) => filter?.filterItems(locations) ?? locations);

  @override
  Stream<DefaultLocationItem> getLocationForId(String locationId) =>
      getLocations().map(
        (locations) => locations.firstWhere(
          (location) => location.locationId == locationId,
          orElse: () {
            throw LocationForIdDoesNotExistException(locationId);
          },
        ),
      );
}

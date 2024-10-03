import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:test/test.dart";

void main() {
  group("LocationBounds", () {
    group("contains", () {
      var minLongitude = -90.0;
      var maxLongitude = 90.0;

      var minLatitude = -50.0;
      var maxLatitude = 50.0;

      LocationBounds getNormalLocationBounds() => LocationBounds(
            northWest: Location(latitude: maxLatitude, longitude: minLongitude),
            southEast: Location(latitude: minLatitude, longitude: maxLongitude),
          );

      LocationBounds getAntiMeridianCrossingBounds() => LocationBounds(
            northWest: Location(latitude: maxLatitude, longitude: maxLongitude),
            southEast: Location(latitude: minLatitude, longitude: minLongitude),
          );

      var westButLatitudeCorrect = const Location(latitude: 0, longitude: -100);
      var eastButLatitudeCorrect = const Location(latitude: 0, longitude: 100);
      var northButLongitudeCorrect = const Location(latitude: 60, longitude: 0);
      var southButLongitudeCorrect =
          const Location(latitude: -60, longitude: 0);

      var withinBounds = const Location(latitude: 0, longitude: 0);

      test("Should be false if its west of given bounds", () {
        var sut = getNormalLocationBounds();

        var result = sut.contains(westButLatitudeCorrect);

        expect(result, isFalse);
      });

      test("Should be false if its east of given bounds", () {
        var sut = getNormalLocationBounds();

        var result = sut.contains(eastButLatitudeCorrect);

        expect(result, isFalse);
      });

      test("Should be false if its north of given bounds", () {
        var sut = getNormalLocationBounds();

        var result = sut.contains(northButLongitudeCorrect);

        expect(result, isFalse);
      });

      test("Should be false if its south of given bounds", () {
        var sut = getNormalLocationBounds();

        var result = sut.contains(southButLongitudeCorrect);

        expect(result, isFalse);
      });

      test("Should be true if its within given bounds", () {
        var sut = getNormalLocationBounds();

        var result = sut.contains(withinBounds);

        expect(result, isTrue);
      });

      test(
        "Should be false if its outside bounds crossing the antimeridian",
        () {
          var sut = getAntiMeridianCrossingBounds();

          var result = sut.contains(withinBounds);

          expect(result, isFalse);
        },
      );

      test(
        "Should be true if its positive within "
        "bounds crossing the antimeridian",
        () {
          var sut = getAntiMeridianCrossingBounds();

          var result = sut.contains(eastButLatitudeCorrect);

          expect(result, isTrue);
        },
      );

      test(
        "Should be true if its negative within "
        "bounds crossing the antimeridian",
        () {
          var sut = getAntiMeridianCrossingBounds();

          var result = sut.contains(eastButLatitudeCorrect);

          expect(result, isTrue);
        },
      );
    });
  });
}

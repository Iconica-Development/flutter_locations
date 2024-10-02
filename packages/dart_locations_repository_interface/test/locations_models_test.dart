import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:test/test.dart";

void main() {
  group("Location", () {
    group("normalizeLongitude", () {
      test(
        "should reduce overflows above 180 to a negative number",
        () {
          var sut = const Location(longitude: 185.0, latitude: 0);

          var result = sut.normalizeLongitude();

          expect(result.longitude, equals(-175.0));
        },
      );

      test(
        "should reduce overflows below -180 to a positive number",
        () {
          var sut = const Location(longitude: -185.0, latitude: 0);

          var result = sut.normalizeLongitude();

          expect(result.longitude, equals(175.0));
        },
      );
      test(
        "should reduce overflows exceeding 360 degrees to "
        "a correct negative number",
        () {
          var sut = const Location(longitude: 530.0, latitude: 0);

          var result = sut.normalizeLongitude();

          expect(result.longitude, equals(170.0));
        },
      );
      test(
        "should reduce overflows exceeding 360 degrees to "
        "a correct positive number",
        () {
          var sut = const Location(longitude: 550.0, latitude: 0);

          var result = sut.normalizeLongitude();

          expect(result.longitude, equals(-170.0));
        },
      );
    });
  });
}

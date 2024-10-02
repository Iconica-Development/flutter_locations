import "package:dart_locations_repository_interface/dart_locations_repository_interface.dart";
import "package:mocktail/mocktail.dart";
import "package:test/test.dart";

import "mocks.dart";

void main() {
  group("LocationsService", () {
    late LocationsService<TestLocationItem> sut;
    late LocationsRepositoryInterface<TestLocationItem> locationsRepositoryMock;

    setUp(() {
      locationsRepositoryMock = MockedLocationsRepository();
      sut = LocationsService(
        locationsRepositoryInterface: locationsRepositoryMock,
      );
    });

    group("getLocations", () {
      test(
        "Should return a list of locations found in the repository",
        () {
          var expectedResult = [
            TestLocationItem.nextScoped("getLocationsSingle"),
          ];
          when(() => locationsRepositoryMock.getLocations())
              .thenAnswer((_) async* {
            yield expectedResult;
          });

          var stream = sut.getLocations();

          expect(stream, emitsInOrder([expectedResult]));
        },
      );

      test(
        "should return multiple lists of locations "
        "if new updates are found in the repository",
        () {
          var scope = "getMultipleLocationsUpdates";
          var firstResult = [
            TestLocationItem.nextScoped(scope),
          ];
          var secondResult = [
            TestLocationItem.nextScoped(scope),
            TestLocationItem.nextScoped(scope),
          ];
          when(() => locationsRepositoryMock.getLocations())
              .thenAnswer((_) async* {
            yield firstResult;
            await Future.delayed(Duration.zero);
            yield secondResult;
          });

          var stream = sut.getLocations();

          expect(stream, emitsInOrder([firstResult, secondResult]));
        },
      );
    });

    group("getLocationForId", () {
      test(
        "should return a single location provided by the repository",
        () {
          var scope = "getSingleLocationForId";
          var initialLocation = TestLocationItem.nextScoped(scope);
          when(
            () => locationsRepositoryMock.getLocationForId(
              any(that: equals(initialLocation.locationId)),
            ),
          ).thenAnswer((_) async* {
            yield initialLocation;
          });

          var stream = sut.getLocationForId(initialLocation.locationId);

          expect(stream, emitsInOrder([initialLocation]));
        },
      );
      test(
        "should return multiple updates of a single location "
        "provided by the repository",
        () {
          var scope = "getUpdatingLocationForId";
          var initialLocation = TestLocationItem.nextScoped(scope);
          var updatedLocation = initialLocation.update();

          when(
            () => locationsRepositoryMock.getLocationForId(
              any(that: equals(initialLocation.locationId)),
            ),
          ).thenAnswer((_) async* {
            yield initialLocation;
            await Future.delayed(Duration.zero);
            yield updatedLocation;
          });

          var stream = sut.getLocationForId(initialLocation.locationId);

          expect(stream, emitsInOrder([initialLocation, updatedLocation]));
        },
      );
      test(
        "should throw LocationForIdDoesNotExistException "
        "if the repository has no location for the given id",
        () {
          var expectedException = LocationForIdDoesNotExistException("1");
          when(
            () => locationsRepositoryMock.getLocationForId(
              any(that: equals(expectedException.locationId)),
            ),
          ).thenAnswer(
            (_) async* {
              yield* Stream.value(<TestLocationItem>[]).map(
                (e) => e.firstWhere(
                  (_) => true,
                  orElse: () => throw expectedException,
                ),
              );
            },
          );

          var stream = sut.getLocationForId(expectedException.locationId);

          expect(stream, emitsError(equals(expectedException)));
        },
      );
    });
  });
}

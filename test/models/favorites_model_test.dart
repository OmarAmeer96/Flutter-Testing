import 'package:flutter_testing_methods/models/favorites_model.dart';
import 'package:test/test.dart';

void main() {
  // The Flutter testing framework allows you to bind similar tests related to each other in a group.
  // There can be multiple groups in a single test file intended to test different parts of the corresponding file in the lib directory.
  /*
    Each [Group - Test] containes a "description" and a "callback function",
    where the description is a string that describes the group or test,
    and the callback function is where you write the test code for tests, or the tests for groups.
  */
  group(
    'Testing App Provider',
    () {
      var favorites = Favorites();

      // Test 1
      test('A new item should be added', () {
        var number = 35;
        favorites.add(number);
        expect(favorites.items.contains(number), true);
      });

      // Test 2
      test('An item should be removed', () {
        // Adding the number to the list
        var number = 45;
        favorites.add(number);
        expect(favorites.items.contains(number), true);

        // Remove the number
        favorites.remove(number);
        expect(favorites.items.contains(number), false);
      });
    },
  );
}

// Run the test by running the following command in the terminal:
// flutter test test/models/favorites_model_test.dart

// Tip: You can run all the tests in the test directory at once by running:
// flutter test

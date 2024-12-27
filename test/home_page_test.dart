import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_methods/models/favorites_model.dart';
import 'package:flutter_testing_methods/screens/home_page.dart';
import 'package:provider/provider.dart';

/* 
  - Widget testing is unique to Flutter, where you can test each widget in an isolated fashion.

  - Widget testing uses the testWidget() function instead of the test() function. 
    Like the test() function, the testWidget() function takes two parameters: description, 
    and callback, however the callback takes a WidgetTester as its argument.

  - Widget tests use TestFlutterWidgetsBinding, a class that provides the same 
    resources to your widgets that they would have in a running app

  - Here, pumpWidget kicks off the process by telling the framework to 
    mount and measure a particular widget just as it would in an application.
*/

/// The [createHomeScreen] function is used to create an app that loads the widget to be tested in a MaterialApp, wrapped into a ChangeNotifierProvider.
/// This function is passed as a parameter to the pumpWidget() function.
Widget createHomeScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );

// If you are using the BlocProvider, you can use the following code:
// Widget createHomeScreen() => BlocProvider<FavoritesBloc>(
//   create: (context) => FavoritesBloc(),
//   child: const MaterialApp(
//     home: HomePage(),
//   ),
// );

void main() {
  group('Home Page Widget Tests', () {
    // The testWidgets() function is used to test widgets in Flutter.
    // The testWidgets() function takes two parameters: description and callback.
    // The callback function takes a WidgetTester as its argument.

    // Testing if the ListView shows up
    testWidgets('Testing if ListView shows up', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      // The test verifies that the widget is present in the widget tree.
      expect(find.byType(ListView), findsOneWidget);
    });

    // Testing if the ListView scrolls correctly
    testWidgets('Testing Scrolling', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      // The widget testing framework provides finders to find widgets, for example "text()", "byType()", and "byIcon()".
      // The framework also provides matchers to verify the results. For example, "findsOneWidget", "findsNothing", and "findsNWidgets".
      // The find.text() function finds a widget that contains the specified text.
      // The findsOneWidget matcher checks that the widget is present in the widget tree.
      expect(find.text('Item 0'), findsOneWidget);
      // The tester.fling() function simulates a fling gesture on the widget.
      // The fling gesture is a swipe gesture that moves the widget in the specified direction.
      // The fling() function takes the following parameters:
      // 1. The widget to fling.
      // 2. The offset to move the widget.
      // 3. The velocity of the fling.

      await tester.fling(
        find.byType(ListView),
        const Offset(0, -200),
        3000,
      );
      // The tester.pumpAndSettle() function waits for the widget to settle after the fling gesture.
      // The pumpAndSettle() function waits for the widget to finish any animations or asynchronous tasks.
      // This ensures that the widget is in a stable state before running the next test.
      await tester.pumpAndSettle();
      // The find.text() function finds a widget that contains the specified text.
      // The findsNothing matcher checks that the widget is not present in the widget tree.
      // The test verifies that the widget is no longer visible after the fling gesture.
      expect(find.text('Item 0'), findsNothing);
    });

    // Testing if the IconButtons works correctly
    testWidgets('Testing IconButtons', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      // It should not find any favorites initially.
      // The find.byIcon() function finds a widget with the specified icon.
      expect(find.byIcon(Icons.favorite), findsNothing);
      // The tester.tap() function simulates a tap gesture on the widget.
      // The tap() function takes the following parameters:
      // 1. The widget to tap.
      // The tester.pumpAndSettle() function waits for the widget to settle after the tap gesture.
      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      // A snack bar should appear after adding an item to favorites.
      expect(find.text('Added to favorites.'), findsOneWidget);
      // Then the icon should be changed from favorite_border to favorite.
      expect(find.byIcon(Icons.favorite), findsWidgets);
      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Removed from favorites.'), findsOneWidget);
      // After removing the item from favorites, the icon should be changed back to favorite_border.
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}

// To run the test, use the following command:
// flutter test test/home_page_test.dart

// To run the test on the emulator or device, use the following command:
// flutter run test/home_page_test.dart
// Then select the device or emulator where you want to run the test, If it was not running already.

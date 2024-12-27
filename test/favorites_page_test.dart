import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_methods/models/favorites_model.dart';
import 'package:flutter_testing_methods/screens/favorites_page.dart';
import 'package:provider/provider.dart';

late Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: const MaterialApp(
        home: FavoritesPage(),
      ),
    );

void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('Favorites Page Widget Tests', () {
    testWidgets('Test if ListView shows up', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      addItems();
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing Remove Button', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      addItems();
      await tester.pumpAndSettle();

      // The tester.widgetList() function finds all widgets that match the specified finder.
      var totalItems = tester.widgetList(find.byIcon(Icons.close)).length;
      await tester.tap(find.byIcon(Icons.close).first);
      await tester.pumpAndSettle();

      // The length after removing item from the list should be less than the total items.
      expect(tester.widgetList(find.byIcon(Icons.close)).length,
          lessThan(totalItems));
      // The snackbar should show up after removing an item.
      expect(find.text('Removed from favorites.'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Item 0'), findsNothing);
    });
  });
}

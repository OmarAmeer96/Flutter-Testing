import 'package:flutter/material.dart';
import 'package:flutter_testing_methods/screens/album_page.dart';
import 'package:flutter_testing_methods/screens/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'models/favorites_model.dart';
import 'screens/favorites_page.dart';

void main() {
  runApp(const TestingApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
          path: FavoritesPage.routeName,
          builder: (context, state) {
            return const FavoritesPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: AlbumPage.routeName,
      builder: (context, state) {
        return const AlbumPage();
      },
    ),
  ],
);

class TestingApp extends StatelessWidget {
  const TestingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: MaterialApp.router(
        title: 'Testing Sample',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

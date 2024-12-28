import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_testing_methods/models/album_model.dart';
import 'package:http/http.dart' as http;

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  static const String routeName = '/album';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Page'),
      ),
      body: FutureBuilder<Album>(
        future: fetchAlbum(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Title: ${snapshot.data!.title}'),
                  Text('ID: ${snapshot.data!.id}'),
                  Text('User ID: ${snapshot.data!.userId}'),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<Album> fetchAlbum(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

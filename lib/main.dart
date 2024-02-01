import 'package:flutter/material.dart';
import 'package:game_app/form_widget.dart';
import 'package:game_app/interfaces/album.dart';
import 'package:http/http.dart' as http;


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  late Future<List<Album>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: ListView(
          children: [
            MyCustomForm(),
            FutureBuilder(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                    final albums = snapshot.data!;
                    return buildAlbums(albums);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              })
          ],
        )
      ),
    );
  }

  Widget buildAlbums(List<Album> albums) {
    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return Container(
          color: Colors.grey.shade300,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              // Expanded(flex: 1, child: Image.network(album.id!)),
              SizedBox(width: 10),
              Expanded(flex: 3, child: Text(album.title!)),
            ],
          )
        );
        
      },
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }
}


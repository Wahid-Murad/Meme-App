import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meems/model/meme_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meme> memes = [];

  Future<void> fetchMemes() async {
    final response =
        await http.get(Uri.parse('https://api.imgflip.com/get_memes'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final memeData = jsonBody['data']['memes'];
      setState(() {
        memes = memeData.map<Meme>((json) => Meme.fromJson(json)).toList();
      });
    } else {
      // Handle error
      print('Failed to fetch memes');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMemes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meme App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Meme List'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: memes.length,
          itemBuilder: (context, index) {
            final meme = memes[index];
            return ListTile(
              leading: Image.network(meme.url),
              title: Text(meme.name),
              onTap: () {
                // Handle meme item click
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemeDetailsScreen(meme: meme),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class MemeDetailsScreen extends StatelessWidget {
  final Meme meme;

  const MemeDetailsScreen({Key? key, required this.meme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meme.name),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(meme.url),
            SizedBox(height: 16),
            Text('Meme ID: ${meme.id}'),
            Text('Width: ${meme.width}'),
            Text('Height: ${meme.height}'),
            Text('Box Count: ${meme.boxCount}'),
            Text('Captions: ${meme.captions}'),
          ],
        ),
      ),
    );
  }
}

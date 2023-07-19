import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meems/model/meme_model.dart';
import 'package:meems/screen/meme_details_screen.dart';

class MemeListWidget extends StatefulWidget {
  @override
  _MemeListWidgetState createState() => _MemeListWidgetState();
}

class _MemeListWidgetState extends State<MemeListWidget> {
  late Future<List<Meme>> memes;

  @override
  void initState() {
    super.initState();
    memes = fetchMemes();
  }

  Future<List<Meme>> fetchMemes() async {
    final response = await http.get(Uri.parse(
        'https://api.imgflip.com/get_memes')); // Replace with your API URL
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final memesData = data['data']['memes'] as List<dynamic>;
      return memesData.map((json) => Meme.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch memes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meme>>(
      future: memes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final memes = snapshot.data!;
          return ListView.builder(
            itemCount: memes.length,
            itemBuilder: (context, index) {
              final meme = memes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemeDetailsScreen(meme: meme),
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.network(meme.url),
                  title: Text(meme.name),
                ),
              );
            },
          );
        }
      },
    );
  }
}

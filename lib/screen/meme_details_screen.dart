import 'package:flutter/material.dart';
import 'package:meems/model/meme_model.dart';

class MemeDetailsScreen extends StatelessWidget {
  final Meme meme;

  const MemeDetailsScreen({required this.meme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meme Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(meme.url),
            SizedBox(height: 16),
            Text(meme.name),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final List<Map<String, dynamic>> imageData;

  ImagePage(this.imageData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
      ),
      body: ListView.builder(
        itemCount: imageData.length,
        itemBuilder: (context, index) {
          final cat = imageData[index];
          return ListTile(
            title: Text('Cat Image'),
            subtitle: Image.network(cat['url']),
          );
        },
      ),
    );
  }
}

class GifPage extends StatelessWidget {
  final List<Map<String, dynamic>> gifData;

  GifPage(this.gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GIFs'),
      ),
      body: ListView.builder(
        itemCount: gifData.length,
        itemBuilder: (context, index) {
          final cat = gifData[index];
          return ListTile(
            title: Text('Cat GIF'),
            subtitle: Image.network(cat['url']),
          );
        },
      ),
    );
  }
}

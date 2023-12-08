import 'package:flutter/material.dart';


class Searchscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search Bar and Icons'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0), // Spacer

              // Icons in Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // GIF Icon
                  Image.asset(
                    'assets/loading_icon.gif',
                    height: 50.0,
                    width: 50.0,
                  ),

                  // Image Icon
                  Icon(
                    Icons.image,
                    size: 50.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
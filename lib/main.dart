import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'Screens/searchScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat API Integration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> imageList = [];
  List<Map<String, dynamic>> gifList = [];

  @override
  void initState() {
    super.initState();
    // Fetch default data when the app starts
    fetchImageData();
  }

  Future<void> fetchImageData() async {
    await fetchData('.jpg');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImagePage(imageList)),
    );
  }

  Future<void> fetchGifData() async {
    await fetchData('.gif');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GifPage(gifList)),
    );
  }

  Future<void> fetchData(String fileExtension) async {
    // Fetch data
    String apiKey = 'live_qR1WucNCBU6OyNRCQfAgWXFQP2nSbqvejRu18ILU1XANWSDjSR0pshgdwv8QoBcQ';
    String apiUrl = 'https://api.thecatapi.com/v1/images/search?limit=10&has_breeds=0&api_key=$apiKey';

    Dio dio = Dio();
    dio.options.headers['x-api-key'] = apiKey;

    try {
      Response response = await dio.get(apiUrl);
      List<dynamic> responseData = response.data;

      // Filter data based on file extension
      List<Map<String, dynamic>> filteredData = List<Map<String, dynamic>>.from(responseData)
          .where((data) => data['url'].toLowerCase().endsWith(fileExtension))
          .toList();

      // Update the appropriate list based on the file extension
      if (fileExtension == '.jpg') {
        imageList = List<Map<String, dynamic>>.from(filteredData);
      } else if (fileExtension == '.gif') {
        gifList = List<Map<String, dynamic>>.from(filteredData);
      }

    } catch (error) {
      // Handle errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat API Integration'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: fetchImageData,
            child: Text('Fetch Images'),
          ),
          ElevatedButton(
            onPressed: fetchGifData,
            child: Text('Fetch GIFs'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sananthan_task_fexcon/Screens/gifpage_imagepage.dart';

import '../Api/api functions and search.dart';






class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> imageList = [];
  List<Map<String, dynamic>> gifList = [];
  List<Map<String, dynamic>> catList = [];
  Map<String, dynamic> searchCatData = {};

  @override
  void initState() {
    super.initState();
    // Fetch default data when the app starts
    fetchCatData();
  }

  Future<void> fetchCatData() async {
    String apiKey = 'live_qR1WucNCBU6OyNRCQfAgWXFQP2nSbqvejRu18ILU1XANWSDjSR0pshgdwv8QoBcQ';
    String apiUrl = 'https://api.thecatapi.com/v1/images/search?limit=10&has_breeds=0&api_key=$apiKey';

    Dio dio = Dio();
    dio.options.headers['x-api-key'] = apiKey;

    try {
      Response response = await dio.get(apiUrl);
      List<dynamic> responseData = response.data;

      setState(() {
        catList = List<Map<String, dynamic>>.from(responseData);
      });
    } catch (error) {
      // Handle errors
      print('Error: $error');
    }
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
  Future<void> SearchCatData(String id) async {
    String apiKey = 'live_PBVQaQm2fy28sCKAhyp5F3hSh8stFWUYnX8P3UxzAHmgdhrafByrzwm07Mucrcqt'; // Replace with your actual API key
    String apiUrl = 'https://api.thecatapi.com/v1/images/$id';

    Dio dio = Dio();
    dio.options.headers['x-api-key'] = apiKey;

    try {
      Response response = await dio.get(apiUrl);
      Map<String, dynamic> responseData = response.data;

      setState(() {
        searchCatData = responseData;

      });
      print(searchCatData);
      print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");

    } catch (error) {
      // Handle errors
      print('Error: $error');
    }
  }

  void search(String query) {
    // Filter the catList based on the search query
    List<Map<String, dynamic>> filteredList = catList.where((cat) {
      return cat['url'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    // Update the UI with the filtered list
    setState(() {
      catList = filteredList;
    });
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(

                  ),
                ),
              );
            },
            child: Text('Search'),
          ),

          ElevatedButton(
            onPressed: fetchImageData,
            child: Text('Fetch Images'),
          ),
          ElevatedButton(
            onPressed: fetchGifData,
            child: Text('Fetch GIFs'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: catList.length,
              itemBuilder: (context, index) {
                final cat = catList[index];
                return ListTile(
                  title: Text('Cat Image'),
                  subtitle: Image.network(cat['url']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

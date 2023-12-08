import 'package:flutter/material.dart';
import 'package:dio/dio.dart';




class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Map<String, dynamic>> catData = [];
  Map<String, dynamic> searchCatData = {};
  String userInput = '';

  @override
  void initState() {
    super.initState();
    fetchCatData();

  }

  Future<void> fetchCatData() async {
    String apiKey = 'live_qR1WucNCBU6OyNRCQfAgWXFQP2nSbqvejRu18ILU1XANWSDjSR0pshgdwv8QoBcQ'; // Replace with your actual API key
    String apiUrl = 'https://api.thecatapi.com/v1/images/search?limit=10&has_breeds=0&api_key=apiKey';


    Dio dio = Dio();
    dio.options.headers['x-api-key'] = apiKey;

    try {
      Response response = await dio.get(apiUrl);
      List<dynamic> responseData = response.data;

      setState(() {
        catData = List<Map<String, dynamic>>.from(responseData);
      });
      for (var data in catData){
        print('$data.id');
        print('$data.description');
        print('$data.url');
        await SearchCatData('$data.id');
      }

    } catch (error) {
      // Handle errors
      print('Error: $error');
    }
  }
  Future<void> SearchCatData(String id) async {
    print(("-----------------------------------------"));
    print("-------ID-------------------------$id");
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat API Integration'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  userInput = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter a category',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          searchCatData.isEmpty
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
            itemCount: searchCatData.length,
            itemBuilder: (context, index) {
              final cat = searchCatData[index];
              if (cat['categories'].isNotEmpty &&
                  cat['categories'][0]['name'] == userInput) {
                return ListTile(
                  title: Text('Cat Image'),
                  subtitle: Image.network(cat['url']),
                );
              } else {
                // Return an empty container if the condition is not met
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}


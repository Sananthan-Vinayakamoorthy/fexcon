import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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
  List<Map<String, dynamic>> catData = [];

  @override
  void initState() {
    super.initState();
    fetchCatData();
  }

  Future<void> fetchCatData() async {
    String apiKey = 'live_qR1WucNCBU6OyNRCQfAgWXFQP2nSbqvejRu18ILU1XANWSDjSR0pshgdwv8QoBcQ'; // Replace with your actual API key
    String apiUrl = 'https://api.thecatapi.com/v1/breeds';

    Dio dio = Dio();
    dio.options.headers['x-api-key'] = apiKey;

    try {
      Response response = await dio.get(apiUrl);
      List<dynamic> responseData = response.data;

      setState(() {
        catData = List<Map<String, dynamic>>.from(responseData);
      });
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
      body: catData.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: catData.length,
        itemBuilder: (context, index) {
          final breed = catData[index];
          return ListTile(
            title: Text(breed['name']),
            subtitle: Text(breed['description']),
          );
        },
      ),
    );
  }
}
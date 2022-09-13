import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List> _loadData() async{
    List posts = [];
    try{
      const apiUrl = 'https://jsonplaceholder.typicode.com/posts';
      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);
    }catch(err){
      if (kDebugMode) {
        print(err);
      }
    }
    return posts;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('ListViewFutureBuilder'),
      ),
      body: FutureBuilder(
        future: _loadData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) =>
            snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) =>  Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Text(snapshot.data![index]['title']),
                      subtitle: Text(snapshot.data![index]['body']),
                    ),

                  ),
                ):
                const Center(
                 child: CircularProgressIndicator(),
                )
      ),
    );
  }
}

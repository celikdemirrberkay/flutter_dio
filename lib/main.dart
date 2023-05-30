import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final dio = Dio();
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: const Text('Dio Usage'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var map = snapshot.data!.data;
              return ListView.builder(
                itemCount: map.length,
                itemBuilder: (context, index) {
                  var lastResponse = User.fromJson(snapshot.data!.data[index]);
                  return ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    tileColor: Colors.purple[50],
                    leading: CircleAvatar(
                      child: Text(
                        lastResponse.id.toString(),
                      ),
                    ),
                    title: Text(
                      '${lastResponse.body}',
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      lastResponse.title,
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(strokeWidth: 5),
                ],
              ));
            }
            return const Center(child: Text("Something went wrong"));
          },
        ),
      ),
    );
  }

  Future<Response> getData() async {
    var response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    return response;
  }
}

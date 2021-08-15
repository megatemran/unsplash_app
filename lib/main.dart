import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'next_page.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

// https://api.unsplash.com/photos?client_id=K9fzIEZA9C4Cu6z4hqE9c6x0MRsQyju4cs8LzX7QhKk
// https://api.unsplash.com/search/photos?page=1&query=office&client_id=K9fzIEZA9C4Cu6z4hqE9c6x0MRsQyju4cs8LzX7QhKk
  void getDataFromJson(String _search) async {
    var url = Uri.parse(
        'https://api.unsplash.com/search/photos?per_page=30&client_id=K9fzIEZA9C4Cu6z4hqE9c6x0MRsQyju4cs8LzX7QhKk&query=$_search');

    var response = await http.get(url);

    datas = jsonDecode(response.body);
    assignData();
    setState(() {
      isLoading = true;
    });
  }

  assignData() {
    for (var i = 0; i < datas.length; i++) {
      listImgUrls.add(datas.elementAt(i)['urls']['regular']);
    }
    // print(listImgUrls);
  }

  List datas = [];
  List<String> listImgUrls = [];
  void getjsondata(String _search) async {
    try {
      var response = await Dio().get(
          'https://api.unsplash.com/search/photos?per_page=30&client_id=K9fzIEZA9C4Cu6z4hqE9c6x0MRsQyju4cs8LzX7QhKk&query=$_search');
      //var responseBody = response.data;

      // final result = jsonDecode(response.data);
      // final result2 = json.decode(response.body!);
      // final result3 = json.decode(response.data);
      print(response.data.results);
      // print(result2);
      //print(result3);
      // datas = json.decode(responseBody);
      // for (var i = 0; i < datas.length; i++) {
      //   listImgUrls.add(datas.elementAt(i)['urls']['regular']);
      // }
      print('--------------------------------- $listImgUrls');
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => NextPage());
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          getjsondata(searchController.text);
          // getDataFromJson(searchController.text);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                ),
                Container(
                  height: 1000,
                  child: ListView.separated(
                    itemCount: listImgUrls.length,
                    itemBuilder: (context, index) {
                      return isLoading == true
                          ? Image(
                              image: NetworkImage(
                                listImgUrls[index],
                              ),
                              fit: BoxFit.cover,
                            )
                          : Center(child: CircularProgressIndicator());
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

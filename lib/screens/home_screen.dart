import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/posts.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Posts> postsList = [];

  Future<List<Posts>> getPostsList() async {
    final response =
        await http.get(Uri.parse(Constants.BASE_URL + Constants.POSTS_URL));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postsList.clear();
      for (Map i in data) {
        postsList.add(Posts.fromJson(i));
      }
      return postsList;
    } else {
      return postsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Rest Apis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPostsList(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: postsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      postsList[index].id.toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Title:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(postsList[index].title.toString()),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Description:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(postsList[index].body.toString()),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

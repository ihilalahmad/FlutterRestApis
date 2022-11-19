import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_apis/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../models/photos.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotosList() async {
    final response =
        await http.get(Uri.parse(Constants.BASE_URL + Constants.PHOTOS_URL));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      photosList.clear();
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
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
                  future: getPhotosList(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text('Loading...'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: photosList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  photosList[index].url.toString()),
                            ),
                            title: Text(photosList[index].title.toString()),
                            subtitle: Text('This is subtitle'),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

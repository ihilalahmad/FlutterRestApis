import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class UserScreenWithoutModel extends StatefulWidget {
  const UserScreenWithoutModel({Key? key}) : super(key: key);

  @override
  State<UserScreenWithoutModel> createState() => _UserScreenWithoutModelState();
}

class _UserScreenWithoutModelState extends State<UserScreenWithoutModel> {
  var data;

  Future<void> getUsersList() async {
    final response =
        await http.get(Uri.parse(Constants.BASE_URL + Constants.USERS_URL));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    }else{
      print('No user found');
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
                  future: getUsersList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text('Loading...'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(data[index]['name'].toString()),
                            subtitle:
                            Text(data[index]['email'].toString()),
                            trailing: Text(
                                data[index]['company']['name'].toString()),
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

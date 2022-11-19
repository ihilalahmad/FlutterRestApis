import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/Users.dart';
import '../utils/constants.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<Users> usersList = [];

  Future<List<Users>> getUsersList() async {
    final response =
        await http.get(Uri.parse(Constants.BASE_URL + Constants.USERS_URL));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      usersList.clear();
      for (Map i in data) {
        usersList.add(Users.fromJson(i));
      }
      return usersList;
    } else {
      return usersList;
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
                  builder: (context, AsyncSnapshot<List<Users>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text('Loading...'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: usersList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name.toString()),
                            subtitle:
                                Text(snapshot.data![index].email.toString()),
                            trailing: Text(
                                snapshot.data![index].company!.name.toString()),
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

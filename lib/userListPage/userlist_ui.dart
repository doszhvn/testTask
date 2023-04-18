import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

import 'model/userlist_model.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<User>> _userFuture;
  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUser();
  }

  void _refreshPage() {
    setState(() {});
  }

  List<User> users = [];
  Future<List<User>> _fetchUser() async {
    final response = await get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    final jsonData = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in jsonData) {
        users.add(User.fromJson(index));
      }
      return users;
    } else {
      return users;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left),
            iconSize: 35,
            color: Colors.black,
          ),
          title: Text(
            'Пользователи',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<List<User>>(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                          height: 100,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.cen,
                            children: [
                              SizedBox(width: 20),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    // color: Colors.white,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage("assets/user.png"))),
                              ),
                              SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    users[index].name.toString(),
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    users[index].email.toString(),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(users[index].website.toString()),
                                ],
                              )
                            ],
                          ));
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            // color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/error.png"))),
                      ),
                      Text(
                        'Не удалось загрузить информацию',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                          // height: 250,
                          ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                            fixedSize: Size(250, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22))),
                        onPressed: () {
                          _fetchUser();
                        },
                        child: const Text(
                          'Обновить',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                        strokeWidth: 5,
                      )),
                );
              }
            }));
  }
}

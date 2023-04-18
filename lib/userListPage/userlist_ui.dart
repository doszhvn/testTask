import 'dart:convert';

import 'package:flutter/material.dart';
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
        body: FutureBuilder<List<User>>(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      backgroundColor: Colors.white,
                      expandedHeight: 100,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          'Пользователи',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return SizedBox(
                              height: 100,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.cen,
                                children: [
                                  const SizedBox(width: 20),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        // color: Colors.white,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                AssetImage("assets/user.png"))),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        users[index].name.toString(),
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        users[index].email.toString(),
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      Text(users[index].website.toString()),
                                    ],
                                  )
                                ],
                              ));
                        },
                        childCount: snapshot.data?.length,
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 200,
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
                      const Text(
                        'Не удалось загрузить информацию',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            fixedSize: const Size(250, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Обновить',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 250,
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: SizedBox(
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

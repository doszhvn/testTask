import 'package:flutter/material.dart';

import '../userListPage/userlist_ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hidePass = false;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.86,
                child: const Text(
                  'Вход',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 40,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(50, 20, 50, 40),
                decoration: (BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20))),
                height: MediaQuery.of(context).size.width * 0.86,
                width: MediaQuery.of(context).size.width * 0.86,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ThemeData().colorScheme.copyWith(
                              primary: Colors.purple.shade700,
                            ),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ThemeData().colorScheme.copyWith(
                              primary: Colors.purple.shade700,
                            ),
                      ),
                      child: TextFormField(
                        controller: _passController,

                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Пароль",
                        ),
                        obscureText: _hidePass,
                        // suffixIcon: IconButton(
                        //   icon: Icon(
                        //       _hidePass ? Icons.visibility : Icons.visibility_off),
                        //   onPressed: () {
                        //     _hidePass = !_hidePass;
                        //   },
                        // ),
                      ),
                    ),
                    const SizedBox(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade700,
                          fixedSize: const Size(300, 45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserListPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Войти',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

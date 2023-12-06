import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ormeal/pages/login_or_register.dart';
import 'package:ormeal/pages/main.dart';

class AuthPage extends StatelessWidget {
  const AuthPage ({Key? key}) : super(key: key);

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainPage();
          } else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}

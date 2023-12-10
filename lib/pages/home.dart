import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final ThemeData theme;

  const HomePage({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    signUserOut() {
      FirebaseAuth.instance.signOut();
    }

    return Material(
      child: Card(
        shadowColor: Colors.transparent,
        margin: const EdgeInsets.all(8.0),
        child: SizedBox.expand(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user?.email ?? 'Unknown User',
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: signUserOut,
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePageWithFab extends StatelessWidget {
  final ThemeData theme;

  const HomePageWithFab({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage(
      theme: theme,
    );
  }
}


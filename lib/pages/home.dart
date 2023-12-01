import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Widget buildHomePage(ThemeData theme) {
  final user = FirebaseAuth.instance.currentUser;

  signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  return Scaffold(
    body: Card(
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
    floatingActionButton: FloatingActionButton(
      onPressed: signUserOut,
      tooltip: 'Logout',
      child: Icon(Icons.logout),
    ),
  );
}


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
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 120),
                  Text(
                    user?.email ?? 'Unknown User',
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: signUserOut, child: Text('Logout')),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 60),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Today Tips',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: buildCard(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard() => Container(
          child: Column(
        children: [
          Image.network("https://picsum.photos//200/250"),
          Text(
            "This is a card",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ));
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

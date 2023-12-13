import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  final ThemeData theme;

  const HomePage({Key? key, required this.theme}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> title = <String>[
    'Entry A',
    'Entry B',
    'Entry C',
  ];
  final List<String> imgLinks = <String>[
    'https://picsum.photos/id/1/200/250',
    'https://picsum.photos/id/2/200/250',
    'https://picsum.photos/id/3/200/250',
  ];

  Future<void> todayTips() async {
    await FirebaseFirestore.instance
        .collection('tips')
        .doc('today')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        print('Document data: ${documentSnapshot.get('title')}');
        print('Document data: ${documentSnapshot.get('imgLink')}');
        setState(() {
          title.add(documentSnapshot.get('title'));
          imgLinks.add(documentSnapshot.get('imgLink'));
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  void initState() {
    todayTips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    void signUserOut() {
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
                    style: widget.theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: signUserOut,
                        child: Text('Logout'),
                      ),
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
                ),
              ),
              Container(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: title.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: buildCard(title[index], imgLinks[index]),
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

  Widget buildCard(String title, String imgLink) => Container(
        child: Column(
          children: [
            Image.network(imgLink),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
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


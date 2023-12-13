import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'todaydetail.dart';

class HomePage extends StatefulWidget {
  final ThemeData theme;

  const HomePage({Key? key, required this.theme}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String>> items = [];

  Future<void> todayTips() async {
    await FirebaseFirestore.instance
        .collection('todaytips')
        .get()
        .then((querySnapshot) {
      List<List<String>> firestoreItems = [];

      querySnapshot.docs.forEach((element) {
        var data = element.data();

        List<String> itemData = [
          data['title'] ?? '',
          data['img_link'] ?? '',
          data['description'] ?? '',
        ];
        firestoreItems.add(itemData);
      });

      setState(() {
        items = List.from(firestoreItems);
      });
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
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              title: items[index][0],
                              imgLink: items[index][1],
                              description: items[index][2],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: buildCard(items[index][0], items[index][1]),
                      ),
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

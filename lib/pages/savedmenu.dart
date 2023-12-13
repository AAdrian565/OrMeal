import 'package:flutter/material.dart';

class SavedMenuPage extends StatelessWidget {
  final ThemeData theme;

  final List<String> entries = <String>[
    'Entry A',
    'Entry B',
    'Entry C',
  ];
  final List<String> imgLinks = <String>[
    'https://picsum.photos/id/1/100/80',
    'https://picsum.photos/id/2/100/80',
    'https://picsum.photos/id/3/100/80',
  ];

  SavedMenuPage({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.grey,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text('${entries[index]}'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              width: 150,
                              height: 100,
                              child: Image.network(imgLinks[index], fit: BoxFit.cover),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


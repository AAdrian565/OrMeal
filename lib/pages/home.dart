import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ormeal/pages/calculator.dart';
import 'package:ormeal/pages/mealSearch.dart';
import 'package:ormeal/pages/todaydetail.dart';

class HomePage extends StatefulWidget {
  final ThemeData theme;

  const HomePage({Key? key, required this.theme}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
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
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(),
              HomeTitle("Menu"),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        HomeButton(context, CalculatorWidget(), Icons.calculate,
                            "BMI Calculator")
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              HomeTitle("Today's Tips"),
              TipsBuilder(context),
            ],
          ),
        ),
      ),
    );
  }

  Container TipsBuilder(BuildContext context) {
    return Container(
      height: 300,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.map((item) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      title: item[0],
                      imgLink: item[1],
                      description: item[2],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: buildCard(item[0], item[1]),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget SearchBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              child: TextFormField(
                onFieldSubmitted: (value) => openMealList(),
                controller: _searchController,
                style: TextStyle(color: Colors.green),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: "Search for ingredients",
                  labelStyle: TextStyle(
                    color: Colors.green.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: openMealList,
          ),
        ],
      ),
    );
  }

  void openMealList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(query: _searchController.text),
      ),
    );
  }

  Center SearchButton(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(query: "Chicken"),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              shape: CircleBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search, size: 60),
            ),
          ),
          Container(
              height: 50,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: "Search for ingredients",
                  labelStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              )),
          Text(
            "Search Recipe",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget HomeTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget HomeButton(
    BuildContext context,
    Widget destinationWidget,
    IconData icon,
    String buttonText,
  ) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => destinationWidget,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Row(
        children: [
          Icon(icon),
          Text(
            buttonText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget TipsButton(BuildContext context, int index) {
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
  }

  Widget buildCard(String title, String imgLink) => Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                fit: BoxFit.cover,
                imgLink,
                width: 200,
                height: 250,
              ),
            ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ormeal/module/class/meal.dart';
import 'package:ormeal/module/class/mealService.dart';
import 'package:ormeal/pages/mealDetail.dart';

class MealSavedPage extends StatefulWidget {
  final ThemeData theme;

  MealSavedPage({Key? key, required this.theme}) : super(key: key);

  @override
  State<MealSavedPage> createState() => _MealSavedPageState();
}

class _MealSavedPageState extends State<MealSavedPage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<List<Meal>> getFavoriteMeals() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('favorites')
        .get();

    List<String> favoriteMealIds = [];
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      favoriteMealIds.add(document.id);
    }
    List<Meal> favoriteMeals = [];
    for (String mealId in favoriteMealIds) {
      Meal? meal = await MealService.fetchMealByID(mealId);
      if (meal != null) {
        favoriteMeals.add(meal);
      }
    }
    return favoriteMeals;
  }

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
              child: FutureBuilder<List<Meal>>(
                future: getFavoriteMeals(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error loading meals'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No saved meals'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            mealCard(context, snapshot, index),
                            SizedBox(height: 10.0),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mealCard(
      BuildContext context, AsyncSnapshot<List<Meal>> snapshot, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailPage(
              meal: snapshot.data![index],
            ),
          ),
        );
      },
      child: Container(
        color: Colors.grey,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '${snapshot.data![index].strMeal}',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: 150,
              height: 100,
              child: Image.network(
                snapshot.data![index].strMealThumb,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

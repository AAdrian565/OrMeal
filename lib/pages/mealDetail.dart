import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ormeal/module/class/meal.dart';
import 'package:ormeal/module/favouriteButton.dart';

class MealDetailPage extends StatefulWidget {
  final Meal meal;

  MealDetailPage({required this.meal});

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  Future<void> checkFavoriteStatus() async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('favorites')
        .doc(widget.meal.idMeal)
        .get();

    setState(() {
      isFavorite = document.exists;
    });
  }

  Future<void> toggleFavorite() async {
    final favoriteRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('favorites')
        .doc(widget.meal.idMeal);

    if (isFavorite) {
      await favoriteRef.delete();
    } else {
      await favoriteRef.set({});
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.strMeal),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: favoriteButton(
              isFavorite: isFavorite,
              onTap: () {
                toggleFavorite();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.meal.strMealThumb,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Category: ${widget.meal.strCategory ?? "N/A"}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Area: ${widget.meal.strArea ?? "N/A"}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Ingredients:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildIngredientsList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Instructions:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.meal.strInstructions ?? "No instructions available.",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            if (widget.meal.strYoutube != null &&
                widget.meal.strYoutube!.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  // Launch YouTube video here
                },
                child: Text('Watch Video'),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIngredientsList() {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.meal.ingredients.length; i++) {
      widgets.add(
        Text(
          '${widget.meal.ingredients[i]}: ${widget.meal.measures[i]}',
          style: TextStyle(fontSize: 16.0),
        ),
      );
    }
    return widgets;
  }
}

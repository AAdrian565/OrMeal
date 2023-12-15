import 'package:flutter/material.dart';
import 'package:ormeal/module/class/meal.dart';

class MealDetailPage extends StatelessWidget {
  final Meal meal;

  MealDetailPage({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.strMeal),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal.strMealThumb,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Category: ${meal.strCategory ?? "N/A"}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Area: ${meal.strArea ?? "N/A"}',
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
              meal.strInstructions ?? "No instructions available.",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            if (meal.strYoutube != null && meal.strYoutube!.isNotEmpty)
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
    for (int i = 0; i < meal.ingredients.length; i++) {
      widgets.add(
        Text(
          '${meal.ingredients[i]}: ${meal.measures[i]}',
          style: TextStyle(fontSize: 16.0),
        ),
      );
    }
    return widgets;
  }
}


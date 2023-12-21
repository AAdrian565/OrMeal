import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:ormeal/module/class/meal.dart';

class MealService {
  static final currentUser = FirebaseAuth.instance.currentUser;

  static Future<Meal?> fetchMealByID(String id) async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> mealsData = data['meals'];

      if (mealsData.isNotEmpty) {
        return Meal.fromJson(mealsData[0]);
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load meal');
    }
  }

  static Future<List<Meal>?> fetchMeals(List<String> ingredients) async {
    List<Meal> allMeals = [];

    for (String ingredient in ingredients) {
      final response = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/filter.php?i=$ingredient'));

      if (response.statusCode == 200) {
        final dynamic responseBody = jsonDecode(response.body);

        if (responseBody['meals'] != null) {
          final List<dynamic> mealsData = responseBody['meals'];
          List<Meal> meals =
              mealsData.map((mealJson) => Meal.fromJson(mealJson)).toList();

          // for (Meal meal in meals) {
          //   Meal? fullMeal = await fetchMealByID(meal.idMeal);
          //   if (fullMeal != null) {
          //     allMeals.add(fullMeal);
          //   }
          // }

          allMeals.addAll(meals);
        } else {
          allMeals.addAll([]);
        }
      } else {
        throw Exception('Failed to load meals for ingredient: $ingredient');
      }
    }
    return allMeals.isNotEmpty ? allMeals : null;
  }

  static Future<List<Meal>> getFavoriteMeals() async {
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
      Meal? meal = await fetchMealByID(mealId);
      if (meal != null) {
        favoriteMeals.add(meal);
      }
    }

    return favoriteMeals;
  }

  static Future<List<Meal>?> recommendMeals(
      List<String> ingredients, List<Meal> allMeals) async {
    if (ingredients.isEmpty || allMeals.isEmpty) {
      return null;
    }
    List<Meal> test = allMeals;

    // Step 1: Calculate TF-IDF
    Map<String, double> tfIdfMap = {};

    allMeals.forEach((meal) {
      Set<String> uniqueIngredients = Set.from(meal.ingredients
          .where((ingredient) => ingredient != null)
          .map((ingredient) => ingredient!));

      ingredients.forEach((queryIngredient) {
        double tf = uniqueIngredients.contains(queryIngredient) ? 1.0 : 0.0;
        double idf =
            log(allMeals.length / (1 + (tfIdfMap[queryIngredient] ?? 0)));

        tfIdfMap[queryIngredient] = (tfIdfMap[queryIngredient] ?? 0) + tf * idf;
      });
    });

    // Step 2: Sort meals by their total TF-IDF scores
    allMeals.sort((a, b) {
      double aScore = ingredients.fold(
          0, (score, ingredient) => score + (tfIdfMap[ingredient] ?? 0));
      double bScore = ingredients.fold(
          0, (score, ingredient) => score + (tfIdfMap[ingredient] ?? 0));
      return bScore.compareTo(aScore);
    });

    // Print the results for testing
    for (int i = 0; i < allMeals.length; i++) {
      print(test[i].strMeal == allMeals[i].strMeal);
    }

    // Return the recommended meals
    return allMeals;
  }
}

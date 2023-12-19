import 'dart:convert';

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

  static Future<List<Meal>?> fetchMeals(String query) async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?i=$query'));

    if (response.statusCode == 200) {
      final dynamic responseBody = jsonDecode(response.body);

      if (responseBody['meals'] != null) {
        final List<dynamic> mealsData = responseBody['meals'];
        return mealsData.map((mealJson) => Meal.fromJson(mealJson)).toList();
      } else {
        // Return null when "meals" is null
        return null;
      }
    } else {
      throw Exception('Failed to load meals');
    }
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
}


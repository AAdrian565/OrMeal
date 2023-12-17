import 'package:http/http.dart' as http;
import 'package:ormeal/module/class/meal.dart';
import 'dart:convert';

class MealService {
  static Future<List<Meal>?> fetchMeals(String query) async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?i=$query'));

    print(response.body);
    print(response.statusCode);

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
}

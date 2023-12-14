import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  final String query;
  SearchPage({required this.query});

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  Future<List<Meal>> fetchMeal() async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?i=${widget.query}'));

    if (response.statusCode == 200) {
      final List<dynamic> mealsData = jsonDecode(response.body)['meals'];
      return mealsData.map((mealJson) => Meal.fromJson(mealJson)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Center(child: mealListBuilder()),
    );
  }

  Container mealListBuilder() {
    return Container(
      child: FutureBuilder<List<Meal>>(
        future: fetchMeal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No meals found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Meal meal = snapshot.data![index];
                return ListTile(
                  title: Text(meal.strMeal!),
                  leading: Image.network(
                    meal.strMealThumb!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Meal {
  final String? strMeal;
  final String? strMealThumb;
  final String? idMeal;

  Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      idMeal: json['idMeal'],
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ormeal/pages/mealDetail.dart';
import 'package:ormeal/module/class/meal.dart';

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

  Future<Meal?> fetchMealID(String id) async {
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
            return buildSearchList(snapshot);
          }
        },
      ),
    );
  }

  Widget buildSearchList(AsyncSnapshot<List<Meal>> snapshot) {
    return ListView.builder(
      itemCount: (snapshot.data!.length / 2).ceil(),
      itemBuilder: (context, index) {
        final firstItemIndex = index * 2;

        return Row(
          children: [
            buildListItem(snapshot.data![firstItemIndex]),
            SizedBox(width: 8),
            snapshot.data!.length > firstItemIndex + 1
                ? buildListItem(snapshot.data![firstItemIndex + 1])
                : Expanded(child: Container()),
          ],
        );
      },
    );
  }

  Widget buildListItem(Meal meal) {
    return Expanded(
        child: GestureDetector(
      onTap: () async {
        try {
          Meal? selectedMeal = await fetchMealID(meal.idMeal);
          if (selectedMeal != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MealDetailPage(meal: selectedMeal),
              ),
            );
          } else {
            print('Meal not found');
          }
        } catch (e) {
          print('Error fetching meal details: $e');
        }
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                meal.strMealThumb,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meal.strMeal,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

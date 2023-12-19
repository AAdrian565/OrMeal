import 'package:flutter/material.dart';
import 'package:ormeal/module/class/meal.dart';
import 'package:ormeal/module/class/mealService.dart';
import 'package:ormeal/pages/mealDetail.dart';

class SearchPage extends StatefulWidget {
  final String query;
  SearchPage({required this.query});

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
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
      child: FutureBuilder<List<Meal>?>(
        future: MealService.fetchMeals('${widget.query}'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No meals found.'));
          } else {
            return buildSearchList(snapshot);
          }
        },
      ),
    );
  }

  Widget buildSearchList(AsyncSnapshot<List<Meal>?> snapshot) {
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          },
        );
        try {
          Meal? selectedMeal = await MealService.fetchMealByID(meal.idMeal);
          Navigator.pop(context);

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
          Navigator.pop(context);
          print('Error fetching meal details: $e');
        }
      },
      child: buildCard(meal),
    ));
  }

  Card buildCard(Meal meal) {
    return Card(
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ormeal/module/class/meal.dart';
import 'package:ormeal/pages/mealDetail.dart';
import 'package:ormeal/module/class/mealService.dart';

// ignore: must_be_immutable
class MealSavedPage extends StatefulWidget {
  final ThemeData theme;
  List<Meal> favoriteMeals;

  MealSavedPage({Key? key, required this.theme, required this.favoriteMeals})
      : super(key: key);

  @override
  State<MealSavedPage> createState() => _MealSavedPageState();
}

class _MealSavedPageState extends State<MealSavedPage> {
  bool isFavoriteMealsLoading = false;

  Future<void> _refreshFavoriteMeals() async {
    setState(() {
      isFavoriteMealsLoading = true;
    });

    try {
      List<Meal> meals = await MealService.getFavoriteMeals();
      setState(() {
        widget.favoriteMeals = List.from(meals);
      });
    } catch (error) {
      print('Error loading favorite meals: $error');
    } finally {
      setState(() {
        isFavoriteMealsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
        child: RefreshIndicator(
          onRefresh: _refreshFavoriteMeals,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Expanded(
                child: widget.favoriteMeals.isEmpty
                    ? (isFavoriteMealsLoading
                        ? Center(child: CircularProgressIndicator())
                        : Center(child: Text('No saved meals')))
                    : mealList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView mealList() {
    return ListView.builder(
      itemCount: widget.favoriteMeals.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealDetailPage(
                      meal: widget.favoriteMeals[index],
                    ),
                  ),
                );
              },
              child: Card(
                color: Colors.grey[200],
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 150,
                      height: 100,
                      child: Image.network(
                        widget.favoriteMeals[index].strMealThumb,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '${widget.favoriteMeals[index].strMeal}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
          ],
        );
      },
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

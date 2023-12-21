import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ormeal/pages/about.dart';
import 'package:ormeal/pages/home.dart';
import 'package:ormeal/pages/mealSaved.dart';
import 'package:ormeal/pages/userSettings.dart';
import 'package:ormeal/module/class/meal.dart';
import 'package:ormeal/module/class/mealService.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int currentPageIndex = 0;
  late List<Meal> favoriteMeals;

  @override
  void initState() {
    super.initState();
    favoriteMeals = [];
    initializeFavoriteMeals();
  }

  signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> initializeFavoriteMeals() async {
    try {
      List<Meal> meals = await MealService.getFavoriteMeals();
      setState(() {
        favoriteMeals = meals;
      });
    } catch (error) {
      print('Error loading favorite meals: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildNavigationBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Image.asset('lib/images/OrMeal.png', height: 40, width: 40),
          SizedBox(width: 8),
          Text('OrMeal'),
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.account_circle,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserSettingPage(),
                ),
              );
            }),
      ],
    );
  }

  Widget buildBody() {
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          HomePage(theme: theme),
          MealSavedPage(theme: theme, favoriteMeals: favoriteMeals),
          AboutPage(theme: theme),
        ],
      ),
    );
  }

  Widget buildNavigationBar() {
    return buildNavigationBarWidget(currentPageIndex);
  }

  Widget buildNavigationBarWidget(int currentIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.green,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[300],
      showUnselectedLabels: false,
      onTap: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border_outlined),
          activeIcon: Icon(Icons.bookmark),
          label: 'Saved Meal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.perm_device_info_rounded),
          activeIcon: Icon(Icons.perm_device_info),
          label: 'About Us',
        ),
      ],
    );
  }
}

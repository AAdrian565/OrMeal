import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ormeal/pages/about.dart';
import 'package:ormeal/pages/home.dart';
import 'package:ormeal/pages/mealSaved.dart';
import 'package:ormeal/pages/userSettings.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int currentPageIndex = 0;

  signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(), // Add this line to include the app bar
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
          MealSavedPage(theme: theme),
          AboutPage(theme: theme),
        ],
      ),
    );
  }

  Widget buildNavigationBar() {
    return buildNavigationBarWidget(currentPageIndex);
  }

  Widget buildNavigationBarWidget(int currentIndex) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      backgroundColor: Colors.green,
      // indicatorColor: Colors.blue,
      selectedIndex: currentIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.bookmark),
          icon: Icon(Icons.bookmark_border_outlined),
          label: 'Saved Meal',
        ),
        NavigationDestination(
          icon: Icon(Icons.perm_device_info_rounded),
          label: 'About Us',
        ),
      ],
    );
  }
}

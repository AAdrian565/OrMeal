import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'savedmenu.dart';
import 'about.dart';

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
      body: buildBody(),
      bottomNavigationBar: buildNavigationBar(),
    );
  }

  Widget buildBody() {
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          HomePage(theme: theme),
          SavedMenuPage(theme: theme),
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
          label: 'Saved menu',
        ),
        NavigationDestination(
          icon: Icon(Icons.perm_device_info_rounded),
          label: 'About Us',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'notification.dart';
import 'message.dart';

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
          buildHomePage(theme),
          buildNotificationsPage(theme),
          buildMessagesPage(theme),
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
      indicatorColor: Colors.blue,
      selectedIndex: currentIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Badge(child: Icon(Icons.notifications_sharp)),
          label: 'Notifications',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.messenger_sharp),
          ),
          label: 'Messages',
        ),
        // Logout  button
      ],
    );
  }
}

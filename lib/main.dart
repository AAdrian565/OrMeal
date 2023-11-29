import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/home.dart';
import 'pages/notification.dart';
import 'pages/message.dart';

void main() => runApp(const Ormeal());

class Ormeal extends StatelessWidget {
  const Ormeal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Login(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: buildNavigationBar(),
    );
  }

  Widget buildBody() {
    final ThemeData theme = Theme.of(context);
    return IndexedStack(
      index: currentPageIndex,
      children: <Widget>[
        buildHomePage(theme),
        buildNotificationsPage(theme),
        buildMessagesPage(theme),
      ],
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
      ],
    );
  }
}

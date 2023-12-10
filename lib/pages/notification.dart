import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final ThemeData theme;

  const NotificationsPage({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          NotificationCard(
            title: 'Notification 1',
            subtitle: 'This is a notification',
          ),
          NotificationCard(
            title: 'Notification 2',
            subtitle: 'This is a notification',
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.notifications_sharp),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}


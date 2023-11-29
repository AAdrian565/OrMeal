import 'package:flutter/material.dart';

Widget buildNotificationsPage(ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        buildNotificationCard(
            theme, 'Notification 1', 'This is a notification'),
        buildNotificationCard(
            theme, 'Notification 2', 'This is a notification'),
      ],
    ),
  );
}

Widget buildNotificationCard(ThemeData theme, String title, String subtitle) {
  return Card(
    child: ListTile(
      leading: Icon(Icons.notifications_sharp),
      title: Text(title),
      subtitle: Text(subtitle),
    ),
  );
}

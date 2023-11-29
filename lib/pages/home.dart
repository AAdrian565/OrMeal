import 'package:flutter/material.dart';

Widget buildHomePage(ThemeData theme) {
  return Card(
    shadowColor: Colors.transparent,
    margin: const EdgeInsets.all(8.0),
    child: SizedBox.expand(
      child: Center(
        child: Text(
          'Home page',
          style: theme.textTheme.titleLarge,
        ),
      ),
    ),
  );
}

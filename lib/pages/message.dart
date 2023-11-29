import 'package:flutter/material.dart';

Widget buildMessagesPage(ThemeData theme) {
  return ListView.separated(
    reverse: true,
    itemCount: 2,
    separatorBuilder: (context, index) => Divider(),
    itemBuilder: (BuildContext context, int index) {
      return buildMessageContainer(theme, index);
    },
  );
}

Widget buildMessageContainer(ThemeData theme, int index) {
  return Align(
    alignment: index == 0 ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        index == 0 ? 'Hello' : 'Hi!',
        style: theme.textTheme.bodyLarge!
            .copyWith(color: theme.colorScheme.onPrimary),
      ),
    ),
  );
}

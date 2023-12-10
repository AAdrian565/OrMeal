import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  final ThemeData theme;

  const MessagesPage({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      itemCount: 2,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return MessageContainer(theme: theme, index: index);
      },
    );
  }
}

class MessageContainer extends StatelessWidget {
  final ThemeData theme;
  final int index;

  const MessageContainer({
    Key? key,
    required this.theme,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}


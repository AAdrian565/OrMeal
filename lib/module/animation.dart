import 'package:flutter/material.dart';

PageRouteBuilder Slide(Widget page, Offset offset) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween =
          Tween(begin: offset, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

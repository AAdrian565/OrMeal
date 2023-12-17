import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ormeal/firebase_options.dart';
import 'package:ormeal/pages/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Ormeal());
}

class Ormeal extends StatelessWidget {
  const Ormeal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: AuthPage(),
    );
  }
}

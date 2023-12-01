import 'package:flutter/material.dart';
import 'package:ormeal/module/textinput.dart';
import 'main.dart';
import '../module/animation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void printhello() {
    print('hello');
  }

  void signUserIn() async {
    print("Login button Pressed");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print('signed in');
    } on FirebaseAuthException catch (e) {
      print("ERROR SIGN IN");
      if ((e.code == 'user-not-found') || (e.code == 'wrong-password')) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Error"),
              );
            });
      }
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Oatmeal'),
            const SizedBox(height: 10),
            // username
            TextInput(
              controller: emailController,
              hintText: 'Email',
            ),
            // password
            TextInput(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('Forgot password?'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            ElevatedButton(
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 35),
                shape: StadiumBorder(),
              ),
              onPressed: () {
                // printhello();
                signUserIn();
                // Navigator.of(context)
                //     .push(Slide(const MainPage(), const Offset(0.0, 1.0)));
              },
            ),
            // or continue with
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 0.5,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('Or Continue with'),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(Icons.facebook),
                    iconSize: 35,
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).push(_RouteHomePage());
                    },
                  ),
                ),
                Image.asset(
                  'lib/images/google.png',
                  width: 30,
                  height: 30,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Route _RouteHomePage() {
  return Slide(const MainPage(), const Offset(0.0, 1.0));
}

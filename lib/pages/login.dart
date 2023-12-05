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
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print("ERROR SIGN IN");
      Navigator.of(context).pop();
      if ((e.code == 'user-not-found') || (e.code == 'wrong-password')) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Colors.blue,
                title: Center(
                  child: Text(
                    'Error',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/images/OrMeal.png',
                width: 100,
                height: 100,
              ),
              Text(
                'OrMeal',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 80),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
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
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.green, // Set text color to white
                    fontSize: 25, // Set text size to 16
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 35),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  signUserIn();
                },
              ),
              ElevatedButton(
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.green, // Set text color to white
                    fontSize: 25, // Set text size to 16
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 35),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  signUserIn();
                },
              ),
              // or continue with
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or Continue with',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Logo Clicked!');
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(180.0),
                      ),
                      child: Center(
                        child: Image.asset(
                          'lib/images/google.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Route _RouteHomePage() {
  return Slide(const MainPage(), const Offset(0.0, 1.0));
}

import 'package:flutter/material.dart';
import 'package:ormeal/module/textinput.dart';
import '../main.dart';
import '../module/animation.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
              controller: usernameController,
              hintText: 'Username',
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

            Container(
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 35),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(Slide(const MainPage(), const Offset(0.0, 1.0)));
                },
              ),
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
                      Navigator.of(context).push(_RouteMainPage());
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

Route _RouteMainPage() {
  return Slide(const MainPage(), const Offset(0.0, 1.0));
}

import 'package:flutter/material.dart';
import '../main.dart';
import '../module/animation.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Oatmeal'),
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your username',
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your Password',
                  ),
                ),
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
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text('Or login with'),
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
                Container(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(Icons.g_mobiledata_rounded),
                    iconSize: 35,
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context).push(_RouteMainPage());
                    },
                  ),
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

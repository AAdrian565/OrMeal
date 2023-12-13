import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final ThemeData theme;

  const AboutPage({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'About Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Welcome to OrMeal, your one-stop solution for delicious, nutritious, and convenient meals! We believe that everyone deserves access to healthy food options, regardless of their busy schedules. That’s why we’ve made it our mission to deliver high-quality, balanced meals right to your doorstep \n\n.At OrMeal, we’re passionate about food and health. Our team of experienced chefs and nutritionists work together to create a diverse menu filled with dishes that are as tasty as they are healthy. We use only the freshest ingredients, sourced locally to support our community and ensure the highest quality.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
    );
  }
}


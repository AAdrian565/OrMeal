import 'package:flutter/material.dart';
import 'package:ormeal/pages/mealDetail.dart';

class MealSavedPage extends StatelessWidget {
  final ThemeData theme;

  final List<String> title = <String>[
    'Entry A',
    'Entry B',
    'Entry C',
  ];
  final List<String> imgLinks = <String>[
    'https://picsum.photos/id/1/300/300',
    'https://picsum.photos/id/2/300/300',
    'https://picsum.photos/id/3/300/300',
  ];
  final List<String> recipe = <String>[
    "Ingredients:\n- 2 cups cooked rice (preferably cold and leftover) \n- 3 eggs, beaten \n- 1 cup mixed vegetables (carrots, peas, corn, and diced bell peppers) \n- 3 green onions, chopped \n- 3 tablespoons soy sauce \n- 1 tablespoon oyster sauce \n- 1 teaspoon sesame oil \n- 2 tablespoons vegetable oil \n- Salt and pepper to taste\n Instructions: \n1. Heat a large wok or skillet over medium-high heat. Add 1 tablespoon of vegetable oil. \n \n2. Add the mixed vegetables to the wok and stir-fry for 2-3 minutes until they are slightly tender. Remove the vegetables from the wok and set aside. \n \n3. In the same wok, add another tablespoon of vegetable oil. Pour in the beaten eggs and scramble them until they are just cooked. Remove the scrambled eggs from the wok and set aside. \n \n4. Add the remaining oil to the wok. Add the cold cooked rice, breaking up any clumps. Stir-fry the rice for 2-3 minutes until it's heated through and starts to get a little crispy. \n \n5. Return the cooked vegetables and scrambled eggs to the wok with the rice. Mix everything together. \n \n6. Pour soy sauce, oyster sauce, and sesame oil over the rice mixture. Stir well to combine and evenly coat the rice with the sauces. \n \n7. Add chopped green onions and continue to stir-fry for an additional 2-3 minutes. \n \n8. Taste and adjust the seasoning with salt and pepper as needed. \n \n9. Once everything is well-mixed and heated through, remove the wok from the heat. \n \n10. Serve the egg fried rice hot as a delicious and satisfying meal! \n \nEnjoy your homemade egg fried rice!",
    "Ingredients:\n- 2 cups cooked rice (preferably cold and leftover) \n- 3 eggs, beaten \n- 1 cup mixed vegetables (carrots, peas, corn, and diced bell peppers) \n- 3 green onions, chopped \n- 3 tablespoons soy sauce \n- 1 tablespoon oyster sauce \n- 1 teaspoon sesame oil \n- 2 tablespoons vegetable oil \n- Salt and pepper to taste\n Instructions: \n1. Heat a large wok or skillet over medium-high heat. Add 1 tablespoon of vegetable oil. \n \n2. Add the mixed vegetables to the wok and stir-fry for 2-3 minutes until they are slightly tender. Remove the vegetables from the wok and set aside. \n \n3. In the same wok, add another tablespoon of vegetable oil. Pour in the beaten eggs and scramble them until they are just cooked. Remove the scrambled eggs from the wok and set aside. \n \n4. Add the remaining oil to the wok. Add the cold cooked rice, breaking up any clumps. Stir-fry the rice for 2-3 minutes until it's heated through and starts to get a little crispy. \n \n5. Return the cooked vegetables and scrambled eggs to the wok with the rice. Mix everything together. \n \n6. Pour soy sauce, oyster sauce, and sesame oil over the rice mixture. Stir well to combine and evenly coat the rice with the sauces. \n \n7. Add chopped green onions and continue to stir-fry for an additional 2-3 minutes. \n \n8. Taste and adjust the seasoning with salt and pepper as needed. \n \n9. Once everything is well-mixed and heated through, remove the wok from the heat. \n \n10. Serve the egg fried rice hot as a delicious and satisfying meal! \n \nEnjoy your homemade egg fried rice!",
    "Ingredients:\n- 2 cups cooked rice (preferably cold and leftover) \n- 3 eggs, beaten \n- 1 cup mixed vegetables (carrots, peas, corn, and diced bell peppers) \n- 3 green onions, chopped \n- 3 tablespoons soy sauce \n- 1 tablespoon oyster sauce \n- 1 teaspoon sesame oil \n- 2 tablespoons vegetable oil \n- Salt and pepper to taste\n Instructions: \n1. Heat a large wok or skillet over medium-high heat. Add 1 tablespoon of vegetable oil. \n \n2. Add the mixed vegetables to the wok and stir-fry for 2-3 minutes until they are slightly tender. Remove the vegetables from the wok and set aside. \n \n3. In the same wok, add another tablespoon of vegetable oil. Pour in the beaten eggs and scramble them until they are just cooked. Remove the scrambled eggs from the wok and set aside. \n \n4. Add the remaining oil to the wok. Add the cold cooked rice, breaking up any clumps. Stir-fry the rice for 2-3 minutes until it's heated through and starts to get a little crispy. \n \n5. Return the cooked vegetables and scrambled eggs to the wok with the rice. Mix everything together. \n \n6. Pour soy sauce, oyster sauce, and sesame oil over the rice mixture. Stir well to combine and evenly coat the rice with the sauces. \n \n7. Add chopped green onions and continue to stir-fry for an additional 2-3 minutes. \n \n8. Taste and adjust the seasoning with salt and pepper as needed. \n \n9. Once everything is well-mixed and heated through, remove the wok from the heat. \n \n10. Serve the egg fried rice hot as a delicious and satisfying meal! \n \nEnjoy your homemade egg fried rice!",
  ];

  MealSavedPage({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: title.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.grey,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('${title[index]}'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                width: 150,
                                height: 100,
                                child: Image.network(imgLinks[index],
                                    fit: BoxFit.cover),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

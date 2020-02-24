import 'package:flutter/material.dart';
import 'package:p7_meal_app/models/dummy-data.dart';
import 'package:p7_meal_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/meal-detail";

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context).settings.arguments as String;
    final Meal selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text("${selectedMeal.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContrainer(
                context,
                ListView.builder(
                  itemCount: selectedMeal.ingredients.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                        color: Theme.of(context).accentColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(selectedMeal.ingredients[index]),
                        ));
                  },
                )),
            buildSectionTitle(context, "Steps"),
            buildContrainer(
                context,
                ListView.builder(
                  itemCount: selectedMeal.steps.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: Text("# ${index + 1}"),
                          ),
                          title: Text(selectedMeal.steps[index]),
                        ),
                        Divider()
                      ],
                    );
                  },
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context).pop(mealId);
        },
      ),
    );
  }

  Container buildContrainer(BuildContext context, Widget child) {
    return Container(
      height: 200,
      width: 300,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  Container buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:p7_meal_app/models/dummy-data.dart';
import 'package:p7_meal_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const String routeName = "/category-meals";

  /* final String categoryId;
  final String categoryTitle;

  const CategoryMealsScreen(this.categoryId, this.categoryTitle);
*/
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String categoryId = routeArgs["id"];
    final String categoryTitle = routeArgs["title"];

    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
            itemBuilder: (ctx, index) {
              var categoryMeal = categoryMeals[index];
              return MealItem(
                id: categoryMeal.id,
                title: categoryMeal.title,
                imageUrl: categoryMeal.imageUrl,
                duration: categoryMeal.duration,
                complexity: categoryMeal.complexity,
                affordability: categoryMeal.affordability,
              );
            },
            itemCount: categoryMeals.length));
  }
}

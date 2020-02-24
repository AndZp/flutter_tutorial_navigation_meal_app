import 'package:flutter/material.dart';
import 'package:p7_meal_app/models/dummy-data.dart';
import 'package:p7_meal_app/models/meal.dart';
import 'package:p7_meal_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = "/category-meals";

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  String _categoryId;
  List<Meal> _displayedMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
      ModalRoute
          .of(context)
          .settings
          .arguments as Map<String, String>;

      _categoryId = routeArgs["id"];
      _categoryTitle = routeArgs["title"];

      _displayedMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(_categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_categoryTitle),
        ),
        body: ListView.builder(
            itemBuilder: (ctx, index) {
              var categoryMeal = _displayedMeals[index];
              return MealItem(
                id: categoryMeal.id,
                title: categoryMeal.title,
                imageUrl: categoryMeal.imageUrl,
                duration: categoryMeal.duration,
                complexity: categoryMeal.complexity,
                affordability: categoryMeal.affordability,
                removeItem: _removeMeal,
              );
            },
            itemCount: _displayedMeals.length));
  }

  void _removeMeal(String mealId) {
    setState(() {
      _displayedMeals.removeWhere((meal) {
        return meal.id == mealId;
      });
    });
  }
}

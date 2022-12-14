import 'package:flutter/material.dart';
import './screen/meal_detail_screen.dart';
import './screen/category_meals_screen.dart';
import './screen/categories_screen.dart';
import './screen/tabar_screen.dart';
import './screen/filters_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Map<String, bool> _filters = {
      'gluten': false,
      'lactose': false,
      'vegan': false,
      'vegetarian': false,
    };

    List<Meal> _selectedMeal = DUMMY_MEALS;

    void setFilters(Map<String, bool> getfilters) {
      setState(() {
        _filters = getfilters;

        _selectedMeal = DUMMY_MEALS.where((meal) {
          if (_filters['gluten']! && !meal.isGlutenFree) {
            return false;
          }
          if (_filters['lactose']! && !meal.isLactoseFree) {
            return false;
          }
          if (_filters['vegan']! && !meal.isVegan) {
            return false;
          }
          if (_filters['vegetarian']! && !meal.isVegetarian) {
            return false;
          }
          return true;
        }).toList();
      });
      for (int i = 0; i < _selectedMeal.length; i++) {
        print(_selectedMeal[i].title);
      }
    }

    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: const TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_selectedMeal),
        MealDetail.routeName: (ctx) => MealDetail(),
        FilterScreen.routname: (ctx) => FilterScreen(_filters, setFilters),
      },
      onGenerateRoute: (settings) {},
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}

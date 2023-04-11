import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/CurrentForecast.dart';


class RecipeProvider with ChangeNotifier {
  List<dynamic> _recipes = [];

  List<Recipe> get recipes {
    return [..._recipes];
  }

  Future<Recipe> fetchAndSetRecipes() async {
    const url = 'https://bakeology-alpha-stage.herokuapp.com/user/recipes';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return null;
      }
      final List<Recipe> loadedRecipes = [];
      extractedData["recipes"].forEach((recipeData) {
        loadedRecipes.add(
          Recipe(
              id: recipeData["_id"],
              title: recipeData["title"],
              duration: recipeData["duration"],
              imageUrl: recipeData["imageUrl"],
              affordability: recipeData["affordability"],
              isVegetarian: recipeData["isVegetarian"],
              steps: recipeData["steps"],
              categories: recipeData["categories"],
              chef: recipeData["chef"]["_id"],
              chefName: recipeData["chef"]["name"],
              chefImageUrl: recipeData["chef"]["profileImageUrl"],
              complexity: recipeData["complexity"],
              ingredients: recipeData["ingredients"]),
        );
      });
      _recipes = loadedRecipes;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
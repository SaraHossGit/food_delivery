import 'dart:async';

import 'package:food_delivery/models/meal_model.dart';
import 'package:food_delivery/models/quisines_list_model.dart';
import 'package:food_delivery/network/remote/dio_helper.dart';
import 'package:food_delivery/shared/components/constants.dart';
import 'package:food_delivery/shared/components/constants.dart';
import 'package:food_delivery/shared/components/constants.dart';

class MealsCubit{
  // Init the data model, stream and stream controller
  final mealStreamController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get mealsListStream => mealStreamController.stream;
  MealsListModel? mealsModel;

  void fetchMeal() {
    mealStreamController.add(null); // Emit loading state
    DioHelper.dioGetRandomMeal().then((value) {
      if (value.statusCode == 200) {
        mealsModel = MealsListModel.fromJson(value.data);
        print("random: ${mealsModel?.mealsList[0]}");
        mealStreamController.add(mealsModel!.mealsList[0]); //emit success state
      } else {
        mealStreamController
            .addError('Failed to fetch data'); //emit error state
      }
    }).catchError((onError) {
      print(onError);
      mealStreamController
        .addError('Failed to fetch data');
    }); //emit error state
  }

  void dispose() {
    mealStreamController.close();
  }
}
import 'dart:async';

import 'package:food_delivery/models/meal_model.dart';
import 'package:food_delivery/models/quisines_list_model.dart';
import 'package:food_delivery/network/remote/dio_helper.dart';
import 'package:food_delivery/shared/components/constants.dart';
import 'package:food_delivery/shared/components/constants.dart';
import 'package:food_delivery/shared/components/constants.dart';

class MealsListCubit{
  // Init the data model, stream and stream controller
  final mealsListStreamController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get mealsListStream => mealsListStreamController.stream;
  MealsListModel? mealsListModel;

  void fetchList({
    required String quisineName,
  }) {
    mealsListStreamController.add(null); // Emit loading state
    DioHelper.dioGetMealsList(
      quisineName: quisineName,
    ).then((value) {
      if (value.statusCode == 200) {
        mealsListModel = MealsListModel.fromJson(value.data);
        print(mealsListModel!.mealsList);
        mealsListStreamController.add(mealsListModel!.mealsList); //emit success state
      } else {
        mealsListStreamController
            .addError('Failed to fetch data'); //emit error state
      }
    }).catchError((onError) {
      print(onError);
      mealsListStreamController
        .addError('Failed to fetch data');
    }); //emit error state
  }

  void fetchFilteredList({
    required String filter,
  }) {
    mealsListStreamController.add(null); // Emit loading state
    DioHelper.dioGetFilteredMealsList(
      filter: filter,
    ).then((value) {
      if (value.statusCode == 200) {
        mealsListModel = MealsListModel.fromJson(value.data);
        print(mealsListModel!.mealsList);
        mealsListStreamController.add(mealsListModel!.mealsList); //emit success state
      } else {
        mealsListStreamController
            .addError('Failed to fetch data'); //emit error state
      }
    }).catchError((onError) {
      print(onError);
      mealsListStreamController
          .addError('Failed to fetch data');
    }); //emit error state
  }

  void dispose() {
    mealsListStreamController.close();
  }
}
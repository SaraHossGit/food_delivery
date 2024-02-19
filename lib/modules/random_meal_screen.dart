import 'package:flutter/material.dart';
import 'package:food_delivery/cubits/meal_cubit.dart';
import 'package:food_delivery/shared/components/components.dart';
import 'package:food_delivery/shared/styles/colors.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class RandomMealScreen extends StatefulWidget {
  RandomMealScreen({super.key});

  @override
  State<RandomMealScreen> createState() => _RandomMealScreenState();
}

class _RandomMealScreenState extends State<RandomMealScreen> {
  MealsCubit mealsCubit = MealsCubit();
  Map<String,dynamic>? randomMeal;

  @override
  void initState() {
    mealsCubit.fetchMeal();
    super.initState();
  }

  @override
  void dispose() {
    mealsCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<dynamic>(
            stream: mealsCubit.mealsListStream,
            builder: (context, snapshot) {
              print("snapshot ${snapshot.data}");
              if (snapshot.hasData) {
                randomMeal= snapshot.data;
                return screenBuilder();
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  Widget screenBuilder() =>Stack(
    children: [
      backContainer(color: backgroundColor, context: context),
      frontContainer(color: backgroundColor, context: context, mealName: randomMeal?["strMeal"]),
      defaultBackArrow(context),
      mealImageCircleAvatar(context: context,mealImg: randomMeal?["strMealThumb"]),
    ],
  );}

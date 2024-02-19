import 'package:flutter/material.dart';
import 'package:food_delivery/shared/components/components.dart';
import 'package:food_delivery/shared/styles/colors.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class DetailsScreen extends StatelessWidget {
  Map<String, dynamic>? meal;
  DetailsScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                backContainer(color: backgroundColor, context: context),
                frontContainer(color: backgroundColor, context: context, mealName: meal?["strMeal"]),
                defaultBackArrow(context),
                mealImageCircleAvatar(context: context,mealImg: meal?["strMealThumb"]),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

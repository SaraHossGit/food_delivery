import 'package:flutter/material.dart';
import 'package:food_delivery/shared/styles/colors.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

Widget defaultSeparator() => Container(
  padding: const EdgeInsets.symmetric(vertical: 20),
  width: double.infinity,
  height: 1,
  color: Colors.grey[300],
);

Widget defaultBackArrow(context) => IconButton(
  icon: const Icon(
    Icons.chevron_left,
    size: 42,
    color: Colors.white,
  ),
  onPressed: () => Navigator.of(context).pop(),
);

Widget backContainer({
  required BuildContext context,
  required Color color,
}) =>
    Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );

Widget frontContainer({
  required Color color,
  required BuildContext context,
  required String mealName,
}) =>
    Positioned.fill(
      top: MediaQuery.of(context).size.height / 5,
      left: 30,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        padding: const EdgeInsets.only(
          top: 60,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: mealDetails(mealName: mealName),
      ),
    );

Widget mealImageCircleAvatar({required BuildContext context, required mealImg}) => Positioned(
  left: MediaQuery.of(context).size.width / 2,
  child: Hero(
    tag: "mealImgAnimation ${mealImg}",
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 15,
            spreadRadius: 5,
          )
        ],
      ),
      child: CircleAvatar(
        backgroundImage: NetworkImage(mealImg),
        radius: 160,
      ),
    ),
  ),
);

Widget mealDetails({required String mealName}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    /// Meal Name
    SizedBox(
      width: 150,
      child: Text(
        mealName,
        style: TextStyle(
          color: backgroundColor,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    ),
    const SizedBox(height: 60),

    /// Description
    Text(
      "Description",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.grey[800],
      ),
    ),
    SizedBox(
        width: double.infinity,
        child: Text(
          loremIpsum(words: 40, paragraphs: 1),
          style: TextStyle(color: Colors.grey[600]),
        )),
    defaultSeparator(),

    /// Delivery Details
    deliveryDetails(),
    defaultSeparator(),

    /// Price/ order button
    Center(
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20)),
        child: MaterialButton(
            child: const Text(
              "ORDER FOR \$5.99",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            onPressed: () {}),
      ),
    )
  ],
);

Widget deliveryDetails() => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Column(
      children: [
        Text("Delivery Cost", style: TextStyle(color: Colors.grey[600])),
        Text("Free",
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.grey[600])),
      ],
    ),
    Column(
      children: [
        Text("Quantity", style: TextStyle(color: Colors.grey[600])),
        Text("1",
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.grey[600])),
      ],
    ),
    Column(
      children: [
        Text("Delivery Time", style: TextStyle(color: Colors.grey[600])),
        Text("11:10 am",
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.grey[600])),
      ],
    ),
  ],
);

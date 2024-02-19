import 'package:flutter/material.dart';
import 'package:food_delivery/cubits/meals_list_cubit.dart';
import 'package:food_delivery/modules/details_screen.dart';
import 'package:food_delivery/shared/styles/colors.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class MenuScreen extends StatefulWidget {
  String quisineName;
  MenuScreen({super.key, required this.quisineName});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  MealsListCubit mealsListCubit = MealsListCubit();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    if(widget.quisineName=="vegan" || widget.quisineName=="breakfast"){
      mealsListCubit.fetchFilteredList(filter: widget.quisineName);
    }else{
      mealsListCubit.fetchList(quisineName: widget.quisineName);
    }
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    mealsListCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20),
        height: 480,
        child: mealsListBuilder(),
      ),
    );
  }

  Widget menuItemContainer({
    required int index,
    required Map<String, dynamic> meal,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background
                Image.asset(
                  index % 2 == 0
                      ? "assets/images/bg12.png"
                      : "assets/images/bg22.png",
                  height: 330,
                  width: 250,
                  fit: BoxFit.cover,
                ),

                // Meal Image
                Hero(
                  tag: "mealImgAnimation ${ meal["strMealThumb"]}",
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        meal["strMealThumb"]),
                    radius: 135,
                  ),
                ),
              ],
            ),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DetailsScreen(meal: meal,))),
          ),
          // Meal Name
          Row(
            children: [
              Text(
                meal["strMeal"],
                style: TextStyle(
                  color: backgroundColor,
                  fontSize: 20,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: backgroundColor,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      )))
            ],
          ),
          // Meal Description
          Container(
              width: 250,
              child: Text(
                loremIpsum(words: 30, paragraphs: 1),
                maxLines: 2,
                style: TextStyle(color: Colors.grey[600]),
              )),
          SizedBox(
            height: 10,
          ),
          // Meal Price
          Text(
            "\$5.99",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700]),
          ),
        ],
      );

  Widget mealsListBuilder() => StreamBuilder<dynamic>(
      stream: mealsListCubit.mealsListStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final mealsList = snapshot.data;
          return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  menuItemContainer(index: index, meal: mealsList[index]),
              separatorBuilder: (context, index) => SizedBox(width: 20),
              itemCount: mealsList.length);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      });
}

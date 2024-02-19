import 'package:flutter/material.dart';
import 'package:food_delivery/cubits/meal_cubit.dart';
import 'package:food_delivery/cubits/meal_cubit.dart';
import 'package:food_delivery/cubits/quisines_list_cubit.dart';
import 'package:food_delivery/models/meal_model.dart';
import 'package:food_delivery/modules/details_screen.dart';
import 'package:food_delivery/modules/random_meal_screen.dart';
import 'package:food_delivery/shared/styles/colors.dart';
import 'package:food_delivery/modules/menu_screen.dart';
import 'package:food_delivery/modules/all_items_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with TickerProviderStateMixin {
  TabController? _tabController;
  List<Widget> sideMenuList = [
    Tab(text: "Breakfast"),
    Tab(text: "Vegan"),
    Tab(text: "Today's Plate"),
    Tab(text: "All Items"),
  ];
  List<Widget> tabsScreensList = [
    MenuScreen(quisineName: "breakfast"),
    MenuScreen(quisineName: "vegan"),
    RandomMealScreen(),
    AllItemsScreen(),
  ];

  @override
  void initState() {
    _tabController = TabController(
        initialIndex: sideMenuList.length - 1, // last index
        length: sideMenuList.length,
        vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          _whiteContainer(),
          _sideMenu(),
        ],
      ),
    );
  }

  Widget _sideMenu() => Row(
        children: [
          sideMenuDecoration(),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: tabsScreensList,
            ),
          )
        ],
      );

  Widget sideMenuDecoration() => RotatedBox(
    quarterTurns: 3,
    child: Container(
      child: Align(
        alignment: Alignment.center,
        child: TabBar(
            labelPadding: const EdgeInsets.only(left: 20, right: 20),
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: TabAlignment.center,
            indicatorPadding: EdgeInsets.only(top: 40),
            indicatorWeight: 40,
            indicator: BoxDecoration(
              shape: BoxShape.rectangle,
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            tabs: sideMenuList),
      ),
    ),
  );

  Widget _whiteContainer() => Positioned.fill(
        left: 60,
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                )),
          ),
        ),
      );

}

import 'package:flutter/material.dart';
import 'package:food_delivery/cubits/quisines_list_cubit.dart';
import 'package:food_delivery/shared/styles/colors.dart';
import 'package:food_delivery/shared/components/constants.dart';
import 'package:food_delivery/modules/menu_screen.dart';

class AllItemsScreen extends StatefulWidget {
  const AllItemsScreen({super.key});

  @override
  State<AllItemsScreen> createState() => _AllItemsScreenState();
}

class _AllItemsScreenState extends State<AllItemsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<String> quisinesList = [];
  QuisinesListCubit quisinesListCubit = QuisinesListCubit();

  @override
  void initState() {
    quisinesListCubit.fetchList();
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    quisinesListCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40),
        child: _pageContent(),
      ),
    );
  }

  Widget _pageContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Select \nYour Choices",
            style: TextStyle(
                color: backgroundColor,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _searchBar(),
          const SizedBox(height: 20),
          _mealsSection(),
        ],
      );

  Widget _searchBar() => Stack(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 10),
            width: 230,
            height: 35,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 15),
            width: 190,
            height: 35,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child:
            TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      );

  Widget _categoriesTabBar() => TabBar(
      tabAlignment: TabAlignment.center,
      isScrollable: true,
      controller: _tabController,
      tabs: _buildTabItems());

  Widget _categoriesTabView() => Expanded(
    child: TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: _buildTabPages(),
    ),
  );

  List<Widget> _buildTabItems() {
    List<Widget> quisines = [];
    for (int i = 0; i < quisinesList.length; i++) {
      quisines.add(
        Tab(
          text: quisinesList[i],
        ),
      );
    }
    return quisines;
  }

  List<Widget> _buildTabPages() {
    List<Widget> quisinesScreens = [];
    for (int i = 0; i < quisinesList.length; i++) {
      quisinesScreens.add(MenuScreen(quisineName: quisinesList[i],));
    }
    return quisinesScreens;
  }

  Widget _mealsSection() => StreamBuilder<dynamic>(
        stream: quisinesListCubit.quisinesListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            quisinesList = snapshot.data;
            _tabController =
                TabController(length: quisinesList.length, vsync: this);
            return Expanded(
              child: Column(
                children: [
                  _categoriesTabBar(),
                  _categoriesTabView(),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
}

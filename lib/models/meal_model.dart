class MealsListModel{
  List<dynamic> mealsList=[];
  MealsListModel.fromJson(Map<String, dynamic> responseData){
    this.mealsList=responseData["meals"];
  }
}
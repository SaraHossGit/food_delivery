class QuisinesListModel{
  List<String> quisinesList=[];
  QuisinesListModel.fromJson(Map<String, dynamic> responseData){
    this.quisinesList=extractList(responseData["meals"]);
  }
}

List<String> extractList(mealsList) {
  List<String> quisinesList=[];
  for (int i=0; i<mealsList.length; i++){
    quisinesList.add(mealsList[i]["strArea"]);
  }
  return quisinesList;
}
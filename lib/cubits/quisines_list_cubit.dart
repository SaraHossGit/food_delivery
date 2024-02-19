import 'dart:async';

import 'package:food_delivery/models/quisines_list_model.dart';
import 'package:food_delivery/network/remote/dio_helper.dart';
import 'package:food_delivery/shared/components/constants.dart';
import 'package:food_delivery/shared/components/constants.dart';
import 'package:food_delivery/shared/components/constants.dart';

class QuisinesListCubit{
  // Init the data model, stream and stream controller
  final quisinesListStreamController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get quisinesListStream => quisinesListStreamController.stream;
  QuisinesListModel? quisinesListModel;

  void fetchList() {
    quisinesListStreamController.add(null); // Emit loading state
    DioHelper.dioGetQuisinesList().then((value) {
      if (value.statusCode == 200) {
        quisinesListModel = QuisinesListModel.fromJson(value.data);
        print(quisinesListModel!.quisinesList);
        quisinesListStreamController.add(quisinesListModel!.quisinesList); //emit success state
      } else {
        quisinesListStreamController
            .addError('Failed to fetch data'); //emit error state
      }
    }).catchError((onError) {
      print(onError);
      quisinesListStreamController
        .addError('Failed to fetch data');
    }); //emit error state
  }
  void dispose() {
    print("QuisinesList Stream disposed");
    quisinesListStreamController.close();
  }
}
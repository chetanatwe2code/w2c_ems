import 'package:get/get.dart';

import '../../../model/ApplicationModel.dart';
import '../../../repository/application_repository.dart';

class ApplicationsLogic extends GetxController implements GetxService {
  final ApplicationRepository repository;
  ApplicationsLogic({required this.repository});


  List<ApplicationModel> list = [];
  bool getLeavesProcess = false;

  updateListStatus(String? string,int index){
    if(list.isNotEmpty && string != null){
      list[index].status = string;
      update();
    }
  }

  getAdminLeaves(){
    getLeavesProcess = true;
    list.clear();
    update();
    repository.getAdminLeaves().then((value) => {
      if(value.body['success']){
        value.body['leaves']['data'].forEach((v) {
          list.add(ApplicationModel.fromJson(v));
        }),
      },
    }).whenComplete(() => {
      getLeavesProcess = false,
      update(),
    });
  }

  // leavesUpdate(String status){
  //  repository.leavesUpdate({ "status" : status });
  // }

}

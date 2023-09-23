import 'package:attendance/model/ApplicationModel.dart';
import 'package:get/get.dart';

import '../../../repository/leaves_repository.dart';


class LeavesLogic extends GetxController implements GetxService {
  final LeavesRepository repository;
  LeavesLogic({required this.repository});

  bool getLeavesProcess = false;

  List<ApplicationModel> list = [];

  int? approvedCount;
  int? pendingCount;
  int? rejectedCount;


  getLeaves(){
    getLeavesProcess = true;
    list.clear();
    update();
    repository.leaveGet().then((value) => {
      if(value.body['success'] == true){
        value.body['leaves']['data'].forEach((v){
          list.add(ApplicationModel.fromJson(v));
        }),
        approvedCount = int.tryParse(value.body['count']['approved_count'].toString())??0,
        pendingCount = int.tryParse(value.body['count']['pending_count'].toString())??0,
        rejectedCount = int.tryParse(value.body['count']['rejected_count'].toString())??0,
      }
    }).whenComplete(() => {
      getLeavesProcess = false,
      update()
    });

  }

}

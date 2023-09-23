import 'package:get/get.dart';

import '../../../model/ProjectModel.dart';
import '../../../repository/project_repository.dart';

class EmployeeTaskLogic extends GetxController {
  final ProjectRepository repository;
  EmployeeTaskLogic({required this.repository});

  List<ProjectModel> model = [];
  int? expandedIndex;

  bool toGet = false;
  getProject(){
    toGet = true;
    model.clear();
    update();
    repository.getProject(body: {}).then((value) => {
      if(value.body['success']){
        value.body['projects'].forEach((v) {
          model.add(ProjectModel.fromJson(v));
        }),
      },
    }).whenComplete(() => {
      toGet = false,
      update(),
    });

  }

}

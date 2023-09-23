import 'package:get/get.dart';

class BaseLogic extends GetxController implements GetxService{


  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

}
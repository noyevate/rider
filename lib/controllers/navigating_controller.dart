import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
   var isFabSelected = false.obs; // Reactive state for FAB selection
   

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}

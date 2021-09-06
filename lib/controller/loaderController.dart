import 'package:get/get.dart';

class Load{
  bool active = false;
}

class LoadController extends GetxController{

  var load = Load().obs;

  updateLoad(){
    load.update((val) {
      val!.active = val.active?false:true;
    });
  }
}
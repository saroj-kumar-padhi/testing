
import 'package:get/get.dart';

class CommonController extends GetxController{
  var common = Common().obs;

  updatePandit(String panditId){
    common.update((val) {
      val!.panditId = panditId;
    });
  }
  profileMove(String serviceId,String panditName){
    common.update((val) {
      val!.serviceId =serviceId;
      val.panditName = serviceId;
    });
  }
}
class Common{
  String? panditId;
  String? panditName;
  String? serviceId;
  Common({this.panditId});
}
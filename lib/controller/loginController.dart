import 'package:get/get.dart';

class LoginController extends GetxController{
var loginData = LoginData(loginType: "login",otpcomplete: false,closeEndDrawer: false).obs;
 void signup(){
    loginData.update((data) { 
      data!.loginType= "signup";
    });
  }
 void signin(){
    loginData.update((data) { 
      data!.loginType="login";
    });
  }
  void dataupdate(){
    loginData.update((data) {
      data!.loginType="Update";
     });
  }
  void otp(){
     loginData.update((data) {
      data!.loginType="otp";
     });
  }
  void sotp(){
     loginData.update((data) {
      data!.loginType="sotp";
     });
  }
  void otpcomplete(){
     loginData.update((data) {
      data!.otpcomplete=true;
     });
  }
  void closeEndDrawer(){
     loginData.update((data) {
      data!.closeEndDrawer=true;
     });
  }
  
}

class LoginData {
  String? loginType;
  bool? otpcomplete;
  bool? closeEndDrawer;
  bool? dataupdated;
  LoginData({this.loginType,required this.otpcomplete,required this.closeEndDrawer,this.dataupdated});
}
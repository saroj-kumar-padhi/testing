import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pujapurohit/Pages/PanditSection/Contest.dart';
import 'package:pujapurohit/Pages/PanditSection/Detail.dart';
import 'package:pujapurohit/Pages/PanditSection/NewLandingPage.dart';
import 'package:pujapurohit/Pages/PanditSection/Topbar/calender.dart';
import 'package:pujapurohit/Pages/PanditSection/Topbar/livedarshan.dart';
import 'package:pujapurohit/Pages/PanditSection/Topbar/muhurat.dart';
import 'package:pujapurohit/Pages/PanditSection/Topbar/pujanvidhi.dart';
import 'package:pujapurohit/Pages/PanditSection/Topbar/varat.dart';
import 'package:pujapurohit/Pages/Services/database.dart';
import 'package:pujapurohit/Pages/locationChange.dart';
import 'package:pujapurohit/SignIn/StarterController.dart';
import 'package:pujapurohit/SignIn/Update.dart';
import 'package:pujapurohit/Starter/Landing.dart';
import 'package:pujapurohit/Starter/SplashScreen.dart';
import 'package:pujapurohit/Widgets/YoutubePlayer.dart';
import 'package:pujapurohit/construction.dart';
import 'Pages/NewPanditHome.dart';
import 'Pages/PanditSection/Account.dart';
import 'Pages/PanditSection/PanditHome.dart';
import 'Pages/PanditSection/Profile.dart';
import 'Pages/PanditSection/ServiceDetail.dart';
import 'Pages/PanditSection/Topbar/offers.dart';
import 'Pages/PanditSection/Widgets/ImageView.dart';
import 'Pages/PanditSection/Topbar/live.dart';
import 'Pages/PanditSection/Widgets/themes.dart';
import 'Pages/booking.dart';
import 'Pages/searchPlaces.dart';
import 'SignIn/AuthController.dart';
import 'Widgets/Loader.dart';
import 'bindings/LocationBinding.dart';
import 'colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'controller/LocationController.dart';
import 'controller/UserController.dart';
import 'controller/loginController.dart';
void main()async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.kLightYellow, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(MyApp());
    });
  // runApp(DevicePreview(
  //   enabled: true,
  //   builder: (context) => MyApp(),
  // ),);
}


class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //builder: DevicePreview.appBuilder,
      theme: Themes.light,
      darkTheme: Themes.dark,
      
      initialBinding: LocationBinding(),
    //home: NewLandingPage(),
     initialRoute: '/',
      title: "Puja Purohit",
      getPages: [
        GetPage(name: '/', page:()=>SplashScreen()),
        GetPage(name: '/landing', page:()=>Landing()),
        GetPage(name: '/home', page:()=>IsLocated()),
        GetPage(name: '/profile', page:()=> Profile()),
        GetPage(name: '/serviceDetail', page:()=>ServiceDetail()),
        GetPage(name: '/address', page: ()=>AddressPage()),
        GetPage(name: '/samagri', page: ()=>Samagri()),
        GetPage(name: '/account', page:()=>Account()),
        GetPage(name: '/booking', page:()=>BookingFinish()),
        GetPage(name: '/locationchange', page: ()=>LocationChange()),
        GetPage(name: '/bookings', page:()=>Booking()),
        GetPage(name: '/live', page: ()=>Live()),
        GetPage(name: '/offer', page: ()=>Offer()),
        GetPage(name: '/muhurat', page: ()=>Muhurat()),
        GetPage(name: '/pujanvidhi', page: ()=>PujanVidhi()),
        GetPage(name: '/calender', page: ()=>Calender())    ,
        GetPage(name: '/livedarshan', page: ()=>LiveDarshan()),
        GetPage(name: '/varat', page: ()=>Varat()),
        GetPage(name: '/detail', page: ()=>Detail()),
        GetPage(name: '/searchplaces', page: ()=>SearchPlaces()),
        GetPage(name: '/contest', page: ()=>Contest()),
        GetPage(name: '/DetailView', page: ()=>DetailView())
      ],
    );
  }
}

class IsLocated extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    LocationController locationController = Get.put(LocationController());
    LoginController loginController = Get.put(LoginController());
    AuthController authController =Get.put(AuthController());
    return Obx((){
    
      if(authController.user!=null){
       if(authController.user!.photoURL==null || authController.user!.displayName==null){
          return Update();
       }
        

        //final UserController userController = Get.put(UserController());

        if(authController.user!.photoURL!=null && authController.user!.displayName!=null){
         // locationController.updateLat(double.parse('${userController.userModel.value.lat}'), double.parse('${userController.userModel.value.lng}'));
          //locationController.updateAddress(locationController.location.value.lat.toString(),locationController.location.value.lng.toString());
          return NewPanditHome();
        }
         else{
         return Container(
             color: Colors.white,
             child: Center(child: Loader(),));
        }
      
    }
    if(locationController.location.value.lat!= null){
     // locationController.updateAddress(locationController.location.value.lat.toString(),locationController.location.value.lng.toString());
      //locationController.updateLat(double.parse('source'), lng)
      return Obx((){
     return locationController.location.value.lat!=null?Provider<Database>(create: (_)=>FirestoreDatabase(),child: PanditHome(),):Landing();
   });
    }
    return Landing();
   });
   
  
   
  }

}



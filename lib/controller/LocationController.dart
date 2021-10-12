
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pujapurohit/Functions/ReverseGeocode.dart';
class LocationController extends GetxController{
  var location = LocationData(serviceEnabled: false,ppermision: false,address2: 'Open Map').obs;
  
  
  @override
  void onInit()async{
    
      await autolocate();
   
    print("Auto locate called");
    super.onInit();
  }
  updateAddress(String lat,String lng)async{
    //String address = await AsistentMethod.searchCoordinateAddress(lat,lng);
    location.update((val) {

      //val!.address = address;
    });
  }
  updateLat(double lat,double lng){
    location.update((val) {
      val!.lat = lat;
      val.lng = lng;
    });
  }
  updatebLat(double blat,double blng){
    location.update((val) {
      val!.blat = blat;
      val.blng = blng;
    });
  }
  Future<void> autolocate()async{
    if(location.value.lat!=null){
      print("hello");
    }
    else{
      location.value.permission = await Geolocator.checkPermission();
    if(location.value.permission == LocationPermission.always || location.value.permission == LocationPermission.whileInUse){
      await determinePosition();
    
        print("determine postio called");
         }
         else{
           print("print location not provided");
         }
          
    }
        
  }

   Future<void>determinePosition() async {
  

  // Test if location services are enabled.
  location.value.serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!location.value.serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    location.update((location) {
      location!.serviceEnabled = false;
     });
  }

  location.value.permission = await Geolocator.checkPermission();
  if (location.value.permission == LocationPermission.denied) {
    location.value.permission = await Geolocator.requestPermission();
    if (location.value.permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      
   location.update((location) {
     location!.permission = LocationPermission.denied;
     });
    }
  }
   if (location.value.permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    Get.snackbar("Location Error", "Allow location permision",backgroundColor: Colors.white);
   location.update((location) {
      location!.permission = LocationPermission.deniedForever;
    });
  } 
  if (location.value.permission == LocationPermission.always) {
    // Permissions are denied forever, handle appropriately. 
    
   location.update((location) {
      location!.permission = LocationPermission.always;
    });
   
  } 
  
   location.update((location) async{
     var postion = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
     location!.lat =postion.latitude.obs;
     location.lng = postion.longitude.obs;
    
  });
}

Future<void>signuplocation()async{
  var postion = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
   location.update((location) async{
       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // String address = await AsistentMethod.searchCoordinateAddress(position.latitude.toString(),position.longitude.toString());
      location!.slat= position.latitude.toString();
      location.slng = position.longitude.toString();
       //location.address = address;
    
     
  });
}

}


class LocationData{
  Future<Position>? userpostion;
  bool serviceEnabled;
  LocationPermission? permission;
  bool ppermision;
  var lat;
  var lng;
  var slat;
  var slng;
  var blat;
  var blng;
  List<Marker>? myMarker =[];
  String? address2 = "Open Map";
  String? address;
  LocationData({this.myMarker,this.address,this.address2,this.blat,this.blng,this.slat,this.slng,this.userpostion,required this.serviceEnabled,this.permission,required this.ppermision});
}
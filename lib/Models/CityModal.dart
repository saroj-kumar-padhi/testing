
import 'package:cloud_firestore/cloud_firestore.dart';

class   CityModel {
  static const ABOUT = "about";
  static const LAT = "lat";
  static const LNG = "lng";
  static const PUJAS = "pujas";
  static const Name = "name";
  


 String? about_agra;
 double? lat;
 double? lng;
 List<dynamic>? pujas;
 String? name;

  CityModel({this.lat,this.lng,this.about_agra,this.name,this.pujas});

  CityModel.fromSnapshot(DocumentSnapshot snapshot) {  
    about_agra = snapshot.get(ABOUT);
    lat = snapshot.get(LAT);
    lng = snapshot.get(LNG);    
    name = snapshot.get(Name);
    pujas = snapshot.get(PUJAS);

  }
}
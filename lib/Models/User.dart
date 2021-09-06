
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const LAT = "lat";
  static const LNG = "lng";
  static const ADDRESS = "address";
  static const PHONE = "phone";
  static const PHOTO = "photoUrl";
  static const TOKEN ="token";

  String? id;
  String? name;
  String? email;
  String? lat;
  String? lng;
  String? address;
  String? phone;
  String? photo;
  String? token;

  UserModel({this.id, this.name, this.email,this.phone,this.photo,this.token});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.get(NAME);
    email = snapshot.get(EMAIL);
    id = snapshot.get(ID);
    lat = snapshot.get(LAT);
    lng = snapshot.get(LNG);
    address = snapshot.get(ADDRESS);
    phone=snapshot.get(PHONE);
    photo = snapshot.get(PHOTO);
    token = snapshot.get(TOKEN);
  }
}
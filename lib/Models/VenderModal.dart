import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModal {

  String?name;
  bool status=true;
  String?token;
  String?image;
  String?state;
  String?district;
  String?uid;
  Map<String, dynamic>? location;
  var discount,userDiscount;
  VendorModal({this.location,this.name,this.token,this.image,this.state,required this.status,this.discount,this.district,this.userDiscount,this.uid});
  VendorModal.fromSnapshot(DocumentSnapshot snapshot){
     location = snapshot.get('location');
    name = snapshot.get('name');
    status = snapshot.get('status');
    discount = snapshot.get('discount');
    userDiscount = snapshot.get('userDiscount');
    district = snapshot.get('district');
    state = snapshot.get('state');
    image = snapshot.get('image');
    uid=snapshot.get('uid');
    token = snapshot.get('token');
  }



}
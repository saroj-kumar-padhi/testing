import 'package:cloud_firestore/cloud_firestore.dart';

class ImagesModel {

  String? link1;
  String? link2;
  String? link3;
  String? link4;


  ImagesModel({this.link1,this.link2,this.link3,this.link4});

  ImagesModel.fromSnapshot(DocumentSnapshot snapshot) {
    link1 = snapshot.get('link1');
    link2 = snapshot.get('link2');
    link3 = snapshot.get('link3');
    link4 = snapshot.get('link4');
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class HinduDateModel {
  static const Moon = "moon";
  static const Background = "background";
  static const Detail = "detail";
  static const Date = "dateYear";


  String? moon;
  String? background;
  String? detail;
  String? date;


  HinduDateModel({this.moon, this.background, this.detail,this.date});

  HinduDateModel.fromSnapshot(DocumentSnapshot snapshot) {
    moon  = snapshot.get(Moon);
    background = snapshot.get(Background);
    detail = snapshot.get(Detail);
    date = snapshot.get(Date);

  }
}
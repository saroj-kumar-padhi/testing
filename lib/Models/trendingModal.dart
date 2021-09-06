
import 'package:cloud_firestore/cloud_firestore.dart';

class TrendingModal{

  String? name;
  String? keyword;
  String? detail;
  String? image;
  int? least;

  TrendingModal({this.name,this.image,this.detail,this.keyword,this.least});

  TrendingModal.fromSnapshot(DocumentSnapshot snapshot){
    name = snapshot.get('name');
    keyword = snapshot.get('keyword');
    detail = snapshot.get('detail');
    image = snapshot.get('image');
    least = snapshot.get('least');
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class CalenderModel {
  static const Image = "image";
  static const Color1 = "color1";
  static const Color2 = "color2";
  static const Date = "date";
  static const Year = "year";
  static const Month = "month";
  static const Keyword = "keyword";
  static const Name = "name";
  static const Vikram = "vikram";


 String? image;
 String? color1;
 String? color2;
 int? date;
 String? year;
 String? month;
 String? keyword;
 String? name;
 String? vikram;

  CalenderModel({this.image,this.color1,this.color2,this.date,this.year,this.month,this.keyword,this.name,this.vikram});

  CalenderModel.fromSnapshot(DocumentSnapshot snapshot) {  
    date = snapshot.get(Date);
    image = snapshot.get(Image);
    color1 = snapshot.get(Color1);
    color2 = snapshot.get(Color2);
    month = snapshot.get(Month);
    year = snapshot.get(Year);
    keyword  = snapshot.get(Keyword);
    name = snapshot.get(Name);
    vikram = snapshot.get(Vikram);

  }
}
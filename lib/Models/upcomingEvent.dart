
import 'package:cloud_firestore/cloud_firestore.dart';

class UpcomingEventModel{

  String? begin;
  String? end;
  String? color;
  String? date;
  String? duration;
  String? image;
  String? keyword;
  String? muhrat;
  String? name;
  String? nick;
  String? link;

  UpcomingEventModel({this.link,this.begin,this.end,this.color,this.date,this.duration,this.image,this.keyword,this.muhrat,this.name,this.nick});

  UpcomingEventModel.fromSnapshot(DocumentSnapshot snapshot) {
   begin = snapshot.get('begin');
   end = snapshot.get('end');
   color = snapshot.get('color');
   date = snapshot.get('date');
   duration = snapshot.get('duration');
   image  = snapshot.get('image');
   keyword = snapshot.get('keyword');
   muhrat = snapshot.get('muhrat');
   name = snapshot.get('name');
   nick = snapshot.get('nick');
   link = snapshot.get('link');

  }
}
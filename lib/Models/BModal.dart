import 'package:cloud_firestore/cloud_firestore.dart';

class BMModal {
  
  String?name;
  String?city;
  String?state;
  String?image;
  String?experience="";
  String?language = "";
  String?type;
  String?uid;
  String?token;
  String?number;
  Map<String, dynamic>? location;
  var swastik;
  int?raters,reviewers;
  bool verified = false;
  BMModal({this.location,this.number,required this.verified,this.type,this.language,this.name,this.city,this.state,this.uid,this.token,this.image,required this.swastik, this.experience,this.raters,this.reviewers});
  BMModal.fromSnapshot(DocumentSnapshot snapshot){
    location = snapshot.get('location');
    verified = snapshot.get('verified');
     name = snapshot.get('firstName');
     city = snapshot.get('lastName');
     state = snapshot.get('state');
     image = snapshot.get('profilePicUrl');
    swastik = snapshot.get('swastik');
    experience = snapshot.get('experience')??"";
    language = snapshot.get('language')??"";
    type = snapshot.get('type');
    raters= snapshot.get('rates');
    reviewers = snapshot.get('reviews');
    uid=snapshot.get('uid');
    token = snapshot.get('token');
    number = snapshot.get('number');
  }



}

class BModal {
  final String? name,type,region,searchKey,uid,photoUrl,quote,coverpic,token,number,state,city,experience,language;
  final int? rates,reviews;
  final double? swastik;
  final bool? verified;
  final Map<String, dynamic>? location;
  BModal({this.language,this.rates,this.reviews,this.state,this.city,this.number,this.location,this.verified,this.token,this.type, this.region, this.name, this.experience,this.searchKey,this.uid,this.photoUrl,this.quote,this.coverpic,this.swastik});
  factory BModal.fromMap(Map<String , dynamic>data){
   
    final Map<String, dynamic>? location=data['location'];
    final bool verified=data['verified'];
    final String token=data['token'];
    final String name = data['firstName'];
    final String type = data['type'];
    final String experience = data['experience'];
    final String region=data['state'];
    final String searchKey=data['searchKey'];
    final String uid=data['uid'];
    final String photoUrl=data['profilePicUrl'];
    final String quote=data['aboutYou'];
    final double swastik=data['swastik'];
    final String coverpic=data['coverpic'];
    final String state = data['state'];
    final String city = data['lastName'];
    final String number = data['number'];
    final int raters = data['rates'];
    final int reviews = data['reviews'];
    final language = data['language'];
   
    return BModal(
      state:  state,
      language: language,
      rates: raters,
      reviews:  reviews,
      city: city,
      number: number,
      location: location,
      verified: verified,
      token: token,
      name: name,
      type: type,
      experience: experience,
      region: region,
      searchKey: searchKey,
      uid:uid,
        photoUrl: photoUrl,
      quote: quote,
      coverpic: coverpic,
      swastik:swastik,
    );
  }
  Map<String,dynamic> toMap (){
    return
      {
        'location':location,
        'verified':verified,
        'token':token,
        'uid':uid,
        'name':name,
        'type':type,
        'experience':experience,
        'region':region,
        'photoUrl':photoUrl,
        'Quote':quote,
        'coverpic':coverpic,
        'searchKey':name![0].toUpperCase(),
        'swastik':swastik,
      };
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModal {
  String? benefit,detail,samagri,image,keyword,offer,service,serviceId,time,type;
  var price,subscriber,np;
  var swastik;
  int?raters,reviewers;
  ServiceModal({this.type,this.image,this.swastik,this.benefit,this.detail,this.samagri,this.service,this.keyword,
    this.offer,this.serviceId,this.subscriber,this.time,this.price,this.raters,this.reviewers,
  });
  ServiceModal.fromSnapshot(DocumentSnapshot snapshot){
    //services = snapshot.get('services');
    image = snapshot.get('image');
    swastik = snapshot.get('swastik');
    type = snapshot.get('type');
    price = snapshot.get('price');
    benefit = snapshot.get('Benefit');
    detail = snapshot.get('PanditD');
    samagri = snapshot.get('Pujan Samagri');
    keyword = snapshot.get('keyword');
    offer = snapshot.get('offer');
    service = snapshot.get('puja');
    serviceId = snapshot.get('serviceId');
    subscriber = snapshot.get('subscriber');
    time = snapshot.get('time');
    raters= snapshot.get('rates');
    reviewers = snapshot.get('reviews');
    np=snapshot.get('np');
  }}

import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModal {
  Timestamp? timestamp;
  Timestamp? dt;
  var Due;
  var benefit;
  var bookingId;
  var companybenefit;
  var convineancefee;
  var panditbenefit;
  var puja_charge;
  var refundmoney;
  var samagri_price;
  var swastik;
  var transaction;
  var vendor_price;
  var service_charge;
  var discount;
  var pdistance;
  var vdistance;
  bool? cancel;
  bool? cod;
  bool? deliver;
  bool? online;
  bool? payment;
  bool? puja_status;
  bool? rating;
  bool? refunded;
  bool? refund;
  bool? rejected;
  bool? request;
  bool? samagri;

  String? status;
  String? utoken;
  String? time;
  String? service;
  String? serviceId;
  String? service_image;
  String? pic;
  String? pandituid;
  String? panditpic;
  String? otp;
  String? pandit;
  String? contact;
  String? date;
  String?lat;
  String? lng;
  String? client;
  String? clientuid;
  String? btoken;
  String? Location;
  String? alternate_contact;
  String? email;
  String? vendor_uid;
  String? vendor_token;
  BookingModal({this.vdistance,this.pdistance,this.discount,this.dt,this.service_charge,this.vendor_uid,this.vendor_token,this.email,this.status,this.timestamp,this.Due,this.benefit,this.puja_charge,this.refundmoney,this.samagri_price,this.transaction,this.swastik,this.vendor_price,this.cancel,this.cod,this.online,
  this.deliver,this.payment,this.puja_status,this.rating,this.refund,this.refunded,this.rejected,this.request,this.samagri,this.utoken,this.time,this.serviceId,this.service,
    this.service_image,this.pandituid,this.panditpic,this.otp,this.pandit,this.contact,this.date,this.lat,this.lng,this.client,this.clientuid,this.btoken,this.Location,this.alternate_contact
  });

  BookingModal.fromSnapshot(DocumentSnapshot snapshot){
    pdistance = snapshot.get('pdistance');
    vdistance = snapshot.get('vdistance');
    dt = snapshot.get('dt');
    timestamp = snapshot.get('timestrap');
    convineancefee = snapshot.get('convineancefee');
    bookingId = snapshot.get('bookingId');
    Due = snapshot.get('Due');
    benefit = snapshot.get('benefit');
    puja_charge = snapshot.get('puja_charge');
    refundmoney = snapshot.get('refundmoney');
    samagri_price = snapshot.get('samagri_price');
    transaction = snapshot.get('transaction');
    swastik = snapshot.get('swastik');
    vendor_price = snapshot.get('vendor_price');
    discount =  snapshot.get('discount');
    cancel = snapshot.get('cancel');
    cod = snapshot.get('cod');
    online = snapshot.get('online');
    deliver = snapshot.get('deliver');
    payment = snapshot.get('payment');
    puja_status = snapshot.get('puja_status');
    rating = snapshot.get('rating');
    refund = snapshot.get('refund');
    refunded = snapshot.get('refunded');
    rejected = snapshot.get('rejected');
    request = snapshot.get('request');
    samagri = snapshot.get('samagri');
    utoken = snapshot.get('utoken');
    pic = snapshot.get('pic');
    time = snapshot.get('time');
    serviceId = snapshot.get('serviceId');
    service = snapshot.get('service');
    service_image = snapshot.get('service_image');
    pandituid = snapshot.get('pandituid');
    panditpic = snapshot.get('panditpic');
    otp = snapshot.get('otp');
    pandit = snapshot.get('pandit');
    contact = snapshot.get('contact');
    date = snapshot.get('date');
    lat = snapshot.get('lat');
    lat = snapshot.get('lng');
    clientuid = snapshot.get('clientuid');
    client = snapshot.get('client');
    btoken = snapshot.get('btoken');
    alternate_contact = snapshot.get('alternate_contact');
    Location = snapshot.get('Location');
    status = snapshot.get('status');
    email = snapshot.get('email');
    vendor_uid = snapshot.get('vendor_uid');
    vendor_token = snapshot.get('vendor_token');
   // service_charge = snapshot.get('service_charge');
  }

}
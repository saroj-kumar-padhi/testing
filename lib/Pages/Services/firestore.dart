import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
class FirestoreService{
Stream<List<T>> ctream<T>({
    required final double lat,
    required final double lng,
    required T builder(Map<String, dynamic> data),
  }) {
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
    double radius = 15;
    String field = 'location';
    final reference = FirebaseFirestore.instance.collection('Avaliable_pundit');
    final stream = geo.collection(collectionRef: reference).within(center: center, radius: radius, field: field);
    return stream.map((snapshot) =>
        snapshot.map((snapshot) => builder(snapshot.data()!)).toList()..shuffle());
  }
  
  
  }
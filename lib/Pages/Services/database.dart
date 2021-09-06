

import 'package:pujapurohit/Models/BModal.dart';
import 'package:pujapurohit/Pages/Services/firestore.dart';

abstract class Database{
  Stream<List<BModal>> readBData(double latitude,double longitude);
}

class FirestoreDatabase implements Database {
  final _service =FirestoreService();
 @override
  Stream<List<BModal>> readBData(double latitude,double longitude)=>_service.ctream(
      lat: latitude,
      lng:  longitude,
      builder: (data)=>BModal.fromMap(data));
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceTopModal{

  String? name;
  String? type;
  

  ServiceTopModal({this.name,this.type});

  ServiceTopModal.fromSnapshot(DocumentSnapshot snapshot){
    name = snapshot.get('name');
    type = snapshot.get('type');

  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Models/CityModal.dart';

class CitiesController extends GetxController{
  Rx<CityModel> userModel =CityModel().obs;
  Rxn<List<CityModel>>calenderList = Rxn<List<CityModel>>();
  
  List<CityModel>? get serviceTop => calenderList.value;
  @override
  void onInit(){
   
    calenderList.bindStream(trendingStream()); 
    super.onInit();
  }
  @override
  void onClose(){
    
    super.onClose();
  }
  Stream<List<CityModel>> trendingStream() {
    
    return FirebaseFirestore.instance
        .collection("PujaPurohitFiles")
        .doc("services")
        .collection("listed_districts").orderBy("name")
        .snapshots()
        .map((QuerySnapshot query) {
      List<CityModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(CityModel.fromSnapshot(element));
      });
      return retVal;
    });
  }
}


class CityController extends GetxController{
  final String district;
  CityController({required this.district});
  Rx<CityModel> userModel = CityModel().obs;
 

  @override
  void onInit(){
    initializeUserModel();

    super.onInit();
  }
  @override
  void onClose(){
    super.onClose();
  }
  
  initializeUserModel()async{
    userModel.value =await FirebaseFirestore.instance
        .collection('PujaPurohitFiles/services/listed_districts')
        .doc('$district')
        .get()
        .then((doc) => CityModel.fromSnapshot(doc));
  }

}
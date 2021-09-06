import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Pages/PanditSection/Controllers/panditsController.dart';
import 'package:pujapurohit/Pages/PanditSection/PanditHome.dart';
import 'package:pujapurohit/Pages/PanditSection/Profile.dart';
import 'package:pujapurohit/SignIn/AuthController.dart';
import 'package:pujapurohit/Widgets/Loader.dart';
import 'package:pujapurohit/Widgets/Texts.dart';
import 'package:pujapurohit/Widgets/YoutubePlayer.dart';
import 'package:pujapurohit/Widgets/bottombar.dart';
import 'package:pujapurohit/controller/LocationController.dart';
import 'package:pujapurohit/controller/UserController.dart';

import '../NewPanditHome.dart';
import 'Widgets/responsive.dart';

class Detail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      double height = MediaQuery.of(context).size.height;
      double width =  MediaQuery.of(context).size.width;
      String detail = '#${Get.parameters['id']!}';
      var language = 'detailEnglish'.obs;
      final AuthController authController = Get.find();
       LocationController locationController = Get.put(LocationController());
    return Scaffold(
    backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              StreamBuilder<DocumentSnapshot>(
                stream:FirebaseFirestore.instance.doc('PujaPurohitFiles/commonCollections/deatil/$detail').snapshots(),
                builder: (context, snapshot) {
                    if(snapshot.data==null){
                    return Center(child:Loader());
                  }
                  List<Widget> para = [];
                  for(var i in snapshot.data!.get('detailEnglish')){
                    final String textdata = i;
                    final txt = Container(
                      margin: EdgeInsets.all(20),
                      child: Text1(data: "${i}", max: 20,min:18,clr:Colors.black,),
                    );
                    para.add(txt);
                  }
                  return Column(
                    children: [
                       Container(
                       height: height*0.35,
                        width: width,
                        color: Color(0xff181c2c),
                        padding: EdgeInsets.only(left:width*0.06,right: 30,top: height*0.02,bottom: 10),
                        margin: EdgeInsets.only(bottom: height*0.04),
                        child: Row(
                          children: [
                              Expanded(
                              flex: 1,
                              child: Container(
                                margin:  ResponsiveWidget.isMediumScreen(context)?EdgeInsets.all(0.0):EdgeInsets.only(left:width*0.06,right:width*0.01),
                                height:ResponsiveWidget.isSmallScreen(context)?height*0.15:height*0.23,
                                
                                width: width*0.15,
                                decoration: BoxDecoration(
                                  color:Colors.white,
                                  image: DecorationImage(image: NetworkImage("${snapshot.data!.get('image')}"),
                                  fit: BoxFit.fill,
                                  ),
                                  
                                ),
                              ) 
                              
                              ),
                              SizedBox(width:width*0.05),
                                Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(top:height*0.035),
                                child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   Text1(max: 28,min: 26,data: "${snapshot.data!.get('name')}",clr:Colors.white,),
                                    SizedBox(height:10),
                                    Text1(data: "${snapshot.data!.get('date')}",max: 12,min: 11,clr: Colors.white54,),
                                    SizedBox(height:10),
                                    Text1(data: "Vikram Samvat: ${snapshot.data!.get('vikram')}",max: 12,min: 11,clr: Colors.white54,),
                                    SizedBox(height:20),
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                       Expanded(
                                         flex: 1,
                                         child: MiniBox(icon: true, FirstText: "${snapshot.data!.get('begin')}", SecondText: "Tithi begin",iconData: CupertinoIcons.clock,)),
                                          Expanded(
                                            flex: 1,
                                            child: MiniBox(icon: true, FirstText: "${snapshot.data!.get('end')}", SecondText: "Tithi End",iconData: CupertinoIcons.clock,)),
                                    
        
                                      ],
                                    )
                                  ]
                                )
                              ) ),
                               SizedBox(width:width*0.05),  


                       ResponsiveWidget.isSmallScreen(context)? SizedBox():Expanded(
                              flex:1,
                              child:Padding(
                               padding: EdgeInsets.only(top:height*0.03),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Row(
                                      children: [
                                        Text1(data:"OFFER",max: 12,min: 10,clr: Colors.white,),
                                        SizedBox(width:5),
                                        Container(width:width*0.15,height:1,color:Colors.white54)
                                      ],
                                    ),
                                    SizedBox(height:5),
                                    Expanded(
                                        child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                          Container(
                                            margin: EdgeInsets.only(left:5),
                                            
                                            width:1,height:height*0.18,color:Colors.white54),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                             children:[
                                               Text1(data: "No offers right now", max: 12, min: 11,clr: Colors.white,),
                                              // offers(width,"20% of on all orders up to ₹1000"),
                                               SizedBox(height:20),
                                              // offers(width,"20% of upto INR 125/- with Kotak Credit or Debit Cards | Use Code KOTAK125"),
        
                                              ]
                                            ),
                                          )
                                            
                                        ],
                                      ),
                                    )
                                  ]
                                ),
                              ) ),
                          ],
                        )                 
                        ),
                       snapshot.data!.get('video') ?Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Expanded(child: YoutubeAppDemo(id:snapshot.data!.get('videoId')),)
                            Container(
                              width: width*0.7,
                              height:ResponsiveWidget.isSmallScreen(context)?height*0.4:ResponsiveWidget.isMediumScreen(context)?height*0.6: height*0.65,
                              child: YoutubeAppDemo(id:snapshot.data!.get('videoId')),
                            )
                          ],
                        ):SizedBox(),

                    Column(
                        children: [
                          ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: para,
                            shrinkWrap: true,
                          ),                         
                        ],
                    ),
                      SizedBox(height: 10,),
                      BottomBar()
                    ],
                  );
                }
              )
          ],
        ),
      ),
    );
  }
   Column logedpandits(AsyncSnapshot<DocumentSnapshot<Object?>> snapshot, ) {
     
    return Column(
                                children: [
                                Text1(data: "Recommended pujan on this day :${snapshot.data!.get('pujaname')}", max: 20,min:18,clr:Colors.black,),
                               SizedBox(height: 10,),
                              GetX<UserController>(
                                init: Get.put<UserController>(UserController()),
                                builder: (UserController userController){
                                  if(userController.userModel.value.lat == null){
                                    return Center(child:SizedBox(height:50,child: Loader(),));
                                  }
                                  return   GetX<PanditKeywordController>(
                            init:  Get.put<PanditKeywordController>(PanditKeywordController(what:'${snapshot.data!.get('pujakeyword')}',lat: 26.1197,lng: 85.3910)),
                            builder: (PanditKeywordController panditController) {
                              if (panditController != null && panditController.pandits != null) {
                                if(panditController.panditList.value!.isEmpty){
                                  return Padding(
                                    padding: const EdgeInsets.only(top:30.0),
                                    child: Text1(data: "No pandit in your area performing ${snapshot.data!.get('pujaname')}", max: 18, min: 12,clr:Colors.redAccent),
                                  );
                                }
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: panditController.panditList.value!.length,
                                itemBuilder: (_, index) {
                                  return NewPanditCard(bModal: panditController.pandits![index],uid: '',);
                                },
                              );
                              
                          } else {
                            return Center(child: SizedBox(
                                height: 50,width: 50,
                                child: Loader()));
                          }
                        },
                    );
                                },
                              )

                   
                              ],
                            );
  }
  Column pandits(AsyncSnapshot<DocumentSnapshot<Object?>> snapshot, LocationController locationController) {
    return Column(
                             
                             
                             
                              children: [
                                Text1(data: "Recommended pujan on this day :${snapshot.data!.get('pujaname')}", max: 20,min:18,clr:Colors.black,),
                               SizedBox(height: 10,),
                                GetX<PanditKeywordController>(
                            init: Get.put<PanditKeywordController>(PanditKeywordController(what: '${snapshot.data!.get('pujakeyword')}',lat: double.parse('${locationController.location.value.lat}'),lng: double.parse('${locationController.location.value.lng}',),)),
                            builder: (PanditKeywordController panditController) {
                              if (panditController != null && panditController.pandits != null) {
                                if(panditController.panditList.value!.isEmpty){
                                  return Padding(
                                    padding: const EdgeInsets.only(top:30.0),
                                    child: Text1(data: "No pandit in your area performing ${snapshot.data!.get('pujaname')}", max: 18, min: 12,clr:Colors.redAccent),
                                  );
                                }
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: panditController.panditList.value!.length,
                                itemBuilder: (_, index) {
                                  return PanditCard(bModal: panditController.pandits![index]);
                                },
                              );
                              
                          } else {
                            return Center(child: SizedBox(
                                height: 50,width: 50,
                                child: Loader()));
                          }
                        },
                    )

                   
                              ],
                            );
  }

}
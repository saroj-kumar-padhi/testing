import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pujapurohit/Pages/NewPanditHome.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/SignIn/AuthController.dart';
import 'package:pujapurohit/Widgets/Loader.dart';
import 'package:pujapurohit/Widgets/Texts.dart';
import 'package:pujapurohit/colors/light_colors.dart';
import 'package:pujapurohit/controller/UserController.dart';
import 'package:pujapurohit/controller/loaderController.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'dart:ui' as ui;
import 'Controllers/panditsController.dart';
import 'Detail.dart';

class Events extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
       appBar: PreferredSize(preferredSize: Size(width,height*0.099,), 
      child:TopTabs()
      
      
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [      
            Padding(
              padding:  EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)? 0.0:25.0),
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.data==null){
                    return Center(child: Loader(),);
                  }
                  List <dynamic> events = snapshot.data!.get("events");
                  Map<int, dynamic> map = events.asMap();
                  final EventController  eventController= Get.put(EventController());
                 List<dynamic> sliders = snapshot.data!.get("sliders");
                List<Widget> slides = [];
                 for(var i in sliders){
                   var link=i;
                   final sliderWidget = Container(

                     decoration:BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         image: DecorationImage(
                           image: NetworkImage("$link"),
                           fit: BoxFit.contain
                         )
                     ),
                     padding:EdgeInsets.only(left: 30,right: 30),

                   );
                   slides.add(sliderWidget);
                 }
                  return Column(
                    children: [
                      SizedBox(height: 20,),
                      ImageSlideshow(                
                        width:width*0.9,
                        height: height*0.45,
                        initialPage: 0,                      
                        indicatorColor: Colors.orangeAccent,                      
                        indicatorBackgroundColor: Colors.grey,                    
                        children:slides,                      
                        onPageChanged: (value) {
                          print('Page changed: $value');
                        },                      
                        autoPlayInterval: 5000,                      
                        isLoop: true,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                          itemBuilder:(_,index) {
                          if(map[index]["status"]=="upcoming"){
                           return  Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(height: 20,),
                               customHeading(context,"Upcoming","Event"),
                               SizedBox(height: 20,),
                               InkWell(
                                 hoverColor: Colors.transparent,
                                 onTap: (){
                                   
                                   eventController.updateupcoming(map[index]["bigs"],map[index]["youtube"],map[index]["puja"],map[index]["price"],map[index]["note"],map[index]["age"],map[index]["gender"], map[index]["place"],map[index]["status"],map[index]["image"], map[index]["name"], map[index]["about"], map[index]["duration"], map[index]["total_days"],map[index]["participants"],map[index]["terms"]);
                                   Get.toNamed('/eventDetail');
                                 },
                                 child: Row(
                                   mainAxisAlignment:ResponsiveWidget.isSmallScreen(context)? MainAxisAlignment.start:MainAxisAlignment.center,
                                   children: [
                                     Container(
                                          height: height*0.55,
                                          width: width*0.8,
                                        child:ResponsiveWidget.isSmallScreen(context)? Image.network(map[index]["image"]):Image.network(map[index]["bigS"]),
                                        padding: EdgeInsets.all(20) ,
                                        ),
                                   ],
                                 ),
                               ),
                             ],
                           );
                          }
                          if(map[index]["status"]=="live"){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                customHeading(context,"Live","Event"),
                                SizedBox(height: 20,),
                                InkWell(
                                  hoverColor: Colors.transparent,
                                  onTap:(){
                                    eventController.updatelive(map[index]["bigs"],map[index]["youtube"],map[index]["price"],map[index]["note"],map[index]["age"],map[index]["gender"], map[index]["place"],map[index]["status"],map[index]["image"], map[index]["name"], map[index]["about"], map[index]["duration"], map[index]["total_days"],map[index]["participants"],map[index]["terms"]);
                                    Get.toNamed('/eventDetail');
                                  },
                                  child: Row(
                                    mainAxisAlignment:ResponsiveWidget.isSmallScreen(context)? MainAxisAlignment.start:MainAxisAlignment.center,
                                    children: [
                                       Container(
                                          height: height*0.55,
                                          
                                        child:ResponsiveWidget.isSmallScreen(context)? Image.network(map[index]["image"]):Image.network(map[index]["bigS"]),
                                        padding: EdgeInsets.all(20) ,
                                        ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                customHeading(context,"Previous","Event"),
                                SizedBox(height: 20,),
                                  InkWell(
                                    hoverColor: Colors.transparent,
                                    onTap:(){
                                      eventController.updatePrevious(map[index]["bigs"],map[index]["youtube"],map[index]["place"],map[index]["status"],map[index]["image"], map[index]["name"], map[index]["about"], map[index]["duration"], map[index]["total_days"], map[index]["top3"],map[index]["participants"]);
                                      Get.toNamed('/eventDetail');
                            },
                                    child: Row(
                                      mainAxisAlignment:ResponsiveWidget.isSmallScreen(context)? MainAxisAlignment.start:MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: height*0.55,
                                          width: width*0.8,
                                        child:ResponsiveWidget.isSmallScreen(context)? Image.network(map[index]["image"]):Image.network(map[index]["bigS"]),
                                        padding: EdgeInsets.all(20) ,
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            );
                          }),
                    ],
                  );
                }
              ),
            ),

          ],
        ),
      ),
    );
  }
 Padding customHeading(BuildContext context,String txt1,String txt2) {
    return Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: RichText(
                     text: TextSpan(
                       style: Theme
                           .of(context)
                           .textTheme
                           .headline4,
                       children: [
                         TextSpan(text: "$txt1\n",),
                         TextSpan(
                             text: "$txt2",
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                             ))
                       ],
                     ),
                   ),
                 );
  }}
 


class EventDetail extends StatefulWidget{
  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final LoadController loadController = Get.put(LoadController());
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
   


    final EventController  eventController= Get.put(EventController());
    return Scaffold(
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Obx((){
              return Stack(
                children: [
                  Image.network("${eventController.eventData.value.image}"),
                  Padding(
                    padding: const EdgeInsets.only(left:20.0,top:25),
                    child: Align(
                    alignment : Alignment.topLeft,
                      child: Container(
                        height:35,width:35,
                        padding :  EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Color(0xff181c2c),
                          shape: BoxShape.circle
                        ),
                        child: IconButton(
                          onPressed: (){Get.back();},
                          icon: Icon(Icons.arrow_back_ios,size: 12,color: Colors.white,),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                        Icon(Icons.location_on_outlined,size: 14,color: Colors.black54, ),
                        SizedBox(width:5),
                      Text1(data:"${eventController.eventData.value.place}", max: 14, min: 12,clr: Colors.black54,),
                      Spacer(),
                      Text1(data: "${eventController.eventData.value.duration}", max: 14, min: 12,clr: Colors.black54,)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text1(data:"${eventController.eventData.value.participants!.length} Participants", max: 14, min: 12,clr: Colors.black54,),
                      Spacer(),
                      Text1(data: "${eventController.eventData.value.total_days}", max: 14, min: 12,clr: Colors.black54,)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx((){
                        return buttonFocus(eventController.eventData.value.status!);
                      })
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text1(data: "About", max: 24, min: 20,clr: Color(0xff181c2c),),
                  SizedBox(height: 20,),
                  Text1(data: "${eventController.eventData.value.about}", max: 14, min: 12,clr: Colors.black54,),
                  SizedBox(height: 20,),
                 // loggeduggestions("${eventController.eventData.value.puja}"),
                  //SizedBox(height: 20,),
                  // SizedBox(
                  //   height: 230,
                  //   child: YoutubeAppDemo(id: "${eventController.eventData.value.youtube}"),
                  // )

                ],
              ),
            ),

            Obx((){
              return bottomSection(eventController.eventData.value.status!,context);
            })
          ],
        ),
      ),
    );
  }

  Widget bottomSection(String status,BuildContext context){
    final EventController eventController = Get.put(EventController());
    double height = MediaQuery.of(context).size.height;
    if(eventController.eventData.value.status=="upcoming"){
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text1(data: "Terms and Condition", max: 24, min: 20,clr: Color(0xff181c2c),),

            ListView.builder(
                itemCount: eventController.eventData.value.terms!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_,index){
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text1(data: "${eventController.eventData.value.terms![index]}", max: 14, min: 12,clr: Colors.black54,),
                  );
                })
          ],
        ),
      );
    }
    if(eventController.eventData.value.status=="live"){
      return Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text1(data: "Vote participants", max: 24, min: 20),
              ],
            ),
          ),

          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("PujaPurohitFiles/events/${eventController.eventData.value.name}").orderBy("votes").snapshots(),
              builder: (context, snapshot) {
                if(snapshot.data==null){
                  return CircularProgressIndicator();
                }
                List<dynamic> snaps =snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snaps.length,
                    itemBuilder: (_,index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snaps[index]["image"]),

                            ),
                            title: Text1(data: "${snaps[index]["name"]}", max: 14 , min: 12,clr: Colors.black87,weight: FontWeight.bold,),
                          ),
                          Container(
                            height:450,
                            child: InkWell(
                                onTap:(){
                                  Get.toNamed('/imageview?id=${snaps[index]["id"]}&vote=${snaps[index]["vote"]}&name=${snaps[index]["event"]}');
                                },
                                child: Image.network("${snaps[index]["image"]}",fit:BoxFit.fill ,)),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left:20.0,right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events").snapshots(),
                                  builder: (context, snapshot) {
                                    if(snapshot.data==null){
                                      return Text1(data: "Loading...", max: 12, min: 11);
                                    }
                                    return Row(

                                      children: [
                                        snaps[index]["voters"].contains('${authController.user!.phoneNumber}')?
                                        InkWell(
                                            onTap: (){
                                              List<dynamic> voters = snapshot.data!.get("${snaps[index]['event']}V");
                                              List<dynamic> local_voters = snaps[index]['voters'];
                                              List<dynamic> total_V= voters;
                                              voters.contains('${authController.user!.phoneNumber}')?voters.remove('${authController.user!.phoneNumber}'):(){};

                                              FirebaseFirestore.instance.doc("PujaPurohitFiles/events").update({
                                                '${snaps[index]['event']}V':total_V
                                              });
                                              List<dynamic> total_L= local_voters;
                                              local_voters.contains('${authController.user!.phoneNumber}')?local_voters.remove('${authController.user!.phoneNumber}'):(){};

                                              FirebaseFirestore.instance.doc("PujaPurohitFiles/events/${snaps[index]['event']}/${snaps[index]['id']}").update({
                                                'voters':total_L,
                                                'votes':FieldValue.increment(-1)
                                              });

                                            },
                                            child: Icon(CupertinoIcons.heart_fill ,color: Color(0xff181c2c),)) :
                                        InkWell(
                                            onTap: (){
                                              if(snapshot.data!.get("${snaps[index]["event"]}V").contains('${authController.user!.phoneNumber}')){
                                                Get.snackbar("Info", "You have already used your vote",backgroundColor: Colors.white);
                                              }
                                              else{
                                                List<dynamic> voters = snapshot.data!.get("${snaps[index]['event']}V");
                                                List<dynamic> local_voters = snaps[index]['voters'];
                                                List<dynamic> total_V= voters;
                                                voters.contains('${authController.user!.phoneNumber}')?(){}:voters.add('${authController.user!.phoneNumber}');

                                                FirebaseFirestore.instance.doc("PujaPurohitFiles/events").update({
                                                  '${snaps[index]['event']}V':total_V
                                                });
                                                List<dynamic> total_L= local_voters;
                                                local_voters.contains('${authController.user!.phoneNumber}')?(){}:local_voters.add('${authController.user!.phoneNumber}');

                                                FirebaseFirestore.instance.doc("PujaPurohitFiles/events/${snaps[index]['event']}/${snaps[index]['id']}").update({
                                                  'voters':total_L,
                                                  'votes':FieldValue.increment(-1)
                                                });

                                              }
                                            },
                                                  child: Icon(CupertinoIcons.heart,)),
                                        Spacer(),
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                                color:Color(0xff181c2c),

                                            ),
                                            child: Text1(data: "${snaps[index]["voters"].length} votes", max: 14 , min: 12,clr: Colors.white,weight: FontWeight.bold,)),
                                        Spacer(),
                                        Obx((){
                                        return loadController.load.value.active?SizedBox(height: 50,width:50,child: Loader(),): InkWell(
                                             onTap: ()async{
                                               Share.share('Visit the link and vote ${snaps[index]["name"]} at Puja Purohit pujapurohit.in/#/imageview?id=${snaps[index]["id"]}&vote=${snaps[index]["vote"]}&name=${snaps[index]["event"]}', subject: 'Puja Purohit Contest');

                                             },
                                             child: Icon(CupertinoIcons.share));
                                       })

                                      ],
                                    );
                                  }
                                ),

                                SizedBox(height: 20,),
                              ],
                            ),
                          ),

                        ],
                      );
                    });
              }
          ),
        ],
      );
    }
    return Column(
      children: [
        Text1(data: "Top 3", max: 28, min: 24,weight: FontWeight.bold,),
        SizedBox(height: 10,),
        Obx((){
          return SizedBox(
            height: height*0.2,
            child: ListView.builder(
                itemCount: eventController.eventData.value.top3!.length,
                scrollDirection: Axis.horizontal,
                //physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_,index){
                  return InkWell(
                    onTap: (){
                      Get.toNamed('/imageview?id=${eventController.eventData.value.top3![index]["id"]}&vote=false&name=${eventController.eventData.value.name}');
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      height: 300,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("${eventController.eventData.value.top3![index]["image"]}"),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                  );
                }),
          );
        })
      ],
    );
  }

  Widget buttonFocus(String status) {
    final EventController eventController = Get.put(EventController());
    final AuthController authController = Get.put(AuthController());
    if(status== "previous"){
      return InkWell(
        onTap: (){

        },
        child: Container(
          color: Color(0xff181c2c),
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          //margin: EdgeInsets.only(left:width*0.01,right:width*0.1 ),
          child: Text1(data: "Winner Announced", max: 14, min: 12,clr: Colors.white,),
        ),
      );
    }
    if(status== "live"){

      return InkWell(
        onTap: (){

        },
        child: Container(
          color: Color(0xff181c2c),
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          //margin: EdgeInsets.only(left:width*0.01,right:width*0.1 ),
          child: Text1(data: "Vote Participants", max: 14, min: 12,clr: Colors.white,),
        ),
      );
    }
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.data==null){
          return Loader();
        }
        List<dynamic> participants = snapshot.data!.get("${eventController.eventData.value.name}P");
        return InkWell(
                        onTap: (){
                          eventController.updateparticipants(participants);
                          if(participants.contains("${authController.user!.uid}")){
                            Get.snackbar("Info", "Already Participated",backgroundColor: Colors.white);
                            Get.toNamed('/imageview?id=${authController.user!.uid}&vote=false&name=${eventController.eventData.value.name}');
                          }
                          else{
                            Get.to( Registration_Form());
                          }

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: participants.contains("${authController.user!.uid}")? Color(0xff181c2c):Colors.white,
                            boxShadow: [
                              BoxShadow(color: participants.contains("${authController.user!.uid}")?Color(0xff181c2c).withOpacity(0.2):LightColors.shadowColor,blurRadius: 20)
                            ]
                          ),

                          alignment: Alignment.center,
                          padding: EdgeInsets.all(15),
                          //margin: EdgeInsets.only(left:width*0.01,right:width*0.1 ),
                          child: Text1(data:participants.contains("${authController.user!.uid}")? "View Participant":"Participate Now", max: 14, min: 12,clr: participants.contains("${authController.user!.uid}")? Colors.white:Color(0xff181c2c),),
                        ),
                      );
      }
    );
  }
  GetX<UserController> loggeduggestions(String snapshot) {
    return GetX<UserController>(
      init: Get.put<UserController>(UserController()),
      builder: (UserController userController){
        if(userController.userModel.value.lat == null){
          return Center(child:SizedBox(height:50,child: Loader(),));
        }
        return   GetX<PanditKeywordController>(
          init:  Get.put<PanditKeywordController>(PanditKeywordController(what:'$snapshot',lat: double.parse('${userController.userModel.value.lat}'),lng: double.parse('${userController.userModel.value.lng}'))),
          builder: (PanditKeywordController panditController) {
            if (panditController != null && panditController.pandits != null) {
              if(panditController.panditList.value!.isEmpty){
                return SizedBox();
              }
              return Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 220.0,
                      child: new ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:panditController.panditList.value!.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new PanditNewCard(bmModal: panditController.pandits![index],lat: double.parse('${userController.userModel.value.lat}'),lng: double.parse('${userController.userModel.value.lng}'));
                        },
                      ),
                    ),
                  ),

                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              );

            } else {
              return Center(child: SizedBox(
                  height: 50,width: 50,
                  child: Loader()));
            }
          },
        );
      },
    );
  }


}

class ImageView extends StatefulWidget{

  
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final LoadController loadController = Get.put(LoadController());
  GlobalKey _ssglobalKey = GlobalKey();
  String id = Get.parameters["id"]!;
  String vote = Get.parameters["vote"]!;
  String name = Get.parameters["name"]!;
  _saveScreen() async {
    loadController.updateLoad();
    RenderRepaintBoundary boundary = _ssglobalKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image imageo = await boundary.toImage(pixelRatio: 10);

    ByteData? byteData =
    await (imageo.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result =
      await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      print(result);

      if (result["isSuccess"] == true) {
        loadController.updateLoad();

        await WcFlutterShare.share(
            sharePopupTitle: 'Vote',
            subject: 'Vote me at Puja Purohit ( Best Online Pandit Booking Platform)',
            text: "Please Vote me at Puja Purohit follow this link to vote pujapurohit.in/#/imageview?id=$id&vote=$vote&name=$name'",
            fileName: 'share.png',
            mimeType: 'image/png',
            bytesOfFile: byteData.buffer.asUint8List());
      } else {
        loadController.updateLoad();

      }
    }
  }
  // _requestPermission() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //   ].request();

  //   final info = statuses[Permission.storage].toString();
  //   print(info);
  //   // _toastInfo(info);
  // }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events/$name/$id").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.data==null){
                    return Loader();
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(onPressed: (){
                              Get.back();
                            }, icon: Icon(Icons.close,color: Color(0xff181c2c),size: 20,)),
                            Spacer(),
                            IconButton(
                                tooltip: "Share",
                                onPressed: (){
                                  //Share.share('Visit the link and vote pujapurohit.in/#/imageview?id=${snapshot.data!.get("id")}&vote=$vote&name=$name', subject: 'Puja Purohit Contest');
                                  _saveScreen();
                                }, icon: Icon(Icons.share,color: Color(0xff181c2c),size: 20,))
                          ],
                        ),
                        SizedBox(
                          height: height*0.5,
                          child: InteractiveViewer(
                              child: RepaintBoundary(
                                  key: _ssglobalKey,
                                  child: Image.network("${snapshot.data!.get("image")}",fit: BoxFit.fill,))),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Text1(data: "Name : ${snapshot.data!.get("name")}", max: 26, min: 20,clr: Color(0xff181c2c),weight: FontWeight.w500,),
                            Spacer(),
                            Text1(data: "Age : ${snapshot.data!.get("age")}", max: 26, min: 20,clr: Color(0xff181c2c),weight: FontWeight.w500,),

                          ],
                        ),
                        SizedBox(height: height*0.1,),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xff181c2c),
                              boxShadow: [
                                BoxShadow(color: LightColors.shadowColor,blurRadius: 20)
                              ],
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text1(data: "Total Votes : ${snapshot.data!.get("voters").length}", max: 24, min: 20,clr: Colors.white,weight: FontWeight.w500,),
                        ),
                        SizedBox(height: 20,),
                        snapshot.data!.get("vote")?StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events").snapshots(),
                            builder: (context, mainsnapshot) {
                              if(snapshot.data==null){
                                return Loader();
                              }
                              List<dynamic> voters = mainsnapshot.data!.get("${name}V");
                              List<dynamic> local_voters = snapshot.data!.get("voters");
                              return InkWell(
                                onTap: (){
                                  if(voters.contains(authController.user!.phoneNumber)){
                                  if(local_voters.contains(authController.user!.phoneNumber)){
                                    List<dynamic> total_V= voters;
                                    voters.contains('${authController.user!.phoneNumber}')?voters.remove('${authController.user!.phoneNumber}'):(){};

                                    FirebaseFirestore.instance.doc("PujaPurohitFiles/events").update({
                                      '${name}V':total_V
                                    });
                                    List<dynamic> total_L= local_voters;
                                    local_voters.contains('${authController.user!.phoneNumber}')?local_voters.remove('${authController.user!.phoneNumber}'):(){};

                                    FirebaseFirestore.instance.doc("PujaPurohitFiles/events/$name/$id").update({
                                      'voters':total_L,
                                      'votes':FieldValue.increment(-1)
                                    });
                                  }
                                  else{
                                    Get.snackbar("Info", "You already used your vote ",backgroundColor: Colors.white);
                                  }


                                  }
                                  else{
                                    List<dynamic> total_V= voters;
                                    voters.contains('${authController.user!.phoneNumber}')?(){}:voters.add('${authController.user!.phoneNumber}');

                                    FirebaseFirestore.instance.doc("PujaPurohitFiles/events").update({
                                      '${name}V':total_V
                                    });
                                    List<dynamic> total_L= local_voters;
                                    local_voters.contains('${authController.user!.phoneNumber}')?(){}:local_voters.add('${authController.user!.phoneNumber}');

                                    FirebaseFirestore.instance.doc("PujaPurohitFiles/events/$name/$id").update({
                                      'voters':total_L,
                                      'votes':FieldValue.increment(1)
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:local_voters.contains(authController.user!.phoneNumber)?Color(0xff181c2c):Colors.white,
                                      boxShadow: [
                                        BoxShadow(color: LightColors.shadowColor,blurRadius: 20)
                                      ],
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Text1(data: local_voters.contains(authController.user!.phoneNumber)?"Upvoted":"Upvote", max: 24, min: 20,clr:local_voters.contains(authController.user!.phoneNumber)?Colors.white:Color(0xff181c2c),weight: FontWeight.w500,),
                                ),
                              );
                            }
                        ):SizedBox(),
                        SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text1(data: "List of Voters :", max: 20, min: 18,clr: Colors.black54,),
                          ],
                        ),
                        SizedBox(
                          height: 500,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.get("voters").length,
                              itemBuilder: (_,index){
                                List<dynamic> numbers = snapshot.data!.get("voters");
                                return Text1(data: "${index} : ${numbers[index].toString().substring(0,5) }XXXX${numbers[index].toString().substring(9,13) }", max: 14 , min: 11,clr: Colors.black54,);
                              }),
                        )
                      ],
                    ),
                  );
                }
            ),

          ),
          Obx((){
            return loadController.load.value.active?Container(
              color: Colors.black26,
              height: height,
              width: width,
              child: Center(
                child: SizedBox(
                  height: 50,width: 50,
                  child: Loader(),
                ),
              ),
            ):SizedBox();
          })
        ],
      ),
    );
  }
}
class EventController extends GetxController{
  var eventData = EventData().obs;

  updateData(String image,String name,List<dynamic> age,List<dynamic> gender){
    eventData.update((val) {
      val!.image = image;
      val.name = name;
      val.age = age;
      val.gender= gender;
    });
  }
  updatePrevious(String BigS,String youtube,String place,String status,String image,String name,String  about,String duration,String total_days ,List<dynamic> top3,List<dynamic> participants){
    eventData.update((val) {
      val!.about = about;
      val.image = image;
      val.name = name;
      val.top3 = top3;
      val.duration = duration;
      val.total_days = total_days;// Container(
          //   alignment: Alignment.centerLeft,
          //  height: height*0.2,
          //   color: Color(0xff181c2c),
          //   padding: EdgeInsets.all(30),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       SizedBox(height: 20,),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text1(data: "Events", max: 24, min: 20,weight: FontWeight.w600,clr: Colors.white,),
          //         ],
          //       ),
          //        SizedBox(height: 20,),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Column(
          //             children: [
          //               Text1(data: "Participated", max: 14, min: 10,clr: Colors.white,),
          //               SizedBox(height: 5,),
          //               Text1(data: "0", max: 12, min: 10,clr: Colors.white,),
          //             ],
          //           ),
          //           Column(
          //             children: [
          //               Text1(data: "Won", max: 14, min: 10,clr: Colors.white,),
          //               SizedBox(height: 5,),
          //               Text1(data: "0", max: 12, min: 10,clr: Colors.white,),
          //             ],
          //           ),
                
          //         ],
          //       )
          //     ],
          //   ),
          // ),

      val.status = status;
      val.place = place;
      val.participants = participants;
      val.youtube = youtube;
      val.BigS = BigS;
    });

  }
  updateupcoming(String BigS,String youtube,String puja,dynamic price,String note,List<dynamic> age,List<dynamic> gender,String place,String status,String image,String name,String  about,String duration,String total_days ,List<dynamic> participants,List<dynamic> terms){
    eventData.update((val) {
      val!.about = about;
      val.image = image;
      val.name = name;
      val.duration = duration;
      val.total_days = total_days;
      val.status = status;
      val.place = place;
      val.participants = participants;
      val.terms = terms;
      val.age = age;
      val.gender= gender;
      val.note = note;
      val.price = price;
      val.puja = puja;
      val.youtube = youtube;
      val.BigS = BigS;
    });
  }
  updatelive(String BigS,String youtube,dynamic price,String note,List<dynamic> age,List<dynamic> gender,String place,String status,String image,String name,String  about,String duration,String total_days ,List<dynamic> participants,List<dynamic> terms){
    eventData.update((val) {
      val!.about = about;
      val.image = image;
      val.name = name;
      val.duration = duration;
      val.total_days = total_days;
      val.status = status;
      val.place = place;
      val.participants = participants;
      val.terms = terms;
      val.age = age;
      val.gender= gender;
      val.note = note;
      val.price = price;
      val.youtube = youtube;
      val.BigS = BigS;
    });
  }
  updateparticipants(List<dynamic> p){
    eventData.value.participants1 = p;
  }
}
class EventData{
  String? BigS;
  String? youtube;
  String? puja;
  String? image;
  String? name;
  String? status;
  String? note;
  String? place;
  String? duration;
  String? about;
  String? total_days;
  List<dynamic>? top3;
  List<dynamic>? terms;
  dynamic price;
  List<dynamic>?participants;
  List<dynamic>?participants1;
  List<dynamic>? age;
  List<dynamic>? gender;
  EventData({this.BigS,this.youtube,this.puja,this.participants1,this.total_days,this.top3,this.image,this.name,this.age,this.gender,this.note,this.status,this.place,this.duration,this.about,this.terms,this.participants});
}


class Registration_Form extends StatefulWidget{
  @override
  _Registration_FormState createState() => _Registration_FormState();
}
enum AppState {
  free,
  picked,
  cropped,
}

class _Registration_FormState extends State<Registration_Form> {
  final RegistraionField registerForm = Get.put(RegistraionField());
  late AppState appstate;
  File? SelectImageFile;
  File? imageFile;

  List<XFile>? _imageFileList;
  final LoadController loadController = Get.put(LoadController());


  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }
  String? name;
  String? state='Select State';
  String? district = 'Select District';
  dynamic _pickImageError;

  String? _retrieveDataError;
  var uuid = Uuid();
  String? photoUrl;
  XFile ? ImageFile;
  final ImagePicker _picker = ImagePicker();
  uploadImage(BuildContext context)async{

    //File image_file = File(_imageFileList![0].path);





    final   firebase_storage.Reference firebaseStorage = firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child("eventimages").
    child('${uuid.v1()}.jpg');
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpg',
        customMetadata: {'picked-file-path': imageFile!.path});
    if(kIsWeb){
      firebase_storage.UploadTask task = firebaseStorage.putData(await imageFile!.readAsBytes(),metadata);
      var dowurl = await (await task.whenComplete(() {print("url downloaded");})).ref.getDownloadURL();
      String url = dowurl.toString();
      task.then((value)async{
        setState(() {
          photoUrl=url;
        });
      });
    }
    firebase_storage.UploadTask task = firebaseStorage.putFile(imageFile!,metadata);
    var dowurl = await (await task.whenComplete(() => print("Task Completed"))).ref.getDownloadURL();
    String url = dowurl.toString();
    task.then((value)async{
      setState(() {
        photoUrl=url;
      });
    });

  }

  String? _chosenValue;
  String? _chosenValueG;
  final EventController  eventController= Get.put(EventController());
  final AuthController authController = Get.put(AuthController());
  
  
  // Future<Null> _cropImage() async {
  //   File? croppedFile = await ImageCropper.cropImage(
  //       sourcePath: SelectImageFile!.path,
  //       aspectRatioPresets: Platform.isAndroid
  //       ? [
  //       CropAspectRatioPreset.square,

  //       ]
  //       : [

  //       CropAspectRatioPreset.square,

  //       ],
  //       androidUiSettings: AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: Color(0xff181c2c),
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       iosUiSettings: IOSUiSettings(
  //         title: 'Cropper',
  //       ));
  //   if (croppedFile != null) {
  //     imageFile = croppedFile;
  //       Get.back();
  //     setState(() {
  //       appstate = AppState.cropped;
  //     });
  //   }
  // }
  Future<Null> _pickImage(BuildContext context) async {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final pickedImage =
    await ImagePicker().getImage(source: ImageSource.gallery);
    SelectImageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (SelectImageFile != null) {
     Get.bottomSheet(
       Container(
         padding: EdgeInsets.all(20),
         child: Row(
           children: [
             SizedBox(
               width: width*0.8,
               child: Image.file(SelectImageFile!),
             ),
             Spacer(),
             Column(
               children: [
                 InkWell(
                     onTap: (){
                     //  _cropImage();
                     },
                     child: CircleAvatar(child: Icon(Icons.done ,size: 16,),backgroundColor:Colors.white,)),
                 SizedBox(height: 50,),
                 CircleAvatar(child: Icon(Icons.close,size: 16,),backgroundColor:Colors.white,)
               ],
             )
           ],
         ),
       )
     );
    }
  }
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height*0.1,
            child: Padding(
              padding: const EdgeInsets.only(left:20.0,top:25),
              child: Align(
                alignment : Alignment.topLeft,
                child: Container(
                  height:35,width:35,
                  padding :  EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Color(0xff181c2c),
                      shape: BoxShape.circle
                  ),
                  child: IconButton(
                    onPressed: (){
                      Get.back();
                    },
                    icon: Icon(Icons.close,size: 12,color: Colors.white,),
                  ),
                ),
              ),
            ),
            ),
            Form(
                key:registerForm.loginFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: EdgeInsets.only(left: width*0.08,right: width*0.08,top: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          imageFile != null ?InkWell(
                            onTap: ()async{
                             _pickImage(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height*0.3,
                              width: width*0.5,
                              decoration: BoxDecoration(
                                 // color: context.theme.backgroundColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(color: LightColors.shadowColor,blurRadius: 20)
                                  ]
                              ),
                              child: Image.file(imageFile!),
                            ),
                          ): InkWell(
                            onTap: ()async{
                             _pickImage(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height*0.25,
                              width: width*0.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(color: LightColors.shadowColor,blurRadius: 20)
                                  ]
                              ),
                              child: Text1(data: "Pick Image", max: 12, min: 11),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                       // margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left:20),
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0),
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0))),
                        child: TextFormField(
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Montserrat',
                              fontSize: 14.0),
                        onChanged: (value){
                            name = value;
                        },
                          maxLength: 10,
                          decoration: InputDecoration(

                              border: InputBorder.none,
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Montserrat',
                                  fontSize: 14.0),
                              contentPadding: EdgeInsets.only(top: 10.0),
                              ),


                        ),

                      ),

                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Row(
                         children: [
                           Obx((){
                             return  DropdownButton<String>(
                               focusColor:Colors.white,
                               value: _chosenValue,
                               //elevation: 5,
                               style: TextStyle(color: Colors.white),
                               iconEnabledColor:Colors.grey,
                               items: eventController.eventData.value.age!.cast<String>().map<DropdownMenuItem<String>>((String value) {
                                 return DropdownMenuItem<String>(
                                   value: value,
                                   child: Text(value,style:TextStyle(color:Colors.grey),),
                                 );
                               }).toList(),
                               hint:Text(
                                 "Age",
                                 style: TextStyle(
                                     color: Colors.grey,
                                     fontSize: 14,
                                     fontWeight: FontWeight.w500),
                               ),
                               onChanged: (String? value) {
                                 setState(() {
                                   _chosenValue = value;
                                 });
                               },
                             );
                           }),
                           Spacer(),
                           Obx((){
                             return  DropdownButton<String>(
                               focusColor:Colors.white,
                               value: _chosenValueG,
                               //elevation: 5,
                               style: TextStyle(color: Colors.white),
                               iconEnabledColor:Colors.grey,
                               items: eventController.eventData.value.gender!.cast<String>().map<DropdownMenuItem<String>>((String value) {
                                 return DropdownMenuItem<String>(
                                   value: value,
                                   child: Text(value,style:TextStyle(color:Colors.grey),),
                                 );
                               }).toList(),
                               hint:Text(
                                 "Gender",
                                 style: TextStyle(
                                     color: Colors.grey,
                                     fontSize: 14,
                                     fontWeight: FontWeight.w500),
                               ),
                               onChanged: (String? value) {
                                 setState(() {
                                   _chosenValueG = value;
                                 });
                               },
                             );
                           }),
                         ],
                       ),
                     ),

                      Obx((){
                        return loadController.load.value.active?SizedBox(height: 50,width: 50,child: Loader(),):ElevatedButton(onPressed: ()async{

                          registerForm.checkLogin();
                          if(eventController.eventData.value.price==0){
                            if(name==null || imageFile ==null || _chosenValue==null || _chosenValueG ==null){
                              return Get.snackbar("Info", "Please fill all fields properly",backgroundColor: Colors.white);
                            }
                            else{
                              loadController.updateLoad();
                              uploadImage(context);
                              Future.delayed(Duration(seconds: 10),
                                      ()async{
                                    await FirebaseFirestore.instance.doc("PujaPurohitFiles/events/${eventController.eventData.value.name}/${authController.user!.uid}").set({
                                      'name': "$name",
                                      'age':_chosenValue,
                                      'votes':0,
                                      'voters':FieldValue.arrayUnion([]),
                                      'image':'$photoUrl',
                                      'vote':false,
                                      'gender':_chosenValueG,
                                      'event':'${eventController.eventData.value.name}',
                                      'num':FieldValue.increment(eventController.eventData.value.participants1!.length+1),
                                      'id':authController.user!.uid,
                                      'puja':'${eventController.eventData.value.name}'
                                    }).whenComplete(() async{
                                      List<dynamic> total_V= eventController.eventData.value.participants1!;
                                      eventController.eventData.value.participants1!.add(authController.user!.uid);
                                      await FirebaseFirestore.instance.doc('/PujaPurohitFiles/events').update(({
                                        '${eventController.eventData.value.name}P':total_V
                                      }));
                                      Get.back();
                                      loadController.updateLoad();
                                    });
                                  }
                              );

                            }
                          }
                          else{
                            if(name==null || imageFile ==null || _chosenValue==null || _chosenValueG ==null){
                              return Get.snackbar("Info", "Please fill all fields properly",backgroundColor: Colors.white);
                            }
                            else{
                              loadController.updateLoad();
                              
                            }
                          }
                        }, child: Text1(data: "Register", max: 20, min: 18,weight: FontWeight.w300,),style: ElevatedButton.styleFrom(
                            primary: Color(0xff181c2c),
                            shape: StadiumBorder()
                        ),);

                      }),
                      SizedBox(height: height*0.2,)
                    ],
                  ),
                )),
        SizedBox(height: 10,),
            Text1(data: "Note :", max: 24, min: 20,clr: Colors.black54,weight: FontWeight.w600,),
            SizedBox(height: 10,),
            Obx((){
              return Text1(data: "${eventController.eventData.value.note}", max: 16, min: 12,clr: Colors.black54,);
            })
          ],
        ),
      ),
    );
  }
}

class RegistraionField extends GetxController{
  final GlobalKey<FormState>loginFormKey=GlobalKey<FormState>();
  late TextEditingController passwordController;
  late TextEditingController emailContrller;
  late TextEditingController shopNameController;
  late TextEditingController addressController;
  late TextEditingController otpController;
  var email='';
  var password ='';
  var shopName='';
  var address='';



  @override
  void onInit(){
    super.onInit();
    passwordController=TextEditingController();
    emailContrller=TextEditingController();
    shopNameController=TextEditingController();
    addressController=TextEditingController();
    otpController=TextEditingController();
  }

  @override
  void onClose(){
    passwordController.dispose();
    emailContrller.dispose();
    shopNameController.dispose();
    addressController.dispose();
    otpController.dispose();
  }
  String? validatePassword(String value){
    if(value.length<6){
      return "Not valid phoneNumber";
    }
    return null;
  }
  String? validateemail(String value){
    if(!GetUtils.isEmail(value)){
      return "Not valid email";
    }
  }
  String? validataddress(String value){
    if(value.length<5){
      return "Not valid address";
    }
  }
  String? validatename(String value){
    if(value.length>15 && value.length<1){
      return "Enter Shopname in less than 15 letter's";
    }
  }
  void checkLogin(){
    final isValid=loginFormKey.currentState!.validate();
    if(!isValid){
      return ;
    }
    loginFormKey.currentState!.save();
  }
}

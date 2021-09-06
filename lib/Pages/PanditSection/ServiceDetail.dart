import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/SignIn/AuthController.dart';
import 'package:pujapurohit/Widgets/Loader.dart';
import 'package:pujapurohit/Widgets/Texts.dart';
import 'package:pujapurohit/Widgets/reviews.dart';
import 'package:pujapurohit/controller/CommonController.dart';


import 'Controllers/serviceTop.dart';
import 'Profile.dart';
import 'Widgets/ImageView.dart';

class ServiceDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    double height= MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String panditid= Get.parameters['pid']!;
    String serviceid= Get.parameters['sid']!;
    final CommonController commonController = Get.put(CommonController());
    return Scaffold(
      appBar:  AppBar(
        elevation:0.0,
        backgroundColor:Colors.transparent,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: ()=>Get.back(),
            child: Icon(Icons.arrow_back_ios,color: Colors.grey,size: 18,)),
        actions: [

          Icon(CupertinoIcons.heart,color: Colors.grey,),
          SizedBox(width:15),
        ],
      ),
      body: GetX<ServiceDetailController>(
        init: Get.put<ServiceDetailController>(ServiceDetailController(uid:panditid,sid:serviceid)),
        builder: (ServiceDetailController serviceDetailController){
          if(serviceDetailController.userModel.value.image == null){
            return Center(child: Loader(),);
          }
          var swastik = serviceDetailController.userModel.value.swastik;
          int? rates = serviceDetailController.userModel.value.raters;
          double? overall_rate=swastik!/rates!;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text1(data: "${serviceDetailController.userModel.value.service}", max: 18, min: 16,weight: FontWeight.bold),
                                  SizedBox(height:5),
                                  Text1(data: "by : ${Get.parameters['pandit']}", max: 11, min: 10,),
                                  SizedBox(height:5),
                                  Text1(data: "Pujan Vidhi", max: 11, min: 10,),
                                  SizedBox(height:5),
                                  Text1(data: "Samagri Detail", max: 11, min: 10,),
                                ]
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 80,width: 80,
                                  decoration: BoxDecoration(
                                      boxShadow: [BoxShadow(color: Colors.white,blurRadius: 20)],
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage('${serviceDetailController.userModel.value.image}'),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height:15),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 2.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child:MiniBox(icon: true, FirstText: "${swastik<=0?0.0:overall_rate!.toStringAsFixed(1)}", SecondText: "${serviceDetailController.userModel.value.raters} ratings",iconData: CupertinoIcons.star,)),
                            Expanded(
                                flex: 2,
                                child: MiniBox(icon: true, FirstText: "${serviceDetailController.userModel.value.time}", SecondText: "Duration",iconData: Icons.watch_later_outlined,)),
                            Expanded(
                                flex: 2,
                                child: MiniBox(icon: true, FirstText: "${serviceDetailController.userModel.value.subscriber}", SecondText: "Served",iconData: Icons.work,)),
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                    onTap: (){
                                      Get.bottomSheet(
                                          Container(
                                              color: Colors.white,
                                              child: Reviews(pandit: false, uid: Get.parameters['pid']!, ServiceId: serviceDetailController.userModel.value.serviceId!,swastik: double.parse("${serviceDetailController.userModel.value.swastik}"),reviewers: serviceDetailController.userModel.value.reviewers,raters:serviceDetailController.userModel.value.raters,)
                                          ),
                                          enableDrag: false
                                      );
                                    },
                                    child: MiniBox(icon: true, SecondText: "Reviews", FirstText: "${serviceDetailController.userModel.value.reviewers}",iconData: Icons.reviews,))),


                          ],
                        ),
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 2.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      SizedBox(height: 10,),
                      Text1(data: "Benefit ***Claimed by Purohit***", max: 12, min: 11,clr: Colors.grey,weight: FontWeight.bold,),
                      SizedBox(height: 5,),
                      Text1(data: "${serviceDetailController.userModel.value.benefit}", max: 12, min: 11,clr:Colors.grey),
                      SizedBox(height: 10,),
                      Text1(data: "Additional Detail", max: 12, min: 11,clr:Colors.grey,weight: FontWeight.bold,),
                      SizedBox(height: 5,),
                      Text1(data: "${serviceDetailController.userModel.value.detail}", max: 12, min: 11,clr:Colors.grey),
                      SizedBox(height:15),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 2.0,
                        dashLength: 5.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 0.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      SizedBox(height:15),
                      Text1(data: "Note:\nWe are commited to provide transparency between our purohits and yajman.\nLearn how to book :- ", max: 12, min: 11,clr:Colors.grey,),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child:MiniBox(icon: true, FirstText: "Learn", SecondText: "Written Steps",iconData: CupertinoIcons.book,)),
                            Expanded(
                                flex: 1,
                                child: MiniBox(icon: true, FirstText: "Watch", SecondText: "Explained Video",iconData: Icons.tv,)),
                          ],
                        ),
                      ),
                      SizedBox(height: 100,)


                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: (){
                        String keyword=serviceDetailController.userModel.value.keyword.toString().substring(1);
                        print(keyword);
                       if(authController.user==null){
                         Get.toNamed('/account');
                         Get.snackbar("Login", "Please Login to proceed booking",backgroundColor: Colors.white,padding: EdgeInsets.all(20),colorText: Colors.grey,duration:Duration(seconds: 3));

                       }
                       else{
                         FareBreakup farebreakup = Get.put(FareBreakup());
                         farebreakup.service(serviceDetailController.userModel.value.price,serviceDetailController.userModel.value.serviceId!,serviceDetailController.userModel.value.service!,serviceDetailController.userModel.value.image!,serviceDetailController.userModel.value.np!);
                         Get.toNamed("/address?keyword=$keyword");
                       }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height*0.08,
                        width: width*0.5,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text1(data: "Proceed Booking", max: 14, min: 12,clr: Colors.white,weight: FontWeight.w600,),
                      ),
                    )
                )
              ],
            ),
          );
        },
      ),
    );
  }

}
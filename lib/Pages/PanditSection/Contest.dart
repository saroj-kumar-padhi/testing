import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pujapurohit/SignIn/AuthController.dart';
import 'package:pujapurohit/SignIn/Update.dart';
import 'package:pujapurohit/Widgets/Loader.dart';
import 'package:pujapurohit/Widgets/Texts.dart';
import 'package:pujapurohit/Widgets/YoutubePlayer.dart';
import 'package:pujapurohit/Widgets/bottombar.dart';
import 'package:pujapurohit/colors/light_colors.dart';
import 'package:url_launcher/link.dart';
import 'package:video_player/video_player.dart';
import 'Account.dart';
import 'PanditHome.dart';
import 'Widgets/responsive.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class DetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var ScreenSize = MediaQuery.of(context).size;
    String? id = Get.parameters['id'];
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          ScreenSize.width,
          height * 0.099,
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          width: width,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('/home');
                      },
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fill,
                        height: 60,
                        width: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                        height: height * 0.4,
                        child: InkWell(
                            onTap: () {
                              Get.to(Account());
                              //Get.toNamed('/account');
                              // Get.snackbar("Login", "Please login to avail location change feature",backgroundColor: Colors.white,padding: EdgeInsets.all(20),colorText: Colors.grey,duration:Duration(seconds: 3));
                            },
                            child: Container(
                              width: width * 0.4,
                              child: Row(
                                children: [
                                  //  ResponsiveWidget.isSmallScreen(context)?Expanded(child: Text1(max: 9, data: "${locationController.location.value.address}", min: 8, clr: Colors.black54,)):Text1(max: 9, data: "${locationController.location.value.address}", min: 8, clr: Colors.black54,),
                                  //SizedBox(width:5),
                                  Text1(
                                      max: 12,
                                      data: "India",
                                      min: 11,
                                      weight: FontWeight.bold,
                                      clr: Colors.black),
                                  SizedBox(width: 5),
                                  Icon(Icons.home,
                                      color: LightColors.kDarkYellow, size: 12)
                                ],
                              ),
                            ))),
                    SizedBox(width: 10),
                  ],
                ),
                ResponsiveWidget.isSmallScreen(context)
                    ? Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            LineIcons.search,
                            size: 18,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            icon: Icon(
                              LineIcons.user,
                              color: Colors.black54,
                              size: 18,
                            ),
                            onPressed: () {
                              //  Get.toNamed('/account');
                              Get.to(Account());
                            },
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          ModifiedTextIcon(
                            iconColor: Colors.black54,
                            icondata: LineIcons.search,
                            max: 12,
                            data: 'Search',
                            min: 8,
                            color: Colors.black54,
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                              onTap: () {
                                // Get.toNamed('/account');
                                Get.to(Account());
                              },
                              child: Obx(
                                () => ModifiedTextIcon(
                                    iconColor: Colors.black54,
                                    icondata: LineIcons.user,
                                    max: 12,
                                    data: authController.user != null
                                        ? '${authController.user!.displayName}'
                                        : 'Sign In',
                                    min: 8,
                                    color: Colors.black54,
                                    weight: FontWeight.bold),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          ModifiedTextIcon(
                              iconColor: Colors.black54,
                              icondata: LineIcons.shoppingBag,
                              max: 12,
                              data: 'Cart',
                              min: 8,
                              color: Colors.black54,
                              weight: FontWeight.bold),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .doc('PujaPurohitFiles/contest/Participants/$id')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loader();
            }
            List<dynamic> voters = snapshot.data!.get('voters');
            return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .doc('PujaPurohitFiles/contest')
                    .snapshots(),
                builder: (context, bsnapshot) {
                  if (bsnapshot.data == null) {
                    return Loader();
                  }
                  List<dynamic> total_voters =
                      bsnapshot.data!.get('totalvoters');
                  return Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            color: Color(0xff5a56c6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text1(
                                    data:
                                        "Total Votes: ${snapshot.data!.get('voters').length}",
                                    max: 26,
                                    min: 24,
                                    weight: FontWeight.w800,
                                    clr: Colors.white),
                                SizedBox(
                                  height: 20,
                                ),
                                Text1(
                                  data: "Name: ${snapshot.data!.get('name')}",
                                  max: 14,
                                  min: 12,
                                  weight: FontWeight.bold,
                                  clr: Colors.white,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(height: 10),
                                Text1(
                                    data: "Age : ${snapshot.data!.get('age')}",
                                    max: 12,
                                    min: 12,
                                    clr: Colors.white),
                                SizedBox(
                                  height: 20,
                                ),
                                bsnapshot.data!.get('live')
                                    ? authController.user == null
                                        ? InkWell(
                                            onTap: () {
                                              Get.to(Account());
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 40,
                                                  margin: EdgeInsets.only(
                                                      bottom: 5),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 15,
                                                            color: Color(
                                                                0xff5a56c6))
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.arrow_upward,
                                                          color:
                                                              Color(0xff5a56c6),
                                                          size: 16,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text1(
                                                            data: "Upvote",
                                                            max: 12,
                                                            min: 11)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : authController.user!.displayName ==
                                                null
                                            ? InkWell(
                                                onTap: () {
                                                  Get.to(Update());
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      margin: EdgeInsets.only(
                                                          bottom: 5),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurRadius: 15,
                                                                color: Color(
                                                                    0xff5a56c6))
                                                          ]),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .arrow_upward,
                                                              color: Color(
                                                                  0xff5a56c6),
                                                              size: 16,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text1(
                                                                data: "Upvote",
                                                                max: 12,
                                                                min: 11)
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : voters.contains(
                                                    authController.user!.uid)
                                                ? InkWell(
                                                    onTap: () {
                                                      List<dynamic> total_V =
                                                          total_voters;
                                                      total_voters.contains(
                                                              '${authController.user!.uid}')
                                                          ? total_voters.remove(
                                                              authController
                                                                  .user!.uid)
                                                          : () {};
                                                      List<dynamic> newlist =
                                                          voters;
                                                      voters.remove(
                                                          authController
                                                              .user!.uid);
                                                      FirebaseFirestore.instance
                                                          .doc(
                                                              'PujaPurohitFiles/contest/Participants/$id')
                                                          .update({
                                                        'voters': newlist,
                                                        'votes': FieldValue
                                                            .increment(-1)
                                                      });
                                                      FirebaseFirestore.instance
                                                          .doc(
                                                              'PujaPurohitFiles/contest')
                                                          .update({
                                                        'totalvoters': total_V
                                                      });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 5),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xff5a56c6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            // boxShadow: [
                                                            //   BoxShadow(
                                                            //     blurRadius: 15,
                                                            //     color: Color(0xff5a56c6)
                                                            //   )
                                                            //]
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .arrow_upward,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 16,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text1(
                                                                  data:
                                                                      "Upvoted",
                                                                  max: 12,
                                                                  min: 11,
                                                                  clr: Colors
                                                                      .white,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      if (total_voters.contains(
                                                          authController
                                                              .user!.uid)) {
                                                        Get.defaultDialog(
                                                            title:
                                                                "Voted Sucesfully",
                                                            middleText:
                                                                "You have alreadey voted");
                                                      } else {
                                                        List<dynamic> total_V =
                                                            total_voters;
                                                        total_voters.contains(
                                                                '${authController.user!.uid}')
                                                            ? () {}
                                                            : total_voters.add(
                                                                authController
                                                                    .user!.uid);
                                                        List<dynamic> newlist =
                                                            voters;
                                                        voters.add(
                                                            authController
                                                                .user!.uid);
                                                        FirebaseFirestore
                                                            .instance
                                                            .doc(
                                                                'PujaPurohitFiles/contest/Participants/${id}')
                                                            .update({
                                                          'voters': newlist,
                                                          'votes': FieldValue
                                                              .increment(1)
                                                        });
                                                        FirebaseFirestore
                                                            .instance
                                                            .doc(
                                                                'PujaPurohitFiles/contest')
                                                            .update({
                                                          'totalvoters': total_V
                                                        });
                                                      }
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 5),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    blurRadius:
                                                                        15,
                                                                    color: Color(
                                                                        0xff5a56c6))
                                                              ]),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .arrow_upward,
                                                                  color: Color(
                                                                      0xff5a56c6),
                                                                  size: 16,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text1(
                                                                    data:
                                                                        "Upvote",
                                                                    max: 12,
                                                                    min: 11)
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                    : SizedBox(),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child:
                              Image.network('${snapshot.data!.get('image')}')),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                Text1(data: "Total Voters", max: 12, min: 11),
                                SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 400,
                                      width: 400,
                                      
                                      child: ListView.separated(
                                        separatorBuilder: (_, index) =>
                                            Container(
                                                margin: EdgeInsets.all(10)),
                                        itemBuilder: (_, index) {
                                          
                                          return StreamBuilder<
                                                  DocumentSnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .doc("users/${voters[index]}")
                                                  .snapshots(),
                                              builder: (context, snapshotshru) {
                                                if (snapshotshru.data == null) {
                                                  return Center(
                                                    child:
                                                        Text("Loading...."),
                                                  );
                                                }
                                                String ph=snapshotshru.data!.get("phone");
                                                return Container(
                                                  child: Row(
                                                    children: [
                                                     
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Text1(
                                                            data: "${ph.substring(0,5)+"XXXX"+ph.substring(9,13)}",
                                                            max: 13,
                                                            min: 10),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        itemCount: voters.length,
                                      ),
                                    ))
                              ],
                            ),
                          ))
                    ],
                  );
                });
          }),
    );
  }
}

class Contest extends StatefulWidget {
  @override
  _ContestState createState() => _ContestState();
}

class _ContestState extends State<Contest> {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          ScreenSize.width,
          height * 0.099,
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          width: width,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('/home');
                      },
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fill,
                        height: 60,
                        width: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                        height: height * 0.4,
                        child: InkWell(
                            onTap: () {
                              Get.to(Account());
                              //Get.toNamed('/account');
                              // Get.snackbar("Login", "Please login to avail location change feature",backgroundColor: Colors.white,padding: EdgeInsets.all(20),colorText: Colors.grey,duration:Duration(seconds: 3));
                            },
                            child: Container(
                              width: width * 0.4,
                              child: Row(
                                children: [
                                  //  ResponsiveWidget.isSmallScreen(context)?Expanded(child: Text1(max: 9, data: "${locationController.location.value.address}", min: 8, clr: Colors.black54,)):Text1(max: 9, data: "${locationController.location.value.address}", min: 8, clr: Colors.black54,),
                                  //SizedBox(width:5),
                                  Text1(
                                      max: 12,
                                      data: "India",
                                      min: 11,
                                      weight: FontWeight.bold,
                                      clr: Colors.black),
                                  SizedBox(width: 5),
                                  Icon(Icons.home,
                                      color: LightColors.kDarkYellow, size: 12)
                                ],
                              ),
                            ))),
                    SizedBox(width: 10),
                  ],
                ),
                ResponsiveWidget.isSmallScreen(context)
                    ? Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            LineIcons.search,
                            size: 18,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            icon: Icon(
                              LineIcons.user,
                              color: Colors.black54,
                              size: 18,
                            ),
                            onPressed: () {
                              //  Get.toNamed('/account');
                              Get.to(Account());
                            },
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          ModifiedTextIcon(
                            iconColor: Colors.black54,
                            icondata: LineIcons.search,
                            max: 12,
                            data: 'Search',
                            min: 8,
                            color: Colors.black54,
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                              onTap: () {
                                // Get.toNamed('/account');
                                Get.to(Account());
                              },
                              child: Obx(
                                () => ModifiedTextIcon(
                                    iconColor: Colors.black54,
                                    icondata: LineIcons.user,
                                    max: 12,
                                    data: authController.user != null
                                        ? '${authController.user!.displayName}'
                                        : 'Sign In',
                                    min: 8,
                                    color: Colors.black54,
                                    weight: FontWeight.bold),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          ModifiedTextIcon(
                              iconColor: Colors.black54,
                              icondata: LineIcons.shoppingBag,
                              max: 12,
                              data: 'Cart',
                              min: 8,
                              color: Colors.black54,
                              weight: FontWeight.bold),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .doc('PujaPurohitFiles/contest')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Loader();
              }
              dynamic contestData = snapshot.data!.get('contestData');
              Timestamp registraionEnd = contestData['registration'];
              int endTime = registraionEnd.toDate().millisecondsSinceEpoch +
                  Duration(minutes: 1).inMilliseconds;
              void onEnd() {
                FirebaseFirestore.instance
                    .doc('PujaPurohitFiles/contest')
                    .update({'live': true});
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: height * 1.1,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff5a56c6), Color(0xff9476ef)])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ResponsiveWidget.isSmallScreen(context)
                              ? Column(
                                  children: [
                                    TopTxt(
                                        context,
                                        onEnd,
                                        endTime,
                                        contestData['sentense'],
                                        snapshot.data!.get('live'),
                                        snapshot.data!.get('registration'),
                                        snapshot.data!.get('participants'),
                                        snapshot.data!.get('plist')),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/Landing%20Page%2Fjanastami.png?alt=media&token=7f228a4d-2f63-4e4b-8cf1-55d8d06c56e6',
                                          height: height * 0.25,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.2),
                                        child: Column(
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(),
                                                padding: EdgeInsets.only(
                                                    left: ResponsiveWidget
                                                            .isSmallScreen(
                                                                context)
                                                        ? width * 0.1
                                                        : ResponsiveWidget
                                                                .isMediumScreen(
                                                                    context)
                                                            ? width * 0.12
                                                            : width * 0.15),
                                                child: TopTxt(
                                                    context,
                                                    onEnd,
                                                    endTime,
                                                    contestData['sentense'],
                                                    snapshot.data!.get('live'),
                                                    snapshot.data!
                                                        .get('registration'),
                                                    snapshot.data!
                                                        .get('participants'),
                                                    snapshot.data!
                                                        .get('plist'))),
                                          ],
                                        ),
                                      ),
                                      flex: 3,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.2),
                                        child: Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/Landing%20Page%2Fjanastami.png?alt=media&token=7f228a4d-2f63-4e4b-8cf1-55d8d06c56e6',
                                          height: height * 0.5,
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  snapshot.data!.get('video')
                      ? Container(
                          alignment: Alignment.center,
                          width: ResponsiveWidget.isSmallScreen(context)
                              ? width * 0.6
                              : width * 0.5,
                          height: ResponsiveWidget.isSmallScreen(context)
                              ? height * 0.3
                              : ResponsiveWidget.isMediumScreen(context)
                                  ? height * 0.5
                                  : height * 0.55,
                          child:
                              YoutubeAppDemo(id: snapshot.data!.get('videoId')),
                        )
                      : SizedBox(),
                  snapshot.data!.get('live')
                      ? Text(
                          'Top 3',
                          style: TextStyle(
                              fontSize: ResponsiveWidget.isLargeScreen(context)
                                  ? 45
                                  : 32,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  snapshot.data!.get('live')
                      ? StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection(
                                  'PujaPurohitFiles/contest/Participants')
                              .orderBy("votes")
                              .snapshots(),
                          builder: (context, datasnapshot) {
                            if (datasnapshot.data == null) {
                              return Loader();
                            }

                            // return Padding(
                            //   padding: EdgeInsets.only(left:width*0.1,right: width*0.1),
                            //   child: ResponsiveWidget.isSmallScreen(context)?
                            //   Column(
                            //    children:[
                            //       SecondCard(snapshot.data!.get('live'),snapshot.data!.get('totalvoters'),authController.user!=null?authController.user!.uid:null,context,width, height,datasnapshot.data!.docs[1].get('image'),datasnapshot.data!.docs[1].get('name'),datasnapshot.data!.docs[1].get('voters'),datasnapshot.data!.docs[1].get('id')),
                            //       SizedBox(height:25),
                            //          FirstCard(snapshot.data!.get('live'),snapshot.data!.get('totalvoters'),authController.user!=null?authController.user!.uid:null,context,width, height,datasnapshot.data!.docs[2].get('image'),datasnapshot.data!.docs[2].get('name'),datasnapshot.data!.docs[2].get('voters'),datasnapshot.data!.docs[2].get('id')),
                            //          SizedBox(height:25),
                            //          ThirdCard(snapshot.data!.get('live'),snapshot.data!.get('totalvoters'),authController.user!=null?authController.user!.uid:null,context,width, height,datasnapshot.data!.docs[0].get('image'),datasnapshot.data!.docs[0].get('name'),datasnapshot.data!.docs[0].get('voters'),datasnapshot.data!.docs[0].get('id')),
                            //    ]
                            //   ): Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       SecondCard(snapshot.data!.get('live'),snapshot.data!.get('totalvoters'),authController.user!=null?authController.user!.uid:null,context,width, height,datasnapshot.data!.docs[1].get('image'),datasnapshot.data!.docs[1].get('name'),datasnapshot.data!.docs[1].get('voters'),datasnapshot.data!.docs[1].get('id')),
                            //          FirstCard(snapshot.data!.get('live'),snapshot.data!.get('totalvoters'),authController.user!=null?authController.user!.uid:null,context,width, height,datasnapshot.data!.docs[0].get('image'),datasnapshot.data!.docs[0].get('name'),datasnapshot.data!.docs[0].get('voters'),datasnapshot.data!.docs[0].get('id')),
                            //          ThirdCard(snapshot.data!.get('live'),snapshot.data!.get('totalvoters'),authController.user!=null?authController.user!.uid:null,context,width, height,datasnapshot.data!.docs[2].get('image'),datasnapshot.data!.docs[2].get('name'),datasnapshot.data!.docs[2].get('voters'),datasnapshot.data!.docs[2].get('id')),
                            //     ],
                            //   ),
                            // );
                            int len = datasnapshot.data!.docs.length - 1;
                            return SizedBox(
                              height: height * 0.3,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (_, index) {
                                    if (index == 1 ||
                                        index == 0 ||
                                        index == 2) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SecondCard(
                                              snapshot.data!.get('live'),
                                              snapshot.data!.get('totalvoters'),
                                              authController.user != null
                                                  ? authController.user!.uid
                                                  : null,
                                              context,
                                              width,
                                              height,
                                              datasnapshot.data!.docs[len - 1]
                                                  .get('image'),
                                              datasnapshot.data!.docs[len - 1]
                                                  .get('name'),
                                              datasnapshot.data!.docs[len - 1]
                                                  .get('voters'),
                                              datasnapshot.data!.docs[len - 1]
                                                  .get('id')),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          FirstCard(
                                              snapshot.data!.get('live'),
                                              snapshot.data!.get('totalvoters'),
                                              authController.user != null
                                                  ? authController.user!.uid
                                                  : null,
                                              context,
                                              width,
                                              height,
                                              datasnapshot.data!.docs[len - 0]
                                                  .get('image'),
                                              datasnapshot.data!.docs[len - 0]
                                                  .get('name'),
                                              datasnapshot.data!.docs[len - 0]
                                                  .get('voters'),
                                              datasnapshot.data!.docs[len - 0]
                                                  .get('id')),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          ThirdCard(
                                              snapshot.data!.get('live'),
                                              snapshot.data!.get('totalvoters'),
                                              authController.user != null
                                                  ? authController.user!.uid
                                                  : null,
                                              context,
                                              width,
                                              height,
                                              datasnapshot.data!.docs[len - 2]
                                                  .get('image'),
                                              datasnapshot.data!.docs[len - 2]
                                                  .get('name'),
                                              datasnapshot.data!.docs[len - 2]
                                                  .get('voters'),
                                              datasnapshot.data!.docs[len - 2]
                                                  .get('id'))
                                        ],
                                      );
                                    }

                                    return SizedBox();
                                  }),
                            );
                          })
                      : SizedBox(),
                  snapshot.data!.get('live')
                      ? SizedBox(height: 50)
                      : SizedBox(),
                  snapshot.data!.get('registration')
                      ? Text(
                          'All Participants',
                          style: TextStyle(
                              fontSize: ResponsiveWidget.isLargeScreen(context)
                                  ? 45
                                  : 32,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54),
                        )
                      : SizedBox(),
                  snapshot.data!.get('registration')
                      ? SizedBox(
                          height: 50,
                        )
                      : SizedBox(),
                  snapshot.data!.get('registration')
                      ? StreamBuilder<QuerySnapshot>(
                          stream: snapshot.data!.get('live')
                              ? FirebaseFirestore.instance
                                  .collection(
                                      'PujaPurohitFiles/contest/Participants')
                                  .orderBy("votes")
                                  .snapshots()
                              : FirebaseFirestore.instance
                                  .collection(
                                      'PujaPurohitFiles/contest/Participants')
                                  .orderBy("num")
                                  .snapshots(),
                          builder: (context, datasnapshot) {
                            if (datasnapshot.data == null) {
                              return Loader();
                            }
                            if (snapshot.hasError) {
                              print("has errorr");
                            }
                            int len = datasnapshot.data!.docs.length - 1;
                            return ResponsiveWidget.isSmallScreen(context)
                                ? ListView.builder(
                                    reverse: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: datasnapshot.data!.docs.length,
                                    itemBuilder: (_, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                ResponsiveWidget.isSmallScreen(
                                                        context)
                                                    ? 10
                                                    : width * 0.15,
                                            right:
                                                ResponsiveWidget.isSmallScreen(
                                                        context)
                                                    ? 10
                                                    : width * 0.15,
                                            bottom: 10),
                                        child: OtherCards(
                                            snapshot.data!.get('live'),
                                            snapshot.data!.get('totalvoters'),
                                            authController.user != null
                                                ? authController.user!.uid
                                                : null,
                                            context,
                                            width,
                                            height,
                                            datasnapshot.data!.docs[index]
                                                .get('image'),
                                            datasnapshot.data!.docs[index]
                                                .get('name'),
                                            datasnapshot.data!.docs[index]
                                                .get('voters'),
                                            datasnapshot.data!.docs[index]
                                                .get('id')),
                                      );
                                    })
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              ResponsiveWidget.isMediumScreen(
                                                      context)
                                                  ? 3
                                                  : 5,
                                          crossAxisSpacing:
                                              ResponsiveWidget.isMediumScreen(
                                                      context)
                                                  ? 20
                                                  : 30,
                                          mainAxisSpacing:
                                              ResponsiveWidget.isMediumScreen(
                                                      context)
                                                  ? 20
                                                  : 30,
                                        ),
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            datasnapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return snapshot.data!.get('live')
                                              ? OtherCards(
                                                  snapshot.data!.get('live'),
                                                  snapshot.data!
                                                      .get('totalvoters'),
                                                  authController.user != null
                                                      ? authController.user!.uid
                                                      : null,
                                                  context,
                                                  width,
                                                  height,
                                                  datasnapshot
                                                      .data!.docs[len - index]
                                                      .get('image'),
                                                  datasnapshot
                                                      .data!.docs[len - index]
                                                      .get('name'),
                                                  datasnapshot
                                                      .data!.docs[len - index]
                                                      .get('voters'),
                                                  datasnapshot
                                                      .data!.docs[len - index]
                                                      .get('id'))
                                              : OtherCards(
                                                  snapshot.data!.get('live'),
                                                  snapshot.data!
                                                      .get('totalvoters'),
                                                  authController.user != null
                                                      ? authController.user!.uid
                                                      : null,
                                                  context,
                                                  width,
                                                  height,
                                                  datasnapshot.data!.docs[index]
                                                      .get('image'),
                                                  datasnapshot.data!.docs[index]
                                                      .get('name'),
                                                  datasnapshot.data!.docs[index]
                                                      .get('voters'),
                                                  datasnapshot.data!.docs[index]
                                                      .get('id'));
                                        }),
                                  );
                          })
                      : SizedBox(),
                  snapshot.data!.get('registration')
                      ? SizedBox(
                          height: 100,
                        )
                      : SizedBox(),
                  BottomBar()
                ],
              );
            }),
      ),
    );
  }

  Link socialButton(
    IconData icn,
    String link,
    Color clr,
  ) {
    return Link(
        target: LinkTarget.defaultTarget,
        uri: Uri.parse('$link'),
        builder: (context, snapshot) {
          return CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: InkWell(
                onTap: snapshot,
                child: Icon(
                  icn,
                  size: 18,
                  color: clr,
                ),
              ));
        });
  }

  Column TopTxt(
      BuildContext context,
      void onEnd(),
      int endTime,
      String sentense,
      bool live,
      bool reg,
      int total_participants,
      List<dynamic> plist) {
    final AuthController authController = Get.put(AuthController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          'JOIN & ENJOY',
          style: TextStyle(
              fontSize: ResponsiveWidget.isLargeScreen(context) ? 45 : 32,
              fontWeight: FontWeight.w800,
              color: Colors.white),
        ),
        SizedBox(height: 10),
        Text(
          'Radhe-Krishna Dressup',
          style: TextStyle(
              fontSize: ResponsiveWidget.isLargeScreen(context) ? 45 : 22,
              fontWeight: FontWeight.w800,
              color: Colors.white),
        ),
        SizedBox(height: 15),
        Text(
          'CONTEST',
          style: TextStyle(
              fontSize: ResponsiveWidget.isLargeScreen(context) ? 45 : 22,
              fontWeight: FontWeight.w800,
              color: Colors.white),
        ),
        SizedBox(
          height: 20,
        ),
        Text1(
          data:
              "Let’s use our creativity to decorate the altar of Lord Krishna who decorates this entire creation. Engage your creative skills in loving service of the Lord...",
          max: ResponsiveWidget.isSmallScreen(context) ? 14 : 18,
          min: ResponsiveWidget.isSmallScreen(context) ? 12 : 16,
          clr: Color(0xffbdb3f5),
        ),
        SizedBox(
          height: 25,
        ),
        reg
            ? ElevatedButton(
                onPressed: () {
                  authController.user == null
                      ? Get.to(Account())
                      : live
                          ? () {}
                          : plist.contains(authController.user!.uid)
                              ? Get.snackbar(
                                  "Notice",
                                  "Already registered",
                                )
                              : Get.to(Register(
                                  participants: total_participants,
                                ));
                },
                child: Padding(
                  padding: ResponsiveWidget.isSmallScreen(context)
                      ? EdgeInsets.all(10.0)
                      : EdgeInsets.all(15.0),
                  child: Text1(
                      data: live ? "Contest Live" : "Register Now",
                      max: ResponsiveWidget.isSmallScreen(context) ? 14 : 26,
                      min: ResponsiveWidget.isSmallScreen(context) ? 12 : 20),
                ),
                style: ElevatedButton.styleFrom(
                    primary: live ? Colors.redAccent : Colors.greenAccent,
                    shape: StadiumBorder()),
              )
            : SizedBox(),
        Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 10, top: 5),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.to(Terms());
                  },
                  child: Text('Terms & Conditions',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 14,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ))),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text1(
          data: "Sponsered by : Puja Purohit",
          max: 12,
          min: 11,
          clr: Colors.white,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text1(
              data: "$sentense:",
              max: ResponsiveWidget.isSmallScreen(context) ? 14 : 30,
              min: 11,
              clr: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            CountdownTimer(
              textStyle: TextStyle(
                fontSize: ResponsiveWidget.isSmallScreen(context) ? 14 : 30,
                color: Colors.white,
              ),
              onEnd: onEnd,
              endTime: endTime,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 20),
          child: Row(
            children: [
              Text1(
                data: 'For any query WhatsApp us at +91-9478743589',
                max: 12,
                min: 11,
                clr: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.white,
                child: Icon(
                  LineIcons.whatSApp,
                  color: Colors.green,
                  size: 12,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 10, top: 20),
          child: ResponsiveWidget.isLargeScreen(context)
              ? SizedBox()
              : Text1(
                  data: 'Live Result Commentry on',
                  max: 14,
                  min: 11,
                  clr: Colors.white,
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 10, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResponsiveWidget.isLargeScreen(context)
                  ? Text1(
                      data: 'Live Result Commentry on',
                      max: 14,
                      min: 11,
                      clr: Colors.white,
                    )
                  : SizedBox(),
              //SizedBox(width:5),
              Expanded(
                child: socialButton(
                    LineIcons.youtube,
                    'https://www.youtube.com/channel/UCtCe77a3YY6NR3snGPvhlxg',
                    Colors.redAccent),
              ),
              // SizedBox(width:5),
              Expanded(
                child: socialButton(LineIcons.facebookF,
                    'https://www.facebook.com/infopujapurohit/', Colors.blue),
              ),
              //SizedBox(width:5),
              Expanded(
                child: socialButton(
                    LineIcons.instagram,
                    'https://www.instagram.com/infopujapurohit/',
                    LightColors.kRed),
              ),
              // SizedBox(width:5),
              Expanded(
                child: socialButton(
                    LineIcons.linkedinIn,
                    'https://in.linkedin.com/company/puja-purohit',
                    LightColors.kDarkBlue),
              ),
              // SizedBox(width:5),
              Expanded(
                child: socialButton(
                    LineIcons.twitter,
                    'https://twitter.com/infopujapurohit',
                    LightColors.firstSlice),
              )
            ],
          ),
        ),
      ],
    );
  }

  Container ThirdCard(
      bool live,
      List<dynamic> total_voters,
      String? uid,
      BuildContext context,
      double width,
      double height,
      String img,
      String name,
      List<dynamic> voters,
      String id) {
    final AuthController authController = Get.put(AuthController());
    return Container(
      width: ResponsiveWidget.isSmallScreen(context)
          ? width * 0.45
          : ResponsiveWidget.isMediumScreen(context)
              ? width * 0.2
              : width * 0.16,
      height: ResponsiveWidget.isSmallScreen(context)
          ? height * 0.35
          : ResponsiveWidget.isMediumScreen(context)
              ? height * 0.4
              : height * 0.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: LightColors.shadowColor, blurRadius: 20)
          ],
          image: DecorationImage(
              image: NetworkImage('${img}'), fit: BoxFit.contain)),
      child: Stack(
        children: [
          // Container(
          //   height: height*0.7,
          //   width: width*0.2,
          //   decoration:BoxDecoration(
          //     image: DecorationImage(image: NetworkImage('https://i.pinimg.com/564x/f9/ac/bd/f9acbdde0a499308534856d5eec8ab67.jpg'),
          //     fit: BoxFit.contain)
          //   )
          // ),
          live
              ? uid == null
                  ? InkWell(
                      onTap: () {
                        Get.to(Account());
                      },
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(bottom: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 15,
                                        color: Color(0xff5a56c6))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Color(0xff5a56c6),
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text1(data: "Upvote", max: 12, min: 11)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : authController.user!.displayName == null
                      ? InkWell(
                          onTap: () {
                            Get.to(Update());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                margin: EdgeInsets.only(bottom: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 15,
                                          color: Color(0xff5a56c6))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        color: Color(0xff5a56c6),
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text1(data: "Upvote", max: 12, min: 11)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : voters.contains(uid)
                          ? InkWell(
                              onTap: () {
                                List<dynamic> total_V = total_voters;
                                total_voters.contains('$uid')
                                    ? total_voters.remove(uid)
                                    : () {};
                                List<dynamic> newlist = voters;
                                voters.remove(uid);
                                FirebaseFirestore.instance
                                    .doc(
                                        'PujaPurohitFiles/contest/Participants/$id')
                                    .update({
                                  'voters': newlist,
                                  'votes': FieldValue.increment(-1)
                                });
                                FirebaseFirestore.instance
                                    .doc('PujaPurohitFiles/contest')
                                    .update({'totalvoters': total_V});
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      margin: EdgeInsets.only(bottom: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Color(0xff5a56c6),
                                        borderRadius: BorderRadius.circular(20),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     blurRadius: 15,
                                        //     color: Color(0xff5a56c6)
                                        //   )
                                        //]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text1(
                                              data: "Upvoted",
                                              max: 12,
                                              min: 11,
                                              clr: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (total_voters.contains(uid)) {
                                  Get.defaultDialog(
                                      title: "Voted Sucesfully",
                                      middleText: "You alreadey voted");
                                } else {
                                  List<dynamic> total_V = total_voters;
                                  total_voters.contains('$uid')
                                      ? () {}
                                      : total_voters.add(uid);
                                  List<dynamic> newlist = voters;
                                  voters.add(uid);
                                  FirebaseFirestore.instance
                                      .doc(
                                          'PujaPurohitFiles/contest/Participants/$id')
                                      .update({
                                    'voters': newlist,
                                    'votes': FieldValue.increment(1)
                                  });
                                  FirebaseFirestore.instance
                                      .doc('PujaPurohitFiles/contest')
                                      .update({'totalvoters': total_V});
                                }
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      margin: EdgeInsets.only(bottom: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 15,
                                                color: Color(0xff5a56c6))
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Color(0xff5a56c6),
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text1(
                                                data: "Upvote",
                                                max: 12,
                                                min: 11)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
              : SizedBox(),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              alignment: Alignment.center,
              height: ResponsiveWidget.isSmallScreen(context) ? 20 : 40,
              width: ResponsiveWidget.isSmallScreen(context) ? 40 : 60,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff5a56c6), Color(0xff9476ef)]),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Text1(
                  data: "${voters.length}",
                  max: 16,
                  min: 14,
                  clr: Colors.white,
                  weight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              alignment: Alignment.center,
              height: ResponsiveWidget.isSmallScreen(context) ? 20 : 40,
              width: ResponsiveWidget.isSmallScreen(context) ? 40 : 60,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xffB08D57),
                    Color(0xff9C7A3C),
                    Color(0xff895E1A),
                    Color(0xff804A00)
                  ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Text1(
                  data: "3rd",
                  max: 16,
                  min: 14,
                  clr: Colors.white,
                  weight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Container SecondCard(
      bool live,
      List<dynamic> total_voters,
      String? uid,
      BuildContext context,
      double width,
      double height,
      String img,
      String name,
      List<dynamic> voters,
      String id) {
    final AuthController authController = Get.put(AuthController());
    return Container(
      width: ResponsiveWidget.isSmallScreen(context)
          ? width * 0.45
          : ResponsiveWidget.isMediumScreen(context)
              ? width * 0.2
              : width * 0.16,
      height: ResponsiveWidget.isSmallScreen(context)
          ? height * 0.35
          : ResponsiveWidget.isMediumScreen(context)
              ? height * 0.4
              : height * 0.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: LightColors.shadowColor, blurRadius: 20)
          ]),
      child: Stack(
        children: [
          Container(
              height: ResponsiveWidget.isSmallScreen(context)
                  ? height * 0.4
                  : ResponsiveWidget.isMediumScreen(context)
                      ? height * 0.5
                      : height * 0.7,
              width: ResponsiveWidget.isSmallScreen(context)
                  ? width * 0.5
                  : ResponsiveWidget.isMediumScreen(context)
                      ? width * 0.4
                      : width * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('$img'), fit: BoxFit.contain))),
          live
              ? uid == null
                  ? InkWell(
                      onTap: () {
                        Get.to(Account());
                      },
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(bottom: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 15,
                                        color: Color(0xff5a56c6))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Color(0xff5a56c6),
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text1(data: "Upvote", max: 12, min: 11)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : authController.user!.displayName == null
                      ? InkWell(
                          onTap: () {
                            Get.to(Update());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                margin: EdgeInsets.only(bottom: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 15,
                                          color: Color(0xff5a56c6))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        color: Color(0xff5a56c6),
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text1(data: "Upvote", max: 12, min: 11)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : voters.contains(uid)
                          ? InkWell(
                              onTap: () {
                                List<dynamic> total_V = total_voters;
                                total_voters.contains('$uid')
                                    ? total_voters.remove(uid)
                                    : () {};
                                List<dynamic> newlist = voters;
                                voters.remove(uid);
                                FirebaseFirestore.instance
                                    .doc(
                                        'PujaPurohitFiles/contest/Participants/$id')
                                    .update({
                                  'voters': newlist,
                                  'votes': FieldValue.increment(-1)
                                });
                                FirebaseFirestore.instance
                                    .doc('PujaPurohitFiles/contest')
                                    .update({'totalvoters': total_V});
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      margin: EdgeInsets.only(bottom: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Color(0xff5a56c6),
                                        borderRadius: BorderRadius.circular(20),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     blurRadius: 15,
                                        //     color: Color(0xff5a56c6)
                                        //   )
                                        //]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text1(
                                              data: "Upvoted",
                                              max: 12,
                                              min: 11,
                                              clr: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (total_voters.contains(uid)) {
                                  Get.defaultDialog(
                                      title: "Voted Sucesfully",
                                      middleText: "You alreadey voted");
                                } else {
                                  List<dynamic> total_V = total_voters;
                                  total_voters.contains('$uid')
                                      ? () {}
                                      : total_voters.add(uid);
                                  List<dynamic> newlist = voters;
                                  voters.add(uid);
                                  FirebaseFirestore.instance
                                      .doc(
                                          'PujaPurohitFiles/contest/Participants/$id')
                                      .update({
                                    'voters': newlist,
                                    'votes': FieldValue.increment(1)
                                  });
                                  FirebaseFirestore.instance
                                      .doc('PujaPurohitFiles/contest')
                                      .update({'totalvoters': total_V});
                                }
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      margin: EdgeInsets.only(bottom: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 15,
                                                color: Color(0xff5a56c6))
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Color(0xff5a56c6),
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text1(
                                                data: "Upvote",
                                                max: 12,
                                                min: 11)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
              : SizedBox(),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              alignment: Alignment.center,
              height: ResponsiveWidget.isSmallScreen(context) ? 20 : 40,
              width: ResponsiveWidget.isSmallScreen(context) ? 40 : 60,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff5a56c6), Color(0xff9476ef)]),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Text1(
                  data: "${voters.length}",
                  max: 16,
                  min: 14,
                  clr: Colors.white,
                  weight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              alignment: Alignment.center,
              height: ResponsiveWidget.isSmallScreen(context) ? 20 : 40,
              width: ResponsiveWidget.isSmallScreen(context) ? 40 : 60,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xffBEC0C2),
                    Color(0xffB3B6B5),
                    Color(0xff8E8D8D)
                  ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Text1(
                  data: "2nd",
                  max: 16,
                  min: 14,
                  clr: Colors.white,
                  weight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Container FirstCard(
      bool live,
      List<dynamic> total_voters,
      String? uid,
      BuildContext context,
      double width,
      double height,
      String img,
      String name,
      List<dynamic> voters,
      String id) {
    final AuthController authController = Get.put(AuthController());
    return Container(
      width: ResponsiveWidget.isSmallScreen(context)
          ? width * 0.5
          : ResponsiveWidget.isMediumScreen(context)
              ? width * 0.25
              : width * 0.2,
      height: ResponsiveWidget.isSmallScreen(context)
          ? height * 0.43
          : ResponsiveWidget.isMediumScreen(context)
              ? height * 0.45
              : height * 0.55,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: LightColors.shadowColor, blurRadius: 20)
          ]),
      child: Stack(
        children: [
          Container(
              height: ResponsiveWidget.isSmallScreen(context)
                  ? height * 0.43
                  : ResponsiveWidget.isMediumScreen(context)
                      ? height * 0.5
                      : height * 0.7,
              width: ResponsiveWidget.isSmallScreen(context)
                  ? width * 0.5
                  : ResponsiveWidget.isMediumScreen(context)
                      ? width * 0.4
                      : width * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('$img'), fit: BoxFit.contain))),
          live
              ? uid == null
                  ? InkWell(
                      onTap: () {
                        Get.to(Account());
                      },
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(bottom: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 15,
                                        color: Color(0xff5a56c6))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Color(0xff5a56c6),
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text1(data: "Upvote", max: 12, min: 11)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : authController.user!.displayName == null
                      ? InkWell(
                          onTap: () {
                            Get.to(Update());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                margin: EdgeInsets.only(bottom: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 15,
                                          color: Color(0xff5a56c6))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        color: Color(0xff5a56c6),
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text1(data: "Upvote", max: 12, min: 11)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : voters.contains(uid)
                          ? InkWell(
                              onTap: () {
                                List<dynamic> total_V = total_voters;
                                total_voters.contains('$uid')
                                    ? total_voters.remove(uid)
                                    : () {};
                                List<dynamic> newlist = voters;
                                voters.remove(uid);
                                FirebaseFirestore.instance
                                    .doc(
                                        'PujaPurohitFiles/contest/Participants/$id')
                                    .update({
                                  'voters': newlist,
                                  'votes': FieldValue.increment(-1)
                                });
                                FirebaseFirestore.instance
                                    .doc('PujaPurohitFiles/contest')
                                    .update({'totalvoters': total_V});
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      margin: EdgeInsets.only(bottom: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Color(0xff5a56c6),
                                        borderRadius: BorderRadius.circular(20),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     blurRadius: 15,
                                        //     color: Color(0xff5a56c6)
                                        //   )
                                        //]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text1(
                                              data: "Upvoted",
                                              max: 12,
                                              min: 11,
                                              clr: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (total_voters.contains(uid)) {
                                  Get.defaultDialog(
                                      title: "Voted Sucesfully",
                                      middleText: "You alreadey voted");
                                } else {
                                  List<dynamic> total_V = total_voters;
                                  total_voters.contains('$uid')
                                      ? () {}
                                      : total_voters.add(uid);
                                  List<dynamic> newlist = voters;
                                  voters.add(uid);
                                  FirebaseFirestore.instance
                                      .doc(
                                          'PujaPurohitFiles/contest/Participants/$id')
                                      .update({
                                    'voters': newlist,
                                    'votes': FieldValue.increment(1)
                                  });
                                  FirebaseFirestore.instance
                                      .doc('PujaPurohitFiles/contest')
                                      .update({'totalvoters': total_V});
                                }
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      margin: EdgeInsets.only(bottom: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 15,
                                                color: Color(0xff5a56c6))
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Color(0xff5a56c6),
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text1(
                                                data: "Upvote",
                                                max: 12,
                                                min: 11)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
              : SizedBox(),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              alignment: Alignment.center,
              height: ResponsiveWidget.isSmallScreen(context) ? 30 : 40,
              width: ResponsiveWidget.isSmallScreen(context) ? 50 : 60,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff5a56c6), Color(0xff9476ef)]),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Text1(
                  data: "${voters.length}",
                  max: ResponsiveWidget.isSmallScreen(context) ? 14 : 18,
                  min: ResponsiveWidget.isSmallScreen(context) ? 12 : 16,
                  clr: Colors.white,
                  weight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              alignment: Alignment.center,
              height: ResponsiveWidget.isSmallScreen(context) ? 30 : 40,
              width: ResponsiveWidget.isSmallScreen(context) ? 50 : 60,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xffFCC201),
                    Color(0xffEEB609),
                    Color(0xffDBA514)
                  ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Text1(
                  data: "1st",
                  max: ResponsiveWidget.isSmallScreen(context) ? 12 : 16,
                  min: ResponsiveWidget.isSmallScreen(context) ? 10 : 14,
                  clr: Colors.white,
                  weight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget OtherCards(
      bool live,
      List<dynamic> total_voters,
      String? uid,
      BuildContext context,
      double width,
      double height,
      String img,
      String name,
      List<dynamic> voters,
      String id) {
    final AuthController authController = Get.put(AuthController());
    return InkWell(
      onTap: () {
        // Get.defaultDialog(

        //   backgroundColor: Colors.transparent,
        //   title: '$name',
        //   titleStyle: TextStyle(color: Colors.transparent),
        //   content: SizedBox(
        //     height: height*0.7,
        //     child: Image.network(img))
        // );

        Get.toNamed('/DetailView?id=$id');
      },
      child: Container(
        margin: ResponsiveWidget.isSmallScreen(context)
            ? EdgeInsets.only(left: width * 0.2, right: width * 0.2)
            : EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            image: DecorationImage(
                image: NetworkImage('$img'), fit: BoxFit.contain),
            boxShadow: [
              BoxShadow(color: LightColors.shadowColor, blurRadius: 20)
            ]),
        width: ResponsiveWidget.isSmallScreen(context)
            ? width * 0.25
            : ResponsiveWidget.isMediumScreen(context)
                ? width * 0.2
                : width * 0.16,
        height: ResponsiveWidget.isSmallScreen(context)
            ? height * 0.35
            : ResponsiveWidget.isMediumScreen(context)
                ? height * 0.4
                : height * 0.5,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                alignment: Alignment.center,
                height: 100,
                width: 30,
                decoration: BoxDecoration(
                  color: Color(0xff5a56c6),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text1(
                    data: '$name',
                    max: 12,
                    min: 11,
                    clr: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                height: 100,
                child: live
                    ? uid == null
                        ? InkWell(
                            onTap: () {
                              Get.to(Account());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.only(bottom: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 15,
                                            color: Color(0xff5a56c6))
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_upward,
                                          color: Color(0xff5a56c6),
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text1(data: "Upvote", max: 12, min: 11)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : authController.user!.displayName == null
                            ? InkWell(
                                onTap: () {
                                  Get.to(Update());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      margin: EdgeInsets.only(bottom: 5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 15,
                                                color: Color(0xff5a56c6))
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Color(0xff5a56c6),
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text1(
                                                data: "Upvote",
                                                max: 12,
                                                min: 11)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : voters.contains(uid)
                                ? InkWell(
                                    onTap: () {
                                      List<dynamic> total_V = total_voters;
                                      total_voters.contains('$uid')
                                          ? total_voters.remove(uid)
                                          : () {};
                                      List<dynamic> newlist = voters;
                                      voters.remove(uid);
                                      FirebaseFirestore.instance
                                          .doc(
                                              'PujaPurohitFiles/contest/Participants/$id')
                                          .update({
                                        'voters': newlist,
                                        'votes': FieldValue.increment(-1)
                                      });
                                      FirebaseFirestore.instance
                                          .doc('PujaPurohitFiles/contest')
                                          .update({'totalvoters': total_V});
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.only(bottom: 5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color(0xff5a56c6),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     blurRadius: 15,
                                            //     color: Color(0xff5a56c6)
                                            //   )
                                            //]
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_upward,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text1(
                                                  data: "Upvoted",
                                                  max: 12,
                                                  min: 11,
                                                  clr: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      if (total_voters.contains(uid)) {
                                        Get.defaultDialog(
                                            title: "Voted Sucesfully",
                                            middleText:
                                                "You have alreadey voted");
                                      } else {
                                        List<dynamic> total_V = total_voters;
                                        total_voters.contains('$uid')
                                            ? () {}
                                            : total_voters.add(uid);
                                        List<dynamic> newlist = voters;
                                        voters.add(uid);
                                        FirebaseFirestore.instance
                                            .doc(
                                                'PujaPurohitFiles/contest/Participants/$id')
                                            .update({
                                          'voters': newlist,
                                          'votes': FieldValue.increment(1)
                                        });
                                        FirebaseFirestore.instance
                                            .doc('PujaPurohitFiles/contest')
                                            .update({'totalvoters': total_V});
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.only(bottom: 5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 15,
                                                    color: Color(0xff5a56c6))
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_upward,
                                                  color: Color(0xff5a56c6),
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text1(
                                                    data: "Upvote",
                                                    max: 12,
                                                    min: 11)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                    : SizedBox(),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                alignment: Alignment.center,
                height: ResponsiveWidget.isSmallScreen(context) ? 30 : 40,
                width: ResponsiveWidget.isSmallScreen(context) ? 40 : 60,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff5a56c6), Color(0xff9476ef)]),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Text1(
                    data: "${voters.length}",
                    max: ResponsiveWidget.isSmallScreen(context) ? 11 : 14,
                    min: ResponsiveWidget.isSmallScreen(context) ? 10 : 12,
                    clr: Colors.white,
                    weight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  final int participants;
  Register({required this.participants});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthController authController = Get.put(AuthController());
  List<XFile>? _imageFileList;
  XFile? ImageFile;
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;

  String? _retrieveDataError;
  String? photoUrl;
  bool imageUploaded = false;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    } else {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: 20,
          );
          setState(() {
            ImageFile = pickedFile;
            _imageFile = pickedFile;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  uploadImage(BuildContext context) async {
    File image_file = File(_imageFileList![0].path);
    var random = '${authController.user!.uid}';

    final firebase_storage.Reference firebaseStorage = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("contest")
        .child('${random}.jpg');
    if (_imageFileList == null) {
      return Get.snackbar("ImageError", "Please Select the Image");
    }
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpg',
        customMetadata: {'picked-file-path': ImageFile!.path});
    if (kIsWeb) {
      firebase_storage.UploadTask task =
          firebaseStorage.putData(await ImageFile!.readAsBytes(), metadata);
      var dowurl = await (await task.whenComplete(() {
        setState(() {
          imageUploaded = true;
        });
      }))
          .ref
          .getDownloadURL();
      String url = dowurl.toString();
      task.then((value) async {
        setState(() {
          photoUrl = url;
        });
      });
    }
    firebase_storage.UploadTask task =
        firebaseStorage.putFile(image_file, metadata);
    var dowurl = await (await task.whenComplete(() => print("Task Completed")))
        .ref
        .getDownloadURL();
    String url = dowurl.toString();
    task.then((value) async {
      setState(() {
        photoUrl = url;
      });
    });
  }

  Widget _previewImages() {
    double height = Get.height;
    double width = Get.width;
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: LightColors.shadowColor, blurRadius: 20)
            ]),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          key: UniqueKey(),
          itemBuilder: (context, index) {
            return SizedBox(
              width: 150,
              height: 200,
              child: kIsWeb
                  ? Image.network(
                      _imageFileList![index].path,
                      fit: BoxFit.fill,
                    )
                  : Image.file(
                      File(
                        _imageFileList![index].path,
                      ),
                      fit: BoxFit.fill,
                    ),
            );
          },
          itemCount: _imageFileList!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: LightColors.shadowColor, blurRadius: 20)
            ]),
      );
    }
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  String? name;
  String? gender;
  int? age;
  bool load = false;
  @override
  Widget build(BuildContext context) {
    //File _image_file = File(_imageFileList![0].path);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: load
          ? Loader()
          : Padding(
              padding: EdgeInsets.only(
                  left: width * 0.1,
                  right: width * 0.1,
                  bottom: height * 0.1,
                  top: height * 0.1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                          ? FutureBuilder<void>(
                              future: retrieveLostData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return Container(
                                      // height: 1920,
                                      // width: 1080,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                color: LightColors.shadowColor,
                                                blurRadius: 20)
                                          ]),
                                    );
                                  case ConnectionState.done:
                                    return _handlePreview();
                                  default:
                                    if (snapshot.hasError) {
                                      return Text(
                                        'Pick image/video error: ${snapshot.error}}',
                                        textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return Container(
                                        // height: 1920,
                                        // width: 1080,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      LightColors.shadowColor,
                                                  blurRadius: 20)
                                            ]),
                                      );
                                    }
                                }
                              },
                            )
                          : _handlePreview(),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _onImageButtonPressed(ImageSource.gallery,
                              context: context);
                        },
                        child: Text1(
                            data: "Upload",
                            max: 12,
                            min: 11,
                            clr: Colors.white),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff5a56c6), shape: StadiumBorder()),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.account_circle),
                          title: TextField(
                              maxLength: 10,
                              decoration: InputDecoration(
                                hintText: "Name",
                              ),
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              }),
                        ),
                        ListTile(
                          leading: Icon(CupertinoIcons.chart_bar),
                          title: TextField(
                            decoration: InputDecoration(hintText: "Age"),
                            maxLength: 2,
                            onChanged: (value) {
                              setState(() {
                                age = int.parse(value);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.male_outlined),
                          title: TextField(
                              maxLength: 1,
                              decoration:
                                  InputDecoration(hintText: "Gender i.e M/F"),
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .doc('PujaPurohitFiles/contest')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return SizedBox(
                                child: Loader(),
                                height: 50,
                              );
                            }
                            return ElevatedButton(
                              onPressed: () async {
                                if (name == null ||
                                    age == null ||
                                    gender == null ||
                                    ImageFile == null) {
                                  return Get.snackbar(
                                      "Error", "Fill all fields properly");
                                }
                                setState(() {
                                  load = true;
                                });
                                uploadImage(context);
                                await Future.delayed(Duration(seconds: 10),
                                    () async {
                                  await FirebaseFirestore.instance
                                      .doc(
                                          '/PujaPurohitFiles/contest/Participants/${authController.user!.uid}')
                                      .set({
                                    'id': '${authController.user!.uid}',
                                    'name': name,
                                    'age': age,
                                    'gender': gender,
                                    'votes': 0,
                                    'voters': FieldValue.arrayUnion([]),
                                    'image': photoUrl,
                                    'num':
                                        snapshot.data!.get('participants') + 1
                                  }).whenComplete(() {
                                    List<dynamic> plist =
                                        snapshot.data!.get('plist');
                                    plist.add('${authController.user!.uid}');
                                    FirebaseFirestore.instance
                                        .doc('/PujaPurohitFiles/contest')
                                        .update({
                                      'participants':
                                          snapshot.data!.get('participants') +
                                              1,
                                      'plist': plist
                                    });
                                    setState(() {
                                      load = false;
                                    });
                                  });
                                  Get.back();
                                });
                              },
                              child: Text1(
                                  data: "Submit",
                                  max: 12,
                                  min: 11,
                                  clr: Colors.white),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff5a56c6),
                                  shape: StadiumBorder()),
                            );
                          })
                    ],
                  )
                ],
              ),
            ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5a56c6),
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.cancel, color: Colors.white)),
      ),
      backgroundColor: Color(0xff5a56c6),
      body: Padding(
        padding: EdgeInsets.only(
          left: ResponsiveWidget.isLargeScreen(context) ? Get.width * 0.1 : 25,
          right: ResponsiveWidget.isLargeScreen(context) ? Get.width * 0.1 : 25,
          top: ResponsiveWidget.isLargeScreen(context) ? Get.width * 0.05 : 30,
        ),
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .doc('PujaPurohitFiles/contest')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Loader();
              }
              List<dynamic> terms = snapshot.data!.get('t&c');

              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: terms.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text1(
                        data: terms[index],
                        max: 14,
                        min: 11,
                        clr: Colors.white,
                        weight: FontWeight.w300,
                      ),
                    );
                  });
            }),
      ),
    );
  }
}

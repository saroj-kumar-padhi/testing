import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Text1 extends StatelessWidget{
  final String data;
  final Color? clr;
  final FontWeight? weight;
  final double?  max;
  final double? min;
  final double? space; 
  Text1({required this.data,this.space,this.clr,this.weight,required this.max,required this.min});
  @override
  Widget build(BuildContext context) {
   return AutoSizeText("$data",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,letterSpacing: space),maxFontSize: max!,minFontSize: min!,textAlign: TextAlign.justify,);
  }

}

class Text2 extends StatelessWidget{
  final String data;
  final Color? clr;
  final FontWeight? weight;
  final double?  max;
  final double? space; 
  Text2({required this.data,this.space,this.clr,this.weight,required this.max});
  @override
  Widget build(BuildContext context) {
   return SelectableText("$data",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,fontSize:max!,letterSpacing: space),);
  }

}
class Text3 extends StatelessWidget{
  final String data;
  final Color? clr;
  final FontWeight? weight;
  final double?  max;
  Text3({required this.data,this.clr,this.weight,required this.max});
  @override
  Widget build(BuildContext context) {
   return SelectableText("$data",style: TextStyle(color: clr,fontWeight: weight,fontSize:max!,letterSpacing: 1.0),);
  }

}
class Text4 extends StatelessWidget{
  final String data;
  final Color? clr;
  final FontWeight? weight;
  final double?  max;
  final double? min;
  final double? space; 
  Text4({required this.data,this.space,this.clr,this.weight,required this.max,required this.min});
  @override
  Widget build(BuildContext context) {
   return AutoSizeText("$data",style: GoogleFonts.firaSans(color: clr,fontWeight: weight,letterSpacing: space),maxFontSize: max!,minFontSize: min!,);
  }

}

class Text5 extends StatelessWidget{
  final String data1;
  final String data2;
  final String data3;
  final String data4;
  final String data5;
  final String data6;
  final String data7;
  final String data8;
  final String data9;
  final String data10;
  final Color? clr;
  final FontWeight? weight;
  final double?  max;
  final double? min;
  final double? spacing;
  Text5({required this.data10,required this.data1,required this.data2,required this.data3,required this.data4,required this.data5,required this.data6,required this.data7,required this.data8,required this.data9,this.clr,this.weight,required this.max,required this.min,this.spacing});
  @override
  Widget build(BuildContext context) {
    final TextLanguageController textLanguageController = Get.put(TextLanguageController());

    return Obx((){
      if(textLanguageController.langData.value.dataCode == 0){
        //return Obx(()=>AutoSizeText(textLanguageController.langData.value.dataCode == 0?"$data1":"",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!));
        return AutoSizeText("$data1",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!);
      }
      if(textLanguageController.langData.value.dataCode == 1){

        //return Obx(()=>AutoSizeText(textLanguageController.langData.value.dataCode == 1?"$data2":"",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!));
        return AutoSizeText("$data2",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!);
      }
      if(textLanguageController.langData.value.dataCode == 2){
        //return Obx(()=>AutoSizeText(textLanguageController.langData.value.dataCode == 2?"$data3":"",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!));
        return AutoSizeText("$data3",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!);
      }
      if(textLanguageController.langData.value.dataCode == 3){
        return AutoSizeText("$data4",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!);
        //return Obx(()=>AutoSizeText("$data4",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!));
      }
      if(textLanguageController.langData.value.dataCode == 4){
        return AutoSizeText("$data5",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!);
        //return Obx(()=>AutoSizeText("$data5",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!));
      }
      if(textLanguageController.langData.value.dataCode == 5){
        return AutoSizeText("$data6",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!);
        //return Obx(()=>AutoSizeText("$data6",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!));
      }
      if(textLanguageController.langData.value.dataCode == 6){
        return AutoSizeText("$data7",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!);
        //return Obx(()=>AutoSizeText("$data7",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!));
      }
      if(textLanguageController.langData.value.dataCode == 7){
        return AutoSizeText("$data8",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!);
        //return Obx(()=>AutoSizeText("$data8",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!));
      }
      if(textLanguageController.langData.value.dataCode == 8){
        return AutoSizeText("$data9",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!);
        //return Obx(()=>AutoSizeText("$data8",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!));
      }
      return AutoSizeText("$data10",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!);
      //return Obx(()=>AutoSizeText("$data9",style: GoogleFonts.aBeeZee(color: clr,fontWeight: weight,wordSpacing:spacing),maxFontSize: max!,minFontSize: min!));
    });

  }

}
class TextLanguageController extends GetxController{
  var langData = LangData(dataCode: 0).obs;

  updataLang(int langCode){
    langData.update((val) {
      val!.dataCode =  langCode;
    });
  }
}

class LangData{
  var dataCode = 0;
  LangData({required this.dataCode});
}


import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pujapurohit/Company/whoweare.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';

//Staggerdview implementation 
//Memories

class Memories extends StatelessWidget {
  Memories({Key? key}) : super(key: key);
  final List<Widget> _listTile = <Widget>[
    BackGroundTile(backgroundColor: Colors.red, icondata: Icons.home),
    BackGroundTile(backgroundColor: Colors.orange, icondata: Icons.ac_unit),
    BackGroundTile(backgroundColor: Colors.pink, icondata: Icons.landscape),
    BackGroundTile(backgroundColor: Colors.green, icondata: Icons.portrait),
    BackGroundTile(
        backgroundColor: Colors.deepPurpleAccent, icondata: Icons.music_note),
    BackGroundTile(backgroundColor: Colors.blue, icondata: Icons.access_alarms),
    BackGroundTile(
        backgroundColor: Colors.deepPurpleAccent, icondata: Icons.music_note),
  ];

  final List<StaggeredTile> _cardTile = <StaggeredTile>[
    const StaggeredTile.count(3, 1),
    const StaggeredTile.count(1, 0.5),
    const StaggeredTile.count(1, 0.5),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(1, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StaggeredGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        staggeredTiles: _cardTile,
        children: _listTile,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}


class mobileMemories extends StatelessWidget {
  mobileMemories({Key? key}) : super(key: key);
  final List<Widget> _listTile = <Widget>[
    BackGroundTile(backgroundColor: Colors.red, icondata: Icons.home),
    BackGroundTile(backgroundColor: Colors.orange, icondata: Icons.ac_unit),
    BackGroundTile(backgroundColor: Colors.pink, icondata: Icons.landscape),
    BackGroundTile(backgroundColor: Colors.green, icondata: Icons.portrait),
    BackGroundTile(
        backgroundColor: Colors.deepPurpleAccent, icondata: Icons.music_note),
    BackGroundTile(backgroundColor: Colors.blue, icondata: Icons.access_alarms),
    BackGroundTile(
        backgroundColor: Colors.deepPurpleAccent, icondata: Icons.music_note),
  ];

  final List<StaggeredTile> _cardTile = <StaggeredTile>[
    const StaggeredTile.count(2, 4),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 4),
    const StaggeredTile.count(2, 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StaggeredGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        staggeredTiles: _cardTile,
        children: _listTile,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}

//decoration text RichText implementain

Widget DecorationText(contentText, headerText, para) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
    child: RichText(
      text: TextSpan(
        text: contentText,
        style: GoogleFonts.dongle(
          fontWeight: FontWeight.w600,
          fontSize: 50,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: headerText,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w600,
              color: Colors.red,
              fontSize: 30,
            ),
          ),
          TextSpan(text: '\n'),
          TextSpan(
            text: para,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}




class BackGroundTile extends StatelessWidget {
  final Color backgroundColor;
  final IconData icondata;

  BackGroundTile({required this.backgroundColor, required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Icon(icondata, color: Colors.white),
    );
  }
}

//my grid view grid view implementaion for pujapurohits may u work with

class MyGridScreen extends StatelessWidget {
  const MyGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: GridView.extent(
            primary: false,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: ResponsiveWidget.isLargeScreen(context) ? 10 : 5,
            mainAxisSpacing: ResponsiveWidget.isLargeScreen(context) ? 10 : 5,
            maxCrossAxisExtent: ResponsiveWidget.isSmallScreen(context) ? 300 : 300,
            children: <Widget>[
              Creater("assets/images/person1.jpg"),
              Creater("assets/images/person1.jpg"),
              Creater("assets/images/person1.jpg"),
              Creater("assets/images/person1.jpg"),
              Creater("assets/images/person1.jpg"),
              Creater("assets/images/person1.jpg"),
            ],
            physics: const NeverScrollableScrollPhysics(),
          )),
    );
  }
}

//Courasal part

class Coursal extends StatelessWidget {
  const Coursal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: [
              SlideShow("assets/images/lap.jpg", "Puja Purohit"),
              SlideShow("assets/images/lap.jpg", "Puja Purohit"),
              SlideShow("assets/images/lap.jpg", "Puja Purohit"),
              SlideShow("assets/images/lap.jpg", "Puja Purohit"),
              SlideShow("assets/images/lap.jpg", "Puja Purohit"),
            ],
            options: CarouselOptions(
              height: ResponsiveWidget.isSmallScreen(context)
                  ? MediaQuery.of(context).size.height * 0.5
                  : MediaQuery.of(context).size.height,
              autoPlay: true,
              aspectRatio: 16 / 2,
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: true,
              reverse: true,
              enableInfiniteScroll: true,
            )),
      ],
    );
  }
}

//creater widget


class Creater extends StatelessWidget {
  late String Imagepath;
  Creater(this.Imagepath);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Image.asset(Imagepath),
        color: Colors.white60);
  }
}
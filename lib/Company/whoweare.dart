import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pujapurohit/Company/drawer.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';


class WhoWeArePageNavigator extends StatelessWidget {
  WhoWeArePageNavigator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WhoWeArePage(),
    );
  }
}

class WideScreenMenu extends StatelessWidget {
  WideScreenMenu();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Spacer(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PujaPurohitHeader("Puja Purohit"),
          ),
          const Spacer(),
          BannerText('Home'),
          SizedBox(
            width: 20,
          ),
          BannerText('Who we are'),
          const SizedBox(
            width: 25,
          ),
          BannerText('Careers'),
          const SizedBox(
            width: 25,
          ),
        ],
      ),
    );
  }
}

class MobileMenu extends StatelessWidget {
  MobileMenu();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
          child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavDrawer()),
                    );
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ))),
        ),
        Center(
            child: Expanded(flex: 4, child: PujaPurohitHeader("Puja Purohit"))),
      ],
    );
  }
}

class WhoWeArePage extends StatelessWidget {
  WhoWeArePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: ResponsiveWidget.isSmallScreen(context) ? 1 : 7,
                child: Stack(
                  children: [
                    const Expanded(
                      child: BackgroundImage(),
                    ),
                    Flexible(
                        child: ResponsiveWidget.isSmallScreen(context)
                            ? MobileMenu()
                            : WideScreenMenu()),
                  ],
                ),
              ),
              ResponsiveWidget.isSmallScreen(context)
                  ? SizedBox(
                      height: 50,
                    )
                  : SizedBox(),
              Expanded(
                  flex: ResponsiveWidget.isSmallScreen(context) ? 0 : 6,
                  child: Coursal()),
              ResponsiveWidget.isLargeScreen(context)
                  ? const Spacer(
                      flex: 1,
                    )
                  : SizedBox(
                      height: 30,
                    ),
              DecorationText(
                'Driving the force of ',
                "assortment",
                " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus ut urna ac ullamcorper. Nulla sit amet viverra lacus, in consectetur elit. Maecenas quis aliquam metus, id varius massa. Nam nisl purus, pulvinar sit amet ultricies vel, blandit in est. Ut semper nibh eget congue tempor. Quisque vitae ultrices mauris. Aliquam erat volutpat. Integer purus sapien, hendrerit at congue quis, pellentesque vel turpis. Curabitur vitae placerat ex, ut porttitor nulla. Praesent feugiat hendrerit dignissim. Nullam lectus orci, finibus nec nisi at, pharetra condimentum metus. Aliquam condimentum molestie neque, ut semper erat tempus a. Mauris tincidunt posuere mauris eu lobortis",
              ),
              ResponsiveWidget.isSmallScreen(context)
                  ? const SizedBox(
                      height: 30,
                    )
                  : const SizedBox(),
              Expanded(
                  flex: ResponsiveWidget.isSmallScreen(context) ? 0 : 5,
                  child: ResponsiveWidget.isLargeScreen(context)
                      ? WideScreenBlogPageSnippet(
                          "who we are",
                          " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus ut urna ac ullamcorper. Nulla sit amet viverra lacus, in consectetur elit. Maecenas quis aliquam metus, id varius massa. Nam nisl purus, pulvinar sit amet ultricies vel, blandit in est. Ut semper nibh eget congue tempor. Quisque vitae ultrices mauris. Aliquam erat volutpat. Integer purus sapien, hendrerit at congue quis, pellentesque vel turpis. Curabitur vitae placerat ex, ut porttitor nulla. Praesent feugiat hendrerit dignissim. Nullam lectus orci, finibus nec nisi at, pharetra condimentum metus. Aliquam condimentum molestie neque, ut semper erat tempus a. Mauris tincidunt posuere mauris eu lobortis",
                          "assets/images/lap.jpg")
                      : const SizedBox()),
              Expanded(
                  flex: ResponsiveWidget.isSmallScreen(context) ? 2 : 1,
                  child: ResponsiveWidget.isSmallScreen(context)
                      ? MobileBlogPageSnippet(
                          "who we are",
                          " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus ut urna ac ullamcorper. Nulla sit amet viverra lacus, in consectetur elit. Maecenas quis aliquam metus, id varius massa. Nam nisl purus, pulvinar sit amet ultricies vel, blandit in est. Ut semper nibh eget congue tempor. Quisque vitae ultrices mauris. Aliquam erat volutpat. Integer purus sapien, hendrerit at congue quis, pellentesque vel turpis. Curabitur vitae placerat ex, ut porttitor nulla. Praesent feugiat hendrerit dignissim. Nullam lectus orci, finibus nec nisi at, pharetra condimentum metus. Aliquam condimentum molestie neque, ut semper erat tempus a. Mauris tincidunt posuere mauris eu lobortis",
                          "assets/images/lap.jpg")
                      : const SizedBox()),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Container(
                    height: ResponsiveWidget.isSmallScreen(context)
                        ? MediaQuery.of(context).size.height
                        : MediaQuery.of(context).size.height,
                    child: ResponsiveWidget.isSmallScreen(context)
                        ? mobileMemories()
                        : Memories()),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: PujaPurohitHeader("PujaPurohits you may work with"),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: const MyGridScreen()),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget MobileBlogPageSnippet(headerText, contentText, imagePath) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Column(children: [
      Text(
        headerText,
        style: TextStyle(fontSize: 25),
      ),
      const SizedBox(
        height: 30,
      ),
      Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            image:
                DecorationImage(fit: BoxFit.fill, image: AssetImage(imagePath)),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Align(
          alignment: Alignment.center,
          child: Text(contentText,
              maxLines: 20,
              overflow: TextOverflow.clip,
              style: GoogleFonts.dongle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    ]),
  );
}

Widget WideScreenBlogPageSnippet(
  headerText,
  contentText,
  imagePath,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
    child: Row(children: [
      Expanded(
        flex: 6,
        child: RichText(
          text: TextSpan(
            text: headerText,
            style: GoogleFonts.dongle(
              fontWeight: FontWeight.w600,
              fontSize: 50,
            ),
            children: <TextSpan>[
              TextSpan(text: '\n'),
              TextSpan(
                text: contentText,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        flex: 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(imagePath)),
          ),
        ),
      ),
    ]),
  );
}

class BannerText extends StatelessWidget {
  String text;
  BannerText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(color: Colors.grey, fontSize: 25),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage('assets/images/lap.jpg')),
      ),
    );
  }
}

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

class SlideShow extends StatelessWidget {
  @override
  String imagepath;
  String textitem;
  SlideShow(this.imagepath, this.textitem);
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            image: DecorationImage(
              image: AssetImage(imagepath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
            child: Text(
          textitem,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            fontSize: 30,
          ),
        )),
      ],
    );
  }
}

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
        maxCrossAxisExtent: ResponsiveWidget.isSmallScreen(context) ? 100 : 300,
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

class PujaPurohitHeader extends StatelessWidget {
  final String text;
  PujaPurohitHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        color: Colors.grey,
        fontSize: 30,
      ),
    );
  }
}

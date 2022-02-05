import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pujapurohit/Company/drawer.dart';
import 'package:pujapurohit/Company/widget.dart';
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
            padding: const EdgeInsets.all(60.0),
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
                    Get.to(NavDrawer());
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
                flex: ResponsiveWidget.isSmallScreen(context) ? 0 : 7,
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
                  flex: ResponsiveWidget.isSmallScreen(context) ? 1 : 5,
                  child: ResponsiveWidget.isSmallScreen(context)
                      ? MobileBlogPageSnippet(
                      "who we are",
                      " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus ut urna ac ullamcorper. Nulla sit amet viverra lacus, in consectetur elit. Maecenas quis aliquam metus, id varius massa. Nam nisl purus, pulvinar sit amet ultricies vel, blandit in est. Ut semper nibh eget congue tempor. Quisque vitae ultrices mauris. Aliquam erat volutpat. Integer purus sapien, hendrerit at congue quis, pellentesque vel turpis. Curabitur vitae placerat ex, ut porttitor nulla. Praesent feugiat hendrerit dignissim. Nullam lectus orci, finibus nec nisi at, pharetra condimentum metus. Aliquam condimentum molestie neque, ut semper erat tempus a. Mauris tincidunt posuere mauris eu lobortis",
                      "assets/images/lap.jpg")
                      : WideScreenBlogPageSnippet(
                      "who we are",
                      " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus ut urna ac ullamcorper. Nulla sit amet viverra lacus, in consectetur elit. Maecenas quis aliquam metus, id varius massa. Nam nisl purus, pulvinar sit amet ultricies vel, blandit in est. Ut semper nibh eget congue tempor. Quisque vitae ultrices mauris. Aliquam erat volutpat. Integer purus sapien, hendrerit at congue quis, pellentesque vel turpis. Curabitur vitae placerat ex, ut porttitor nulla. Praesent feugiat hendrerit dignissim. Nullam lectus orci, finibus nec nisi at, pharetra condimentum metus. Aliquam condimentum molestie neque, ut semper erat tempus a. Mauris tincidunt posuere mauris eu lobortis",
                      "assets/images/lap.jpg")),
              ResponsiveWidget.isLargeScreen(context)?SizedBox(height: 60,):SizedBox(height: 40,),
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
      width: MediaQuery.of(context).size.width*1,
      height: MediaQuery.of(context).size.height*1,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage('assets/images/lap.jpg')),
      ),
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








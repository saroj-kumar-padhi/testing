
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:url_launcher/link.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      color: Colors.black,
      child: Column(
        children: [
          ResponsiveWidget.isSmallScreen(context)?Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              BottomBarColumn(
                heading: 'ABOUT',
                s1: 'Contact Us',
                s2: 'About Us',
                s3: 'Careers',
              ),
              BottomBarColumn(
                heading: 'HELP',
                s1: 'Payment',
                s2: 'Cancellation',
                s3: 'FAQ',
              ),
              BottomBarColumn(
                heading: 'SOCIAL',
                s1: 'Twitter',
                s2: 'Facebook',
                s3: 'YouTube',
                l1:'https://twitter.com/infopujapurohit',
                l2:'https://www.facebook.com/infopujapurohit',
                l3: 'https://www.youtube.com/channel/UCtCe77a3YY6NR3snGPvhlxg',
              ),
              Container(
                color: Colors.blueGrey,
                width: 150,
                height: 2,
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoText(
                    type: 'Email',
                    text: 'contact@pujapurohit.in',
                  ),
                  // SizedBox(height: 5),
                  // InfoText(
                  //   type: 'Address',
                  //   text: 'R1/63 Budh Vihar Delhi - 110086',
                  // )
                ],
              ),
            ],
          ):Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomBarColumn(
                heading: 'ABOUT',
                s1: 'Contact Us',
                s2: 'About Us',
                s3: 'Careers',
              ),
              BottomBarColumn(
                heading: 'HELP',
                s1: 'Payment',
                s2: 'Cancellation',
                s3: 'FAQ',
              ),
              BottomBarColumn(
                heading: 'SOCIAL',
                s1: 'Twitter',
                s2: 'Facebook',
                s3: 'YouTube',
                l1:'https://twitter.com/infopujapurohit',
                l2:'https://www.facebook.com/infopujapurohit',
                l3: 'https://www.youtube.com/channel/UCtCe77a3YY6NR3snGPvhlxg',
              ),
              Container(
                color: Colors.blueGrey,
                width: 2,
                height: 150,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoText(
                    type: 'Email',
                    text: 'contact@pujapurohit.in',
                  ),
                  // SizedBox(height: 5),
                  // InfoText(
                  //   type: 'Address',
                  //   text: 'R1/63 Budh Vihar Delhi - 110086',
                  // )
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.blueGrey,
          ),
          SizedBox(height: 20),
          SelectableText(
            'Copyright © 2021 | Puja Purohit',
            style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 14,
            ),          
          ),
        ],
      ),
    );
  }
}
class InfoText extends StatelessWidget {
  final String? type;
  final String? text;

  InfoText({this.type, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(
          '$type: ',
          style: TextStyle(
            color: Colors.white,
          ),
          maxFontSize: 16,
          minFontSize: 16,
        ),
        AutoSizeText(
          text!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          maxFontSize: 16,
          minFontSize: 16,
        )
      ],
    );
  }
}

class BottomBarColumn extends StatelessWidget {
  final String? heading;
  final String? s1;
  final String? s2;
  final String? s3;
  final String? l1;
  final String? l2;
  final String? l3;

  BottomBarColumn({
    this.heading,
    this.s1,
    this.s2,
    this.s3,
    this.l1,
    this.l2,
    this.l3
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            heading!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            maxFontSize: 18,
            minFontSize: 18,
          ),
          SizedBox(
            height: 10,
          ),
          Link(
            uri: Uri.parse('$l1'),
            target: LinkTarget.blank,
            builder: (context, followlink) {
              return InkWell(
                onTap: followlink,
                child: AutoSizeText(
                  s1!,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  maxFontSize: 14,
                  minFontSize: 14,
                ),
              );
            }
          ),
          SizedBox(height: 5),
          Link(
            uri: Uri.parse('$l2'),
            target: LinkTarget.blank,
            builder: (context, followlink) {
              return InkWell(
                onTap: followlink,
                child: AutoSizeText(
                  s2!,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  maxFontSize: 14,
                  minFontSize: 14,
                ),
              );
            }
          ),
          SizedBox(height: 5),
          Link(
            uri: Uri.parse('$l3'),
            target: LinkTarget.blank,
            builder: (context, followlink) {
              return InkWell(
                onTap: followlink,
                child: AutoSizeText(
                  s3!,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  maxFontSize: 14,
                  minFontSize: 14,
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
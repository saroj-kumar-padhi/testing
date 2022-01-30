import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class NavDrawer extends StatelessWidget {
  NavDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Flexible(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: PujaPurohitHeader("Puja Purohit"),
              decoration: Desc(),
            ),
            ListItems('Home',Icons.home),
            ListItems('Who we are',Icons.search),
            ListItems('Feedback',Icons.feedback),
            ListItems('Careers',Icons.business_sharp),
            
          ],
        ),
      ),
    );
  }



  BoxDecoration Desc() {
    return BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/lap.jpg')));
  }
}

class ListItems extends StatelessWidget {
  String name;
  final IconData next;
  var text;
  ListItems(this.name,this.next);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(next),
      title: Text(name, style: TextStyle(color: Colors.grey, fontSize: 25),),
      onTap: () => {},
    );
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
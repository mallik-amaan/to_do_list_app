import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list_app/UI/about.dart';
import 'package:to_do_list_app/UI/completed.dart';
import 'package:to_do_list_app/UI/pending.dart';

import 'main.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final box=Hive.box('user');
  String? name,email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name=box.get('name');
    email=box.get('email');
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color.fromARGB(255,193, 234, 159) ,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color:Color.fromARGB(255,193, 234, 159) ,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 55,),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('$name',style: GoogleFonts.josefinSans(fontSize: 25)),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('$email',style: GoogleFonts.josefinSans(fontSize: 12)),
                      ],
                    ),
                  ],
                )),
            ListTile(
              leading: Container(
                height: 25,
                width: 30,
                child: Image.asset('lib/icons/home.png'),
              ),
              title: Text('Home Screen',style: GoogleFonts.josefinSans(fontSize: 20,color: Colors.black87),),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: 'TO-DO APP')),
              );},
            ),
            ListTile(leading: Container(
              height: 25,
              width: 30,
              child: Image.asset('lib/icons/check-circle.png'),
            ),
              title: Text('Completed Tasks',style: GoogleFonts.josefinSans(fontSize: 20,color: Colors.black87),),
              onTap: (){Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Completed()),
              );;
              },
            ),
            ListTile(leading: Container(
              height: 25,
              width: 30,
              child: Image.asset('lib/icons/comp.png'),
            ),
              title: Text('Pending Tasks',style: GoogleFonts.josefinSans(fontSize: 20,color: Colors.black87),),
              onTap: (){Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pning()),
              );},
            ),
            ListTile(leading: Container(
              height: 25,
              width: 30,
              child: Image.asset('lib/icons/information.png'),
            ),
              title: Text('About',style: GoogleFonts.josefinSans(fontSize: 20,color: Colors.black87),),
              onTap: (){
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()));},
            ),
          ],
        )
    );
  }
}

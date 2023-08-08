import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final box=Hive.box('user');
  final name=new TextEditingController();
  final email=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,246, 241, 248),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
            child: Column(
              children: [
                Lottie.asset('lib/lottie/signup.json',height: 300,width: 300),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Set the border radius here
                      ),              ),
                  ),

                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Set the border radius here
                      ),              ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(onPressed: ()async {
                    if(name.text.isNotEmpty && email.text.isNotEmpty){
                      await box.put('name',name.text);
                      await box.put('email',email.text);
                      Navigator.pushNamed(context, 'homescreen');
                    }}, child: Container(
                    child: Text('Continue',style: GoogleFonts.josefinSans(fontSize: 20),),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

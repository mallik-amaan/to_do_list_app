import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class introduction extends StatefulWidget {
  const introduction({super.key});

  @override
  State<introduction> createState() => _introductionState();
}

class _introductionState extends State<introduction> {
  final _controller = new PageController(initialPage: 0);
  int screencount=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.08),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                  onPageChanged: (value){
                    setState(() {
                      screencount=value;
                    });
                    print(screencount);
                  },
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  children: [
                Padding(
                  padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.15),
                  child: Column(
                      children:[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('How it Works',style: GoogleFonts.josefinSans(
                                  fontSize: 30
                              ),),
                              Image.asset('lib/icons/how.png',height: 50,width: 50,),

                            ],
                          ),
                        ),
                        Lottie.asset('lib/lottie/1.json',height: 400,width: 400),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Manage your \nEveryday Task',style: GoogleFonts.josefinSans(fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple
                              ),textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ]),
                ),
                    Padding(
                      padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.10),
                      child: Container(
                        child: Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Check your tasks',style: GoogleFonts.josefinSans(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold),),
                                Lottie.asset('lib/lottie/tick.json',height: 100,width: 100),

                              ],
                            ),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('lib/icons/Checklist.jpg',height: 400,width: 390,),
                            ],
                          ),
                            Text('Create and Update as \nrequired',style: GoogleFonts.josefinSans(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.10),
                        child: Column(
                          children: [

                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Set-up Reminders',style: GoogleFonts.josefinSans(fontSize: 30,fontWeight: FontWeight.bold,
                                color: Colors.deepOrangeAccent),),
                                Lottie.asset('lib/lottie/reminder.json',height: 100,width: 94),
                              ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('lib/icons/reminder.jpg',height: 400,width: 390),
                              ],
                            ),
                            Text('Get Updated with \nNotifications',style: GoogleFonts.josefinSans(fontSize: 30,color: Colors.blueGrey,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SmoothPageIndicator(controller: _controller, count: 3,effect: ExpandingDotsEffect(
              dotColor: Colors.deepPurple,
              activeDotColor: Colors.greenAccent,
              dotHeight: 30,
              dotWidth: 30
            ),),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  if(screencount<=1)
                    {
                      _controller.jumpToPage(screencount+1);
                    }
                  else if(screencount==2)
                    {
                      Navigator.pushNamed(context, 'information');
                    }
                },
                    child: Container(
                      child:
                      screencount==2?
                      Text('Next',style:GoogleFonts.josefinSans(fontSize: 20,fontWeight: FontWeight.bold),)
                          :
                      Text('Continue',style:GoogleFonts.josefinSans(fontSize: 20,fontWeight: FontWeight.bold),)

                    ))
                ],
            )
          ],
        ),
      ),

    );
  }
}

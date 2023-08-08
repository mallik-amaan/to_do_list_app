import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list_app/UI/appDrawer.dart';
import 'package:to_do_list_app/UI/newTasks.dart';
import 'package:to_do_list_app/backend/database.dart';
import 'package:hive/hive.dart';
class pning extends StatefulWidget {
  pning({super.key});

  @override
  State<pning> createState() => _pningState();
}

class _pningState extends State<pning> {
  Database db=new Database();
  final box=Hive.box('database');
  List completedshowed=[];
  @override
  void initState() {
    inCompletedTasks();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255,246, 241, 248),

      ),
      backgroundColor: Color.fromARGB(255,246, 241, 248),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top:18.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Pending Tasks",style: GoogleFonts.josefinSans(fontSize: 30),),
              ],
            ),
            completedshowed.length==0?Row():Expanded(
              child: ListView.builder(
                itemCount: completedshowed.length,
                itemBuilder: (BuildContext context, int index) {
                  return newTask(title: completedshowed[index]['title'],
                      isCompleted: completedshowed[index]['isCompleted'],
                      first1: completedshowed[index]['1st'],
                      last1: completedshowed[index]['last'],
                      index:index,
                      database: db,
                      deletefunction: completedshowed[index]['deletefunction']);

                },),
            )
          ],
        ),
      ),
    );
  }
  void inCompletedTasks()
  {
    List result = box.get('TASKS').where((element) =>
    element['isCompleted']==false
    ).toList();

    setState(() {
      completedshowed=result;

    });
    if(completedshowed.length!=0){
    completedshowed[0]['1st']=true;
    completedshowed[completedshowed.length-1]['last']=true;
  }}

}


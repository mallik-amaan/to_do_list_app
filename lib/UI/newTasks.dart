import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:to_do_list_app/UI/main.dart';
import 'package:to_do_list_app/backend/database.dart';
import 'package:flutter/foundation.dart';
class newTask extends StatefulWidget {
   String title;
   bool isCompleted;
   bool first1,last1;
   int index;
   Database database;
   Function(BuildContext)? deletefunction;
   newTask({super.key
    ,required this.title,
    required this.isCompleted,
    required this.first1,
    required this.last1,
     required this.index,
     required this.database,
     required this.deletefunction,
  });

  @override
  State<newTask> createState() => _newTaskState();
}

class _newTaskState extends State<newTask> {
  @override
  Widget build(BuildContext build) {
    bool first = widget.first1;
    bool last = widget.last1;
    Database db=widget.database;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 100,
        child: TimelineTile(
          isFirst: first,
          isLast: last,
          beforeLineStyle: LineStyle(
              color: widget.isCompleted ? Colors.deepPurple : Colors.white),
          afterLineStyle: LineStyle(
              color: widget.isCompleted ? Colors.deepPurple : Colors.white),
          indicatorStyle: IndicatorStyle(
              height: 40,
              width: 40,
              iconStyle: IconStyle(iconData: Icons.check, color: widget.isCompleted?Colors.white:Color.fromARGB(255,193, 234, 159)),
              color:Color.fromARGB(255,193, 234, 159)),
          endChild: taskcard(),
        ),
      ),
    );
  }

  Widget taskcard() {
    bool completed = widget.isCompleted;
    String title = widget.title;
    Database db=widget.database;
    Image check;
    if (completed) {
      check = Image.asset(
        'lib/icons/correct.png', height: 20, width: 20,);
    } else {
      check = Image.asset('lib/icons/circle.png', height: 20, width: 20,);
    }
    return GestureDetector(
      onTap: (){editing();},
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: MediaQuery
                .of(context)
                .size
                .width * 0.09),
            child: Slidable(
              endActionPane: ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction(onPressed: (a) {
                    setState(() {
                      if (!widget.isCompleted) {
                        widget.isCompleted = true;
                        db.tasks[widget.index]['isCompleted']=widget.isCompleted;
                      }
                      else {
                        widget.isCompleted = false;
                        db.tasks[widget.index]['isCompleted']=widget.isCompleted;
                      }
                    });
                    db.updateTask();
                  },
                    icon: widget.isCompleted ? Icons.remove_done : Icons.check,
                    backgroundColor: widget.isCompleted ? Colors.white70 : Colors
                        .green,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),),
                  SlidableAction(onPressed: (a) {
                    widget.deletefunction?.call(context); // Call the function with context
                  },
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),),)
                ],

              ),
              child: Container(
                decoration: BoxDecoration(
                  color:// widget.isCompleted ? Colors.green[400] :
                  Color.fromARGB(255,193, 234, 159) ,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.08,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.7,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, bottom: 16, left: 16),
                      child: Text(
                        title, style: GoogleFonts.barlowCondensed(fontSize: 20),),
                    ),


                  ],
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
void editing(){
    String title=widget.title;
    final _newtitle=new TextEditingController();
    showDialog(context: context, builder:(context)
    {
      return AlertDialog(
     content: Container(
       height: MediaQuery.of(context).size.height * 0.2,
       width: MediaQuery.of(context).size.width,
       child: Column(
         children: [
           TextField(
             controller: _newtitle,
             decoration: InputDecoration(
               hintText: title,
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20.0),
               ),
             ),
           ),
           SizedBox(height: 20,),

           SizedBox(height: 15,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               TextButton(
                 onPressed: () {
                   Navigator.pop(context, MyHomePage(title: widget.title));
                 },
                 child: Text('Cancel',style: GoogleFonts.josefinSans(fontSize: 20),),
               ),
               TextButton(
                 onPressed: () {
                   setState(() {
                     widget.title=_newtitle.text;
                     widget.database.tasks[widget.index]['title']=_newtitle.text;
                   });
                   Navigator.pop(context, MyHomePage(title: widget.title));
                 },
                 child: Text('Save',style: GoogleFonts.josefinSans(fontSize: 20),),
               ),
             ],
           ),
         ],
       ),
     ),
      );
    }
    );
}

}

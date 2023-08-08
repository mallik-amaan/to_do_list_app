import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list_app/UI/Information.dart';
import 'package:to_do_list_app/UI/appDrawer.dart';
import 'package:to_do_list_app/UI/completed.dart';
import 'package:to_do_list_app/backend/database.dart';
import 'intro.dart';
import 'newTasks.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
void main() async{
  await Hive.initFlutter();
  await Hive.openBox('database');
  await Hive.openBox('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      initialRoute: 'intro',
      routes: {
        'homescreen': (context) => MyHomePage(title: 'TO-DO APP',),
        'intro':(context)=> introduction(),
        'completed':(context)=> Completed(),
        'information':(context)=>Information(),
      },
      title: 'TO-DO APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255,246, 241, 248)),
        useMaterial3: true,
      ),
      home: introduction(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final box=Hive.box('database');
  Database db=new Database();
  bool clicked = false;
  List showed=[];
  final user=Hive.box('user');
  String? name;
  String? pendingtasks;
  @override
  void initState() {    super.initState();
    name=user.get('name');
  // TODO: implement initState
    if(box.get('TASKS')==null){
      db.createDatabase();
      showed=db.tasks;
      inCompletedTasks();

    }
    else
      {
        db.loadTask();
        showed=db.tasks;
        inCompletedTasks();
      }
  }
  @override
  Widget build(BuildContext context) {
    Color second = Color.fromARGB(255,187, 143, 169);
    Color third =Color.fromARGB(255,193, 234, 159);
    return Scaffold(
      floatingActionButton:  FloatingActionButton(onPressed: (){taskdetails(context);},
        tooltip: 'Create new task',
        backgroundColor: third,
        child: Image.asset('lib/icons/add-post.png',height: 30,width: 30,),

      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255,246, 241, 248),
      ),
      drawer: AppDrawer(),
      backgroundColor: Color.fromARGB(255,246, 241, 248),
      body: Container(
        decoration: BoxDecoration(
         /* gradient: LinearGradient(
            colors: [Colors.purple,Colors.green],
           // colors: [Color.fromARGB(255,246, 241, 248),third],
          ),*/
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05, right: 16),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hello \n$name', style: GoogleFonts.labrada(
                      fontSize: 40, color: Colors.black87),),
                  
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Text('$pendingtasks tasks pending',
                    style: GoogleFonts.quicksand(fontSize: 15, color: second),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) => searchTask(value),
                style: GoogleFonts.labrada(),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        300.0), // Set the border radius here
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: showed.length,
                  itemBuilder: (context, index) {
                    return newTask(
                      title: showed[index]['title'],
                      isCompleted: showed[index]['isCompleted'],
                      first1: showed[index]['1st'],
                      last1: showed[index]['last'],
                      database: db,
                      index: index,
                      deletefunction:(context) => deletetask(index, db),
                    );
                  },
                )

            ),

          ],
        ),
      ),
    );
  }

  void taskdetails(BuildContext context) {
    DateTime? selectedDateTime;
    TextEditingController tasktitle = TextEditingController();
  showDialog(
  context: context,
      builder: (context) {
        return  AlertDialog(

          content: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                      child: TextField(
                        controller: tasktitle,
                        decoration: InputDecoration(
                          hintText: 'Add task',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
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
                            db.tasks[db.tasks.length - 1]['last'] = false;
                            db.tasks.insert(db.tasks.length, {
                              'title': tasktitle.text,
                              'isCompleted': false,
                              '1st': false,
                              'last': true,
                              'isReminder': selectedDateTime != null,
                            });
                            db.updateTask();
                            setState(() {
                              showed=db.tasks;
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

          ),
        );
      },
    );
  }

  Future<DateTime?> _datetimesettngs() async {
    DateTime? selected_date = await showDatePicker(
        context: context, initialDate: DateTime.now()
        , firstDate: DateTime(2000), lastDate: DateTime(2100)
    );
    if (selected_date != null) {
      TimeOfDay? selected_time = await showTimePicker(
          context: context, initialTime: TimeOfDay.now());
      if (selected_time != null) {
        return DateTime(
            selected_date.year, selected_date.month, selected_date.day,
            selected_time.hour, selected_time.minute);
      }
    }
    return null;
  }
  void deletetask(int index,Database db) {
    if(index==0)
    {
      db.tasks[1]['1st']=true;
    }
    else if(index==db.tasks.length-1)
    {
      db.tasks[db.tasks.length-2]['last']=true;
    }
    db.tasks.removeAt(index);
    db.updateTask();
    setState(() {
      showed=db.tasks;
    });

  }
  void inCompletedTasks()
  {
    List result = box.get('TASKS').where((element) =>
    element['isCompleted']==false
    ).toList();
    setState(() {
      if(result.length==0) {
        pendingtasks = '0';
      }
    else{
      pendingtasks=result.length.toString();
      }});
    }
  void searchTask(String searchedtext) {
    List result = [];
    result = db.tasks.where((element) =>
        element['title'].toString().toLowerCase().contains(searchedtext.toLowerCase()))
        .toList();
    if (searchedtext != null) {
      setState(() {
        showed = result;
      });
    }
    else{
      setState(() {
        showed=db.tasks;
      });

    }
  }
}
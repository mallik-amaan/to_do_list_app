import 'package:hive/hive.dart';
class Database{
  List tasks=[];
  final _Database=Hive.box('database');
  void  loadTask(){
    tasks=_Database.get('TASKS');
  }
   void deleteTask(){

   }
   void updateTask(){
    _Database.put("TASKS", tasks);
   }
   void createTask(){
  _Database.put('TASKS', tasks);
  }
  void createDatabase(){
     tasks = [
      {
        'title': 'Welcome',
        'isCompleted': true,
        '1st': true,
        'last': false,
        'isReminder': false,
        'datetime':DateTime.now(),
        'index':0
      },
      {
        'title': 'Create a new Task',
        'isCompleted': false,
        '1st': false,
        'last': true,
        'isReminder': false,
        'datetime':DateTime.now(),
        'index':1
      },
    ];
    _Database.put('TASKS',tasks);
  }
}
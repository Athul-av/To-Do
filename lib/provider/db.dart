import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class notedb with ChangeNotifier{

    List<String> notelist =[];

  void addnote(String note)async{
    final noteDB =  Hive.box<String>('notepad_db');
    noteDB.add(note);
    notelist.add(note);
    notifyListeners();
  }

 Future< List<String>> getallNote()async{
    final noteDB = Hive.box<String>('notepad_db');
    notelist.clear();
    notelist. addAll(noteDB.values);
    notifyListeners(); 
    return notelist;
  }
 
  Future<void> deleteNote(int index) async {
    final noteDB = Hive.box<String>('notepad_db'); 
    await noteDB.deleteAt(index); 
     notifyListeners(); 
    getallNote();
   
  }

   Future<void> editnote(int index, String value) async {
     final noteDB = Hive.box<String>('notepad_db');
    await noteDB.putAt(index, value); 
    notifyListeners();
    getallNote();
  }
 
}
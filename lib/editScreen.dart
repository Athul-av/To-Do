import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notepad/provider/db.dart';
import 'package:provider/provider.dart';

class Editnote extends StatelessWidget {
   Editnote({super.key, required this.notes, required this.index});
 
 final String notes;
final int index;
 final notecontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    notecontroller.text = notes.toString();
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        backgroundColor: Colors.teal, 
       
      ),
      floatingActionButton: FloatingActionButton(onPressed: (() {
                 
        editnote(context, index);
      }),
      backgroundColor: Colors.teal, 
      child: Icon(CupertinoIcons.checkmark_alt ),),
      body:Container( 
          color:Colors.white,  
           child: Card(
                color:Colors.white,
                child: Padding(
                  padding:const EdgeInsets.all(2.0),
                  child: TextFormField(
                    controller: notecontroller,
                   maxLines: 150,   
                    cursorColor: Colors.teal,
                    style:const TextStyle(fontSize: 19,color:Colors.black),  
                     
                  ),
                )
              ),
         )
    );
  }

   void editnote(context,index)async{
 final Notes = Provider.of<notedb>(context,listen: false);

 final notes =notecontroller.text; 

if(notes.isEmpty){
  return ;
}else{
 Notes.editnote(index,notes);
 Navigator.of(context).pop(); 
ScaffoldMessenger.of(context).showSnackBar(
    const  SnackBar(
      duration: Duration( seconds:1 ),  
      backgroundColor: Colors.teal,
        content: Text(
          'note edited',style: TextStyle(color: Colors.white),
        ),));
}
 
}
}
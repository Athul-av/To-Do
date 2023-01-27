import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/provider/db.dart';
import 'package:provider/provider.dart';

class TextFieldUser extends StatelessWidget {
   TextFieldUser({super.key});

 GlobalKey<FormState> formKey = GlobalKey();
  final _notecontroller =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading:IconButton(onPressed: (() {
          Navigator.of(context).pop();
        }), icon: Icon(Icons.arrow_back_ios_new)) ,
        
      ), 
      floatingActionButton: FloatingActionButton(onPressed: (() {
                 savenote(context);
        
      }),
      backgroundColor: Colors.teal, 
      child: Icon(CupertinoIcons.checkmark_alt ),),   
      body:
          Container( 
          color:Colors.white,  
           child: Card(
                color:Colors.white,
                child: Padding(
                  padding:const EdgeInsets.all(8.0),
                  child: TextFormField(
                    key: formKey,
                    controller: _notecontroller,
                   maxLines: 150,  
                    decoration:const InputDecoration.collapsed(hintText: "Enter your text here....",hintStyle: TextStyle(fontSize: 15,color:Color.fromARGB(255, 146, 146, 146))),
                    cursorColor: Colors.teal,
                    style:const TextStyle(fontSize: 19,color:Colors.black),  
                     
                  ),
                )
              ),
         )
      
    );
  }

  void savenote(context)async{
 final Notes = Provider.of<notedb>(context,listen: false);

 final notes = _notecontroller.text;

if(notes.isEmpty){
  return ;
}else{
 Notes.addnote(notes);
 Navigator.of(context).pop(); 
ScaffoldMessenger.of(context).showSnackBar(
    const  SnackBar(
      duration: Duration( seconds:1 ),  
      backgroundColor: Colors.teal,
        content: Text(
          'note saved',style: TextStyle(color: Colors.white),
        ),));
}
 
}
}
 


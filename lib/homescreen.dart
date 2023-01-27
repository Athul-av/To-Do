import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notepad/Textfield.dart';
import 'package:notepad/detailsscreen.dart';
import 'package:notepad/provider/db.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<notedb>(context,listen: false).getallNote(); 
    return Scaffold(
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,  
      appBar: AppBar(
         systemOverlayStyle: const SystemUiOverlayStyle( 
          statusBarColor: Colors.teal, 
              statusBarIconBrightness: Brightness.light,  
         ),
        
         title: const Text('Note Pad',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 ),), 
         centerTitle: true, 
        backgroundColor: Colors.teal, 
        toolbarHeight: 60,
      
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0, 
        backgroundColor: Colors.teal,
        onPressed: (() {
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> TextFieldUser()));
      }),
        child:const Icon(CupertinoIcons.text_bubble_fill,size: 27,) ,),
      body: 
           Consumer<notedb>(
            builder: (context, value, child) {
              return value.notelist.isEmpty?
              Container(
                color: Colors.white,
                child:const Center(child: Text('NO NOTES !',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold ),)),):
                Container(
                     color: Colors.white, 
                     child: ListView.builder(itemBuilder:(context, index) {
              return  Padding(
                padding:const EdgeInsets.only(left: 10,right: 10,top: 2 ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.11,
                  child: InkWell(
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Details(index: index,))); 
                    },
                    child: Card(
                      
                               shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(20),
                    ),
                      elevation: 3,
                     child: Padding(
                      padding:const EdgeInsets.only(left: 20,top: 0),
                      child: Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                      [
                         Container(
                          height: 26,
                          width: 210,
                         
                          child: Text(value.notelist[index],style:const TextStyle(fontFamily:'UbuntuCondensed',fontSize: 21,overflow: TextOverflow.ellipsis ),)),
                         IconButton(onPressed: (){
                          showAlertDialog(context,index); 
                          
                         }, icon:const Icon(CupertinoIcons.delete_simple,size: 19 ,))
 
                         ])),
                    ),
                  ),
                ),
              );
                     }, 
             itemCount: value.notelist.length, 
                             ), 
                   );
            },
           )
      
    );
  }

 
 
}

showAlertDialog(BuildContext context,index) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel",style: TextStyle(color: Colors.teal ),),
    onPressed:  () {
      Navigator.of(context).pop();  
    },
  );
  Widget continueButton = TextButton(
    child: Text("delete",style: TextStyle(color: Colors.teal ),),
    onPressed:  () {
      Provider.of<notedb>(context,listen: false).deleteNote(index); 
      Navigator.of(context).pop();  
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title:const Text("Are you sure?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
    content:const Text("do you want to delete the note?",style: TextStyle(fontSize: 13 )), 
    actions: [
      cancelButton,
      continueButton,  
    ],
  );
 
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
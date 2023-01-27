import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notepad/editScreen.dart';
import 'package:notepad/provider/db.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  const Details({super.key, this.index});
  final index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, 
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Editnote(notes:Provider.of<notedb>(context,listen: false).notelist[index],index: index,)));  
          }, child: Text('Edit',style: TextStyle(color: Colors.white ),))
        ],
      ),
      body: Consumer<notedb>(
        builder: ((context, value, child) {
          return Padding(

            padding: const EdgeInsets.all(10.0),
            child: Text(value.notelist[index], style:const TextStyle(fontSize: 19,color:Colors.black),  ),
          ); 
        }),
        ),
    );
  }
}
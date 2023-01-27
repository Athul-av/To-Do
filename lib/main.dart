
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:notepad/homescreen.dart';
import 'package:notepad/provider/db.dart';
import 'package:provider/provider.dart';


void main()async{
WidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();

  await Hive.openBox<String>('notepad_db');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
 
    return  ChangeNotifierProvider(
      create: (context) =>notedb(), 
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:ThemeData(
         primaryColor: Colors.blueGrey
          ),
          home: HomeScreen(),
        ),
    );
  
  }
}
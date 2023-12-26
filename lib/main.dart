import 'package:diceeproject/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:diceeproject/network DataBase/localdatabase.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MyDatabase.initDatabase();
   MyDatabase.getAllData();
   runApp(MyApp());
}
 class MyApp extends StatelessWidget {
   const MyApp({super.key});

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: HomeScreen()
     );
   }
 }



import 'package:flutter/material.dart';
class Result extends StatelessWidget {
  final bool male ;
  final int height ;
  final int weight  ;
  final int age;
  final String result;
  const Result({super.key, required this.male, required this.height, required this.weight, required this.age , required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text('Bmi'),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Gender',style: TextStyle(color: Colors.black , fontSize: 30 , fontWeight: FontWeight.bold),),
              SizedBox(
                width: 30,
              ),
              Text(male?"Male" : "Female", style: TextStyle(color: Colors.blue , fontSize: 30 , fontWeight: FontWeight.bold),),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('age',style: TextStyle(color: Colors.black , fontSize: 30 , fontWeight: FontWeight.bold),),
              SizedBox(
                width: 30,
              ),
              Text(age.toString() , style: TextStyle(color: Colors.blue , fontSize: 30 , fontWeight: FontWeight.bold),),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Result',style: TextStyle(color: Colors.black , fontSize: 30 , fontWeight: FontWeight.bold),),
              SizedBox(
                width: 30,
              ),
              Text(result, style: TextStyle(color: Colors.blue , fontSize: 30 , fontWeight: FontWeight.bold),),

            ],
          ),

        ],
      ),),
    );
  }
}

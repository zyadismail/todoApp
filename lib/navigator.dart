import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text('screen 1'),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>Screen2()));
            }, child: Text('next'))
          ],
        ),
      ),
    );
  }
}


class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text('screen2'),
      ),
    );
  }
}


import 'package:diceeproject/network%20DataBase/localdatabase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/note.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool on = false;
  List<Note> notes = [];
  List<Note> filterNotes = [];


  var scaffoldkey  = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();



  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var DateController = TextEditingController();


  @override
  void initState(){
    super.initState();
   setState(()  {
     MyDatabase.getAllData().then((value){
       value.forEach((element) {
         Note n = Note.fromJson(element);
         notes.add(n);
       });
       notes.forEach((element) {
         print(element.title);
       });
     });
    filterNotes = notes;
   });
  }
   void searchNote (String input){
    setState(() {
     filterNotes = notes.where((element) => element.title.toLowerCase().contains(input.toLowerCase())).toList();
    print(notes);
    });
   }
  @override
  Widget build(BuildContext context) {
    var  height = MediaQuery.of(context).size.height;
    var  width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldkey,
        backgroundColor:Color(0xffEDEDF5),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow(),
              SizedBox(height: height*0.02),
              TextField(
                decoration: InputDecoration(
                  hintText: 'search Note...',
                  hintStyle: GoogleFonts.lato(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: searchNote,
                
              ),
              SizedBox(height: height*0.05),
              Text(
                  'ALL TODOS',
                style: GoogleFonts.lato(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height*0.05),

               Expanded(
                 child: ListView.builder(
                   physics: BouncingScrollPhysics(),
                   itemBuilder: (context,index){
                     return Padding(
                       padding: EdgeInsets.symmetric(vertical: height*0.01),
                       child: GestureDetector(
                         onTap: (){
                           titleController.text = filterNotes[index].title;
                           descriptionController.text = filterNotes[index].description;
                           DateController.text = filterNotes[index].date;
                           scaffoldkey.currentState?.showBottomSheet((context) =>
                               buildButtomsheet(height, width, context,float: false,
                               id: filterNotes[index].id,
                                 index: index,
                               ));
                         },
                         child: Card(
                           child: ListTile(
                             title: RichText(
                               text: TextSpan(
                                 text: '${filterNotes[index].title}\n',
                                 style: GoogleFonts.lato(
                                   fontSize: 22,
                                   color: Colors.black,
                                   fontWeight: FontWeight.bold,
                                   decoration:filterNotes[index].finish? TextDecoration.lineThrough:null,
                                 ),
                                 children: [
                                   TextSpan(
                                       text: '${filterNotes[index].description}',
                                       style: GoogleFonts.lato(
                                         fontSize: 18,
                                         fontWeight: FontWeight.normal,

                                       )
                                   )
                                 ],
                               ),
                             ),
                             subtitle: Padding(
                               padding:  EdgeInsets.only(top: height*0.01),
                               child: Text('${filterNotes[index].date}',
                                 style: GoogleFonts.lato(
                                     fontWeight: FontWeight.bold
                                 ),
                               ),
                             ),
                             leading: Transform.scale(
                               scale: 1.5,
                               child: Checkbox(
                                 value:filterNotes[index].finish,
                                 onChanged: (value){
                                   setState(() {
                                     filterNotes[index].finish = value!;
                                     MyDatabase.updateRow(id:filterNotes[index].id, finish:filterNotes[index].finish);
                                   });
                                 },
                                 activeColor: Colors.green,
                               ),
                             ),
                             trailing:GestureDetector(
                               onTap: (){
                               showDialog(context: context, builder: (_){
                                 return AlertDialog(
                                   title: Text(
                                       'Delete${filterNotes[index].title} Note',
                                     style: GoogleFonts.lato(),
                                   ),
                                   content:Text(
                                     'Are you sure to delete',
                                     style: GoogleFonts.lato(),
                                   ),
                                   actions: [
                                     TextButton(onPressed: (){
                                       Navigator.pop(context);
                                     }, child:Text('No')),
                                     TextButton(onPressed: (){
                                       setState(() {
                                       MyDatabase.deleteRow(id: filterNotes[index].id);
                                       notes.removeAt(index);
                                       filterNotes = notes;
                                       Navigator.pop(context);

                                       });
                                     }, child:Text('yes')),
                                   ],
                                 );
                               });
                               },
                               child: Container(
                                 padding: EdgeInsets.all(5),
                                 decoration: BoxDecoration(
                                   color: Colors.red,
                                   borderRadius: BorderRadius.circular(8),

                                 ),
                                 child: Icon(Icons.delete,color: Colors.white,size: 35,),
                               ),
                             ) ,

                           ),
                         ),
                       ),
                     );
                     },
                   itemCount: filterNotes.length,
                 ),
               ),
            ],
          ),
        ),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          titleController.clear();
          descriptionController.clear();
          DateController.clear();
         scaffoldkey.currentState!.showBottomSheet((context){
           return buildButtomsheet(height, width, context,float: true);
         });
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ) ,


    );
  }

  SizedBox buildButtomsheet(double height, double width, BuildContext context,{ required bool float,int?id,int?index}) {
    return SizedBox(
         height:height*0.6,
           width: width,
           child: Container(color: Colors.white,
           child: Padding(
             padding:  EdgeInsets.symmetric(horizontal: width*0.03 , vertical: height*0.01),
             child: Form(
               key: formkey,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Text('title',
                   style: GoogleFonts.lato(
                     color: Colors.black,
                     fontSize: 25,
                     fontWeight: FontWeight.bold,
                   ),
                   ),
                   SizedBox(height: height*0.01),
                   buildTextFormField(
                     controller: titleController,
                     text: 'Input title',
                     function: (value){
                       if(value!.isEmpty){
                         return 'please enter title';
                       }
                     }
                   ),
                   SizedBox(height: height*0.02),

                   Text('description',
                     style: GoogleFonts.lato(
                       color: Colors.black,
                       fontSize: 25,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   SizedBox(height: height*0.01),
                   buildTextFormField(
                       controller: descriptionController,
                       text: 'Input description',
                       function: (value){
                         if(value!.isEmpty){
                           return 'please enter description';
                         }
                       }
                   ),

                   Text('Date',
                     style: GoogleFonts.lato(
                       color: Colors.black,
                       fontSize: 25,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   SizedBox(height: height*0.01),
                   buildTextFormField(
                       controller: DateController,
                       text: 'Input Date',
                       function: (value){
                         if(value!.isEmpty){
                           return 'please enter date';
                         }
                       }
                   ),
                   SizedBox(height: height*0.02),

                   Center(
                     child: MaterialButton(onPressed: ()async{
                       if(formkey.currentState!.validate()){
                        float? await MyDatabase.insertRow(
                             title: titleController.text,
                             description: descriptionController.text,
                             date: DateController.text,
                         ).then((value){
                           Note n = Note(
                             title: titleController.text,
                             description: descriptionController.text,
                             date: DateController.text,
                             id : value,
                           );
                           setState(() {
                             notes.add(n);
                             filterNotes = notes;
                           });
                           Navigator.pop(context);
                           var snackbar = SnackBar(
                             duration: Duration(seconds: 2),
                               content: Text('note${n.title} Add Succssefully',
                           style: GoogleFonts.lato(
                             color: Colors.white,
                             fontWeight: FontWeight.bold),
                           ),
                             backgroundColor: Colors.green,
                           );
                           ScaffoldMessenger.of(context).showSnackBar(snackbar);
                         }):await MyDatabase.updateallRow(
                            id: id!,
                            title: titleController.text,
                            description: descriptionController.text,
                            date: DateController.text,
                        ).then((value){
                              notes[index!].title = titleController.text;
                              notes[index!].description = descriptionController.text;
                              notes[index!].date = DateController.text;
                        });
                       }

                     },
                     child:Text(float? 'insert': 'update',
                       style:  TextStyle(color: Colors.white),),
                       color: Colors.red,
                     ),
                   ),




                 ],
               ),
             ),
           ),
           ),
         );
  }

  TextFormField buildTextFormField({required controller,required text,required String? Function(String?)?function}) {
    return TextFormField(
                     controller: controller,
                    decoration: InputDecoration(
                      hintText: text,
                    ),
                  validator: function,
                   );
  }

  Row buildRow() {
    return const Row(
              children: [
                Icon(Icons.menu,
                size: 35),
                Spacer(),
                CircleAvatar(
                  radius: 25,
                backgroundImage: NetworkImage('https://www.searchenginejournal.com/wp-content/uploads/2022/04/personal-branding-62792f2def4b9-sej.png'),
                ),
              ],
            );
  }
}

import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/sql/sqlite_helper.dart';

import 'widget/bottom_sheet.dart';
import 'widget/list_note.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Task'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  String textValue ="";
  List<Note> items = [];
  _loadNote() async{
    var item = await _dbHelper.getNotes();
    setState(() {
      items.clear();
      items.addAll(item);
    });
  }
  _handleAddData(Note note) async{
    await _dbHelper.addNote(note);
    _loadNote();

  }
  _handleDeleteData(int id) async{
    await _dbHelper.deleteNote(id);
    _loadNote();
  }
  _handleEditData(Note note) async{
    await _dbHelper.updateNote(note);
    _loadNote();
  }

  @override
  void initState() {
    super.initState();
    _loadNote();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title:Text(widget.title),backgroundColor: Colors.blue,),
        body:  items.isEmpty ? const Center(
          child: Text('Add your task',style: TextStyle(
            color: Colors.blue,
            fontSize: 20
          ),),
        ) :Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child:  ListNote(items,_handleDeleteData,_handleEditData),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context){
                  return BottomSheetContent(onNoteAdded: _handleAddData);
                });
          }
          ,child: const Icon(Icons.add,size: 40)
          ,),
      ),
    );
  }
}
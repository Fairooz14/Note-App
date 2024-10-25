import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sqflite_example/add_notes.dart';
// import 'package:flutter_sqflite_example/update_notes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note_app/add_notes.dart';
import 'package:note_app/update_notes.dart';

import 'database/db_helper.dart';
import 'model/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //declared variables
  late DbHelper dbHelper;
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    //initializing dbHelper
    dbHelper = DbHelper.instance;

    //load notes on startup
    loadAllNotes();
  }

  //for loading data from db
  Future loadAllNotes() async {
    final data = await dbHelper.getAllData();
    setState(() {
      //This line converts a list of map entries (database records) into a list of Note objects using the Note.fromMap method, making it easier to work with custom objects in your app.
      //each element is a map, represented by e
      notes = data.map((e) => Note.fromMap(e)).toList();
    });
  }

  //for deleting a note
  Future deleteNote(int id) async {
    int check = await dbHelper.deleteData(id);
    if (check > 0) {
      Fluttertoast.showToast(msg: "Note deleted successfully");
      loadAllNotes();
    } else {
      Fluttertoast.showToast(msg: "Failed to delete note");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 234, 207),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 234, 207),
        title: const Text(
          "Notes",
          style: TextStyle(color: Color.fromARGB(255, 2, 2, 2)),
        ),
      ),
      body: notes.isEmpty
          ? const Center(child: Text("No notes available!"))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                Note note = notes[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateNotes(notes: note)));
                    }, // for clickable list item
                    title: Text(
                      note.title!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(note.description!),
                    leading: const Icon(
                      Icons.note_alt_outlined,
                      size: 40,
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                        size: 40,
                      ),
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogBackgroundColor: const Color.fromARGB(255, 228, 228, 218),
                          dialogType: DialogType.warning,
                          headerAnimationLoop: false,
                          animType: AnimType.bottomSlide,
                          title: 'Delete',
                          desc: 'Want to delete note ?',
                          buttonsTextStyle:
                              const TextStyle(color: Colors.white),
                          showCloseIcon: true,
                          btnCancelOnPress: () {},
                          btnOkText: 'YES',
                          btnCancelText: 'NO',
                          btnOkOnPress: () {
                            deleteNote(note.id!);
                            Get.back();
                          },
                        ).show();
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        // shape: CircleBorder(
        //   side: BorderSide(color: Colors.blue),
        // ),  //for making circle shape
        backgroundColor: const Color.fromARGB(255, 84, 45, 10),
        tooltip: "Add Note",
        mini: false,
        onPressed: () {
          Get.to(AddNotes());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

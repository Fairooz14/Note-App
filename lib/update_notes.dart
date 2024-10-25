import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'database/db_helper.dart';
import 'home_page.dart';
import 'model/note.dart';

class UpdateNotes extends StatefulWidget {
  final notes;
  const UpdateNotes({super.key, required this.notes});

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  late DbHelper dbHelper;

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  final GlobalKey<FormState> noteFormKey = GlobalKey();

  int? id;

  //add notes to database
  Future updateNotes(int id) async {
    final updatedNote = Note(
      title: titleController.text,
      description: descriptionController.text,
    );

    int check = await dbHelper.updateData(updatedNote.toMap(), id);
    print("Check=$check");
    if (check > 0) {
      Get.snackbar("Updated", "Note Updated",
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(HomePage());
    } else {
      Get.snackbar("Error", "Error in note update",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DbHelper.instance;
    titleController.text = widget.notes.title;
    descriptionController.text = widget.notes.description;
    id = widget.notes.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 234, 207),
      appBar: AppBar(
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 5, 5, 5)),
        backgroundColor: const Color.fromARGB(255, 233, 234, 207),
        title: Text(
          "Updates Notes",
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Form(
        key: noteFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Title",
                  prefixIcon: const Icon(Icons.note_alt_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter note title";
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Description",
                  prefixIcon: const Icon(Icons.notes),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter description";
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color.fromARGB(255, 84, 45, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  if (noteFormKey.currentState!.validate()) {
                    noteFormKey.currentState!.save();

                    updateNotes(id!);
                  }
                },
                child: Text(
                  "Update Notes",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

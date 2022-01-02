import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class UpdateNoteScreen extends StatefulWidget {
  DocumentSnapshot documentSnapshot;

   UpdateNoteScreen(this.documentSnapshot);

  @override
  _UpdateNoteScreenState createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  final CollectionReference _todo = FirebaseFirestore.instance.collection('todo');

  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Update Notes'),

          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Edit Title'
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: notesController,
            decoration: const InputDecoration(
                labelText: 'Edit Notes'
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),

          ElevatedButton(
            child: const Text('Update'),
            onPressed: () async{
              final String title = titleController.text;
              final String notes = notesController.text;

              if(title != null && notes != null){
                await _todo.doc(widget.documentSnapshot.id).update({
                  "title" : title, "notes": notes
                });

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You have successfully update!'))
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );

              }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('not update'))
                );
               }
             },
            )

        ],
      ),
    );
  }
}

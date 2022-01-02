import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final CollectionReference _todo = FirebaseFirestore.instance.collection('todo');

  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Add Notes'),

          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Add Title'
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: notesController,
            decoration: const InputDecoration(
                labelText: 'Add Notes'
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),

          ElevatedButton(
            child: const Text('ADD'),
            onPressed: () async{
              final String title = titleController.text;
              final String notes = notesController.text;

              if(title != null && notes != null){

                await _todo.add({"title" : title, "notes": notes});

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('You have successfully added new recodes for db'))
                 );

                 Navigator.push(
                  context,
                 MaterialPageRoute(builder: (context) => const HomeScreen()),
                );

              }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please check your title and notes'))
                );
               }
             },
            )

        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytodo_app/screen/update_note.dart';

import 'add_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference _todo = FirebaseFirestore.instance.collection('todo');
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder(
         stream: _todo.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
           if(streamSnapshot.hasData){
             return ListView.builder(
               itemCount: streamSnapshot.data?.docs?.length,
               itemBuilder: (context, index){
                 final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                 return Card(
                   child: Container(
                     width: width,
                     height: 100.0,
                     color: Colors.white70,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(documentSnapshot['title']),
                         Text(documentSnapshot['notes']),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                             IconButton(
                                 onPressed: (){
                                   _deleteTodo(documentSnapshot.id);
                                 },
                                 icon: const Icon(Icons.delete)
                             ),

                             IconButton(
                                 onPressed: (){
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) =>
                                         UpdateNoteScreen(documentSnapshot),
                                   ));
                                 },
                                 icon: const Icon(Icons.edit)
                             ),

                           ],
                         )
                       ],

                     ),

                   ),
                 );
               },

             );
           }
           return const Center(
             child: CircularProgressIndicator(),
           );
        }

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
        },
        child: const Icon(
          Icons.add
        ),
      ),
    );
  }


  Future<void> _deleteTodo(String id) async{
    await _todo.doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted a toto note')));
  }
}

import 'package:flutter/material.dart';
import 'package:notes/edit_page.dart';
import 'global_var.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context,index){
            return Padding(
              padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
              child: Dismissible(
                background: Container(
                  color: Colors.red,
                  child: const Center(child: Text("Delete")),
                ),
                key:  ValueKey<Map<String,String>>(notes[index]),
                onDismissed: (
                    DismissDirection direction) {
                  setState(() {
                    notes.removeAt(index);
                  });
                },
                child: Card(
                  child: ListTile(
                    onTap: ()=>{
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=> EditPage(index:index))
                      )
                    },
                    title: Text(notes[index]["title"]!),
                  ),
                ),
              ),
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> const EditPage())
          );
        },
      ),
    );
  }
}

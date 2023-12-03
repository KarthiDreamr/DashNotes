import 'package:flutter/material.dart';
import 'package:notes/pages/edit_page.dart';
import 'package:notes/providers/shared_preference_provider.dart';
import 'package:provider/provider.dart';

import '../providers/notes_list_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<NotesListProvider>(builder: (context, notesList, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
        ),
        body: ListView.builder(
          itemCount: context.watch<NotesListProvider>().notesList.length,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Dismissible(
                background: Container(
                  color: Colors.red,
                  child: const Center(child: Text("Delete")),
                ),
                key: ValueKey<DateTime>(
                  DateTime.now(),
                ),
                onDismissed: (DismissDirection direction) {
                  context.read<NotesListProvider>().removeNotes(index);
                  context.read<SharedPreferenceProvider>().updateSharedPreferences(context.read<NotesListProvider>().notesList);
                },
                child: Card(
                  child: ListTile(
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditPage(index: index)))
                    },
                    title: Text(context
                        .read<NotesListProvider>()
                        .notesList[index]["title"]!),
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
              MaterialPageRoute(
                builder: (context) => EditPage(),
              ),
            );
          },
        ),
      );
    },
    );
  }
}

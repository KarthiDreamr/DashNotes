import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes/edit_page.dart';
import 'package:notes/shared_preference_provider.dart';
import 'package:provider/provider.dart';

import 'notes_list_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    context.read<SharedPreferenceProvider>().prefs.setStringList(
        "notesList",
        Provider.of<NotesListProvider>(context)
            .notesList
            .map((e) => jsonEncode(e))
            .toList());

    print(
        "-------------------------------------------------------------------");
    print("setted");
    print(
        "-----------------------------------------------------------------------------------------");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<SharedPreferenceProvider>().initPref(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          if (context
                  .read<SharedPreferenceProvider>()
                  .prefs
                  .getStringList("notesList") !=
              null) {
            List encodedJsonList = context
                .read<SharedPreferenceProvider>()
                .prefs
                .getStringList("notesList")!;
            List decodedJsonList =
                encodedJsonList.map((e) => jsonDecode(e)).toList();
            context.watch<NotesListProvider>().setNotesList = decodedJsonList;
          }

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
                    key: ValueKey<Map<String, dynamic>>(
                        context.read<NotesListProvider>().notesList[index]),
                    onDismissed: (DismissDirection direction) {
                      context.read<NotesListProvider>().removeNotes(index);
                      context
                          .read<SharedPreferenceProvider>()
                          .prefs
                          .setStringList(
                              "notesList",
                              Provider.of<NotesListProvider>(context)
                                  .notesList
                                  .map((e) => jsonEncode(e))
                                  .toList());
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
        } else {
          return const Scaffold(body: CircularProgressIndicator());
        }
      },
    );
  }
}

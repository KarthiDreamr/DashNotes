import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes/notes_list_provider.dart';
import 'package:notes/shared_preference_provider.dart';
import 'package:provider/provider.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key, this.index});

  final int? index;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (index != null) {
      titleController.text =
          context.read<NotesListProvider>().notesList[index!]["title"]!;
      descriptionController.text =
          context.read<NotesListProvider>().notesList[index!]["subtitle"]!;
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 110),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: titleController,
                  maxLength: 24,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Title'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: TextFormField(
                  validator: (value) {
                    return null;
                  },
                  minLines: 3,
                  maxLines: 7,
                  keyboardType: TextInputType.multiline,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),
              ),
              Row(
                children: [
                  (index != null)
                      ? ElevatedButton.icon(
                          label: const Text("Delete"),
                          onPressed: () {
                            context
                                .read<NotesListProvider>()
                                .removeNotes(index!);

                            context
                                .watch<SharedPreferenceProvider>()
                                .prefs
                                .setStringList(
                                    "notesList",
                                    Provider.of<NotesListProvider>(context)
                                        .notesList
                                        .map((e) => jsonEncode(e))
                                        .toList());

                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.delete),
                        )
                      : Container(),
                  const Expanded(
                    child: SizedBox(
                      width: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Future.delayed(Duration.zero, () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (index != null) {
                            context.watch<NotesListProvider>().updateNotes(
                                index!, "title", titleController.text);
                            context.watch<NotesListProvider>().updateNotes(
                                index!, "subtitle", descriptionController.text);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Changes saved!')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Notes created!')),
                            );

                            context.watch<NotesListProvider>().addNotes({
                              "title": titleController.text,
                              "subtitle": descriptionController.text
                            });
                          }

                          context
                              .watch<SharedPreferenceProvider>()
                              .prefs
                              .setStringList(
                                  "notesList",
                                  context
                                      .read<NotesListProvider>()
                                      .notesList
                                      .map((e) => jsonEncode(e))
                                      .toList());

                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

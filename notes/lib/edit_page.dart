import 'package:flutter/material.dart';
import 'package:notes/global_var.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, this.index});

  final int? index;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.index != null) {
      titleController.text = notes[widget.index!]["title"]!;
      descriptionController.text = notes[widget.index!]["subtitle"]!;
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
              SizedBox(
                width: 250,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: titleController,
                  onChanged: (value) {
                    if(value!=null && value.isEmpty){
                      if (widget.index != null) {
                        notes[widget.index!]["title"] = value;
                      }
                    }
                    else{
                      setState(() {
                        titleController.text= notes[widget.index!]["title"]!;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Title Cannot be Empty!')),
                      );
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  onChanged: (value) {
                    if (widget.index != null) {
                      notes[widget.index!]["subtitle"] = value;
                    }
                  },
                ),
              ),
              Row(children: [
                (widget.index != null)
                    ? IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            notes.removeAt(widget.index!);
                          });
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
                  child: IconButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        if (widget.index != null) {
                          notes[widget.index!]["title"] = titleController.text;
                          notes[widget.index!]["subtitle"] =
                              descriptionController.text;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Changes saved!')),
                          );
                        } else {
                          setState(() {
                            notes.add({
                              "title": titleController.text,
                              "subtitle": descriptionController.text
                            });
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Notes created!')),
                          );
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    icon: const Icon(Icons.save),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

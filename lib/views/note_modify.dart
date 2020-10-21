import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testREST/models/note.dart';
import 'package:testREST/models/note_insert.dart';
import 'package:testREST/services/notes_service.dart';

class NotesMotify extends StatefulWidget {
  final String id;
  const NotesMotify({Key key, this.id});

  @override
  _NotesMotifyState createState() => _NotesMotifyState();
}

class _NotesMotifyState extends State<NotesMotify> {
  bool get isEditing => widget.id != null;

  NotesService get notesService => GetIt.I<NotesService>();

  String errorMessage;
  Note note;

  TextEditingController _idController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _reviewController = TextEditingController();
  TextEditingController _spiritController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _degreeController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      notesService.getNote(widget.id).then((response) {
        setState(() {
          _isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occured';
        }
        note = response.data;
        _idController.text = note.id;
        _titleController.text = note.name;
        _reviewController.text = note.review;
        _spiritController.text = note.spirit;
        _amountController.text = note.amount.toString();
        _degreeController.text = note.degree.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit note' : 'Create a note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(hintText: 'Note name'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _degreeController,
                        decoration: InputDecoration(hintText: 'Note degree'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _reviewController,
                        decoration: InputDecoration(hintText: 'Note review'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _amountController,
                        decoration: InputDecoration(hintText: 'Note amount'),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _spiritController,
                        decoration: InputDecoration(hintText: 'Lux or Alpha'),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 35,
                        child: RaisedButton(
                            onPressed: () async {
                              if (isEditing) {
                                setState(() {
                                  _isLoading = true;
                                });

                                final note = NoteInsert(
                                    id: _idController.text,
                                    degree: _degreeController.text,
                                    amount: _amountController.text,
                                    name: _titleController.text,
                                    review: _reviewController.text,
                                    spirit: _spiritController.text);
                                final result =
                                    await notesService.updateNote(note);

                                setState(() {
                                  _isLoading = false;
                                });

                                final title = 'Done';
                                final text = result.error
                                    ? (result.errorMessage ??
                                        "an error occured")
                                    : "Your note was updated";

                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text(title),
                                    content: Text(text),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Ok'))
                                    ],
                                  ),
                                ).then((data) {
                                  if (result.data) {
                                    Navigator.of(context).pop();
                                  }
                                });
                              } else {
                                setState(() {
                                  _isLoading = true;
                                });

                                final note = NoteInsert(
                                    id: _idController.text,
                                    degree: _degreeController.text,
                                    amount: _amountController.text,
                                    name: _titleController.text,
                                    review: _reviewController.text,
                                    spirit: _spiritController.text);
                                final result =
                                    await notesService.createNote(note);

                                setState(() {
                                  _isLoading = false;
                                });

                                final title = 'Done';
                                final text = result.error
                                    ? (result.errorMessage ??
                                        "an error occured")
                                    : "Your note was created";

                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text(title),
                                    content: Text(text),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Ok'))
                                    ],
                                  ),
                                ).then((data) {
                                  if (result.data) {
                                    Navigator.of(context).pop();
                                  }
                                });
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:testREST/models/api_responce.dart';
import 'package:testREST/models/note.dart';
import 'package:testREST/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:testREST/models/note_insert.dart';

class NotesService {
  static const API = 'https://igorapy.herokuapp.com';
  static const headers = {"Content-Type": "application/json"};

  Future<APIResponce<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/vodka', headers: headers).then(
      (data) {
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body);
          final notes = <NoteForListing>[];
          for (var item in jsonData) {
            notes.add(NoteForListing.fromJson(item));
          }
          return APIResponce<List<NoteForListing>>(data: notes);
        }
        return APIResponce<List<NoteForListing>>(
            error: true, errorMessage: 'Wops... An error occured!');
      },
    ).catchError((_) => APIResponce<List<NoteForListing>>(
        error: true, errorMessage: 'Wops... An error occured!'));
  }

  Future<APIResponce<Note>> getNote(String id) {
    return http.get(API + '/vodka?id=' + id, headers: headers).then(
      (data) {
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body);

          return APIResponce<Note>(data: Note.fromJson(jsonData[0]));
        }
        return APIResponce<Note>(
            error: true, errorMessage: 'Wops... An error occured!');
      },
    ).catchError((_) => APIResponce<Note>(
        error: true, errorMessage: 'Wops... An error occured!'));
  }

  Future<APIResponce<bool>> createNote(NoteInsert item) {
    return http
        .post(API + '/vodka',
            headers: headers, body: json.encode(item.toJson()))
        .then(
      (data) {
        if (data.statusCode == 200) {
          return APIResponce<bool>(data: true);
        }
        return APIResponce<bool>(
            error: true, errorMessage: 'Wops... An error occured!');
      },
    ).catchError((_) => APIResponce<bool>(
            error: true, errorMessage: 'Wops... An error occured!'));
  }

  Future<APIResponce<bool>> updateNote(NoteInsert item) {
    return http
        .put(API + '/vodka', headers: headers, body: json.encode(item.toJson()))
        .then(
      (data) {
        if (data.statusCode == 200) {
          return APIResponce<bool>(data: true);
        }
        return APIResponce<bool>(
            error: true, errorMessage: 'Wops... An error occured!');
      },
    ).catchError((_) => APIResponce<bool>(
            error: true, errorMessage: 'Wops... An error occured!'));
  }

  Future<APIResponce<bool>> deleteNote(String id) {
    return http.delete(API + '/vodka/' + id, headers: headers).then(
      (data) {
        if (data.statusCode == 200) {
          return APIResponce<bool>(data: true);
        }
        return APIResponce<bool>(
            error: true, errorMessage: 'Wops... An error occured!');
      },
    ).catchError((_) => APIResponce<bool>(
        error: true, errorMessage: 'Wops... An error occured!'));
  }
}

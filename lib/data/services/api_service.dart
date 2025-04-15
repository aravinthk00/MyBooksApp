import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_books/data/model/book.dart';

class ApiService{
  static const String _baseUrl = 'https://openlibrary.org';

   Future<Book> fetchTasks(int limit, int offset) async {

    final response = await http.get(Uri.parse('$_baseUrl/subjects/novel.json?limit=$limit&offset=$offset'));

    debugPrint("my_books url :- ${response.request!.url}");

    if(response.statusCode == 200){
      debugPrint("my_books response ${response.body}");
      final data = Book.fromJson(jsonDecode(response.body));
      // debugPrint("my_books response status ${data.key}");
      // final allBookList= data.map((e) => Book.fromJson(e)).toList();
      // // if(data.sCode == 1){
         return data;
      // final List books = json.decode(response.body);
      // return books.map((json) => Book.fromJson(json)).toList();
      // }
    }else{
      throw Exception('Failed to load books');
    }

  }
}
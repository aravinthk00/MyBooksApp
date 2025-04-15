import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/book.dart';
import '../data/services/api_service.dart';

class BookProvider extends ChangeNotifier {


  List<Works> _myBooksList = [];
  Book _myBookApiResponse = Book();
  bool _isLoading = false;
  bool _isSearching = false;
  List<Works> _searchResults = [];
  int offset = 0;
  final int limit = 10;
  bool _hasMore = true;
  late List<Works> _favourites = [];

  Book get myBookData => _myBookApiResponse;
  List<Works> get myBooksList => _myBooksList;
  List<Works> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  bool get hasMore => _hasMore;
  List<Works> get favourites => _favourites;

  BookProvider() {
    fetchBooks();
    debugPrint("book provider");
  }

  Future<void> fetchBooks() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      _myBookApiResponse = await ApiService().fetchTasks(limit, offset);

      debugPrint("fetch book list ${_myBookApiResponse.name}");

      if (_myBookApiResponse.works!.isNotEmpty) {
        _myBooksList.addAll(_myBookApiResponse.works!);
        offset += limit;
      }else{
        _hasMore = false;
      }
      debugPrint("unfiltered books  ${_myBooksList.length}");
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchTasks(String query) {
    if (query.isNotEmpty) {
      _searchResults =
          _myBooksList.where((book) {
            return book.title.toString().contains(query) ||
                book.key.toString().contains(query);
          }).toList();
    } else {
      _searchResults = _myBooksList;
    }
    notifyListeners();
  }

  void setSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  Future<void> refreshData() async {
    fetchBooks();
  }

  // void toggleFavourite(Works book) {
  //   if (_favourites.contains(book)) {
  //     _favourites.remove(book);
  //   } else {
  //     _favourites.add(book);
  //   }
  //   notifyListeners();
  // }
  //
  // bool isFavourite(Works book) => _favourites.contains(book);

  void toggleFavourite(Works book) {
    final isFav = _favourites.any((b) => b.key == book.key);
    if (isFav) {
      _favourites.removeWhere((b) => b.key == book.key);
    } else {
      _favourites.add(book);
    }
    saveFavorites();
    notifyListeners();
  }

  bool isFavourite(Works book) => _favourites.any((b) => b.key == book.key);

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favJson = _favourites.map((b) => json.encode(b.toJson())).toList();
    await prefs.setStringList('favorites', favJson);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favJson = prefs.getStringList('favorites') ?? [];
    _favourites = favJson.map((favt) => Works.fromJson(json.decode(favt))).toList();
    notifyListeners();
  }
}

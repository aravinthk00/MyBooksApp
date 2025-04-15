import 'package:flutter/material.dart';
import 'package:my_books/view/widget/book_list_tile.dart';
import 'package:my_books/view_model/book_provider.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});
  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<BookProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourites",
          style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(255, 96, 61, 1),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
      ),
      backgroundColor: Colors.white,
      body: vm.favourites.isNotEmpty
      ? ListView.builder(
        itemCount: vm.favourites.length,
        itemBuilder: (context, index) {
          final book = vm.favourites[index];
          return BookTileWidget(myBook: book, index: index);
        },
      )
      : SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        // Required for scroll even when content is small
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height,
          // Ensures pull-to-refresh gesture works
          child: const Text(
            "No favourites added yet.",
            maxLines: 2,
            softWrap: true,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
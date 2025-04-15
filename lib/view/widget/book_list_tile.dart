import 'package:flutter/material.dart';
import 'package:my_books/utills/util.dart';
import 'package:my_books/view_model/book_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../data/model/book.dart';

class BookTileWidget extends StatelessWidget {
  final Works myBook;
  final int index;

  const BookTileWidget({super.key, required this.myBook, required this.index});

  @override
  Widget build(BuildContext context) {
    final bookAuthors = myBook.authors;
    var subjectList = myBook.subject!.join("");
    print(subjectList);
    final vm = Provider.of<BookProvider>(context);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/details',
          arguments: myBook),
      child: Card(
        elevation: 4,
        color: Colors.white,
        margin: EdgeInsets.all(6.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    height: 70,
                    margin: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orangeAccent.shade100)
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                          child: Image.asset(
                            'assets/icon/icon.png',
                            fit: BoxFit.cover,

                          )),
                    ),
                  )),
              Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          myBook.title.toString(),
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle( color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "By : ${bookAuthors!.first.name ?? "Unknown"}",
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(color: Colors.black87, fontSize: 14,fontWeight: FontWeight.w400),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                                flex: 1,
                                child: Text(
                                  "Publish:",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  myBook.firstPublishYear.toString(),
                                  style: const TextStyle(color: Colors.black87, fontSize: 12,fontWeight: FontWeight.w400),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                      ],
                    ),
                  )),
              Expanded(child: IconButton(
                icon: Icon(
                    vm.isFavourite(myBook) ? Icons.favorite : Icons.favorite_border,
                color:  Colors.orange),
                onPressed: () => {
                  vm.toggleFavourite(myBook),
                  Utils.toastMessage(vm.isFavourite(myBook) ?"Book added to my favourites." : "Book removed from my favourites.")},
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

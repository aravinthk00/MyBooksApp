import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/book_provider.dart';
import '../../view_model/network_status_provider.dart';
import '../widget/book_list_tile.dart';
import '../widget/no_internet_screen.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    bookProvider.fetchBooks();

    _scrollController =
        ScrollController()..addListener(() {
          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
            bookProvider.fetchBooks();
          }
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 35,
              height: 35,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/icon.png',
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "MyBooks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "Books : ",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Consumer<BookProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return const Text(
                            "00",
                            style: TextStyle(fontSize: 10),
                          );
                        }

                        return Text(
                          provider.myBooksList.length.toString(),
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(255, 96, 61, 1),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/favourites'),
            icon: Icon(Icons.favorite_outlined),
          ),
        ],
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Consumer<NetworkStatusProvider>(
        builder: (context, network, child) {
          if (!network.isOnline) {
            return NoInternetScreen();
          }

          return Consumer<BookProvider>(
            builder: (context, provider, child) {

              if(provider.isLoading){
                return Center(child: CircularProgressIndicator(color: Colors.blueAccent,),);
              }

              return RefreshIndicator(
                color: Colors.blueAccent,
                onRefresh: () async => provider.fetchBooks(),
                child: provider.myBooksList.isNotEmpty
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                provider.myBooksList.length +
                                (provider.hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < provider.myBooksList.length) {
                                final book = provider.myBooksList[index];
                                return BookTileWidget(
                                  myBook: book,
                                  index: index,
                                );
                              } else {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
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
                              "No data available. Please refresh the screen or try again later!!",
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

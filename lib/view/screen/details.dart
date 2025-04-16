import 'package:flutter/material.dart';
import 'package:my_books/view_model/book_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../data/model/book.dart';
import '../../utills/util.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argsBookInfo = ModalRoute.of(context)!.settings.arguments as Works;
    final vm = Provider.of<BookProvider>(context);
    var subjectList = argsBookInfo.subject!.join(", ");
    var iaCollectionList = argsBookInfo.iaCollection!.join(", ");

    print(subjectList);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book Information",
          style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(255, 96, 61, 1),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Card(
              color: Colors.amber.shade50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 150,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color:  Colors.orangeAccent.shade100,
                                    width: 2.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        10.0) //                 <--- border radius here
                                    ),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Center(
                                    child: Image.asset(
                                      'assets/icon/icon.png',
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 1.5,
                        color: Colors.grey,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(argsBookInfo.title.toString(),
                                softWrap: true,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text(argsBookInfo.authors!.first.name.toString(),
                                softWrap: true,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Expanded(
                                    flex: 5,
                                    child: Text(
                                      "First Publish Year:",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      argsBookInfo.firstPublishYear.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.w400),
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(vm.isFavourite(argsBookInfo) ? Icons.favorite : Icons.favorite_border,
                                    color: Colors.orange,),
                                    onPressed: () => {
                                      vm.toggleFavourite(argsBookInfo),
                                      Utils.toastMessage(vm.isFavourite(argsBookInfo) ?"Book added to my favourites." : "Book removed from my favourites.")},
                                  ),
                                ),)
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 2,
                            child: Text(
                              "Subject :",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400),
                            )),
                        Expanded(
                          flex: 5,
                          child: ReadMoreText(
                            subjectList.toString(),
                                      trimMode: TrimMode.Line,
                                      trimLines: 2,
                                      colorClickableText: Colors.pink,
                                      trimCollapsedText: 'Read more',
                                      trimExpandedText: '...Read less',
                                      moreStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                      lessStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 2,
                            child: Text(
                              "Collections:",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400),
                            )),
                        Expanded(
                          flex: 6,
                          child: ReadMoreText(
                            iaCollectionList.toString(),
                            trimMode: TrimMode.Line,
                            trimLines: 2,
                            colorClickableText: Colors.pink,
                            trimCollapsedText: 'Read more',
                            trimExpandedText: '...Read less',
                            moreStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            lessStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ExpansionTile(
                    title: const Text(
                      "More Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20.0),
                    children: [
                      Row(
                        children: [
                          const Text('Edition Count: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          Text(argsBookInfo.editionCount.toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(children: [
                        const Text('Cover Id: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                        Text(argsBookInfo.coverId.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                      ]),
                      const SizedBox(height: 6),
                      Row(children: [
                        const Text('Print Disable: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                        Text(argsBookInfo.printdisabled == true ? "Yes" : "No",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                      ]),
                      const SizedBox(height: 6),
                      Row(children: [
                        const Text('Public Scan: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                        Text(argsBookInfo.publicScan == true ? "Yes" : "No",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                      ]),
                      const SizedBox(height: 6),
                      Row(children: [
                        const Text('Availability: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                        Text(
                            argsBookInfo.availability!.status! ,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                      ]),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

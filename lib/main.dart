import 'package:flutter/material.dart';
import 'package:my_books/view/screen/details.dart';
import 'package:my_books/view/screen/favourites.dart';
import 'package:my_books/view/screen/books_list.dart';
import 'package:my_books/view/screen/splash.dart';
import 'package:my_books/view_model/book_provider.dart';
import 'package:my_books/view_model/network_status_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()..loadFavorites()),
        ChangeNotifierProvider(create: (_) => NetworkStatusProvider())
      ],
      child: MaterialApp(
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        title: 'MyBooks',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          dividerColor: Colors.transparent,
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/details': (context) => const DetailsScreen(),
          '/books_list': (context) => const BookListScreen(),
         '/favourites': (context) => const FavouritesScreen(),
        },
      ),
    );
  }
}
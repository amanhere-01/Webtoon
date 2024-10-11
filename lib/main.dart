import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:webtoon/database/comic_hive.dart';
import 'package:webtoon/presentation/widgets/bottom_nav_bar.dart';
import 'package:webtoon/provider/favorite_provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ComicAdapter());
  await Hive.openBox<Comic>('favoritesBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FavoriteProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: const BottomNavBar(),
      ),
    );
  }
}


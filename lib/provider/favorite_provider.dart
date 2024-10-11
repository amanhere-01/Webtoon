import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:webtoon/database/comic_hive.dart';

class FavoriteProvider extends ChangeNotifier{
  final favoriteBox = Hive.box<Comic>('favoritesBox');

  List<Comic> get favorites => favoriteBox.values.toList();

  void addFavorite(Comic comic){
    favoriteBox.put(comic.id, comic);
    notifyListeners();
  }

  void removeFavorite(String id){
    favoriteBox.delete(id);
    notifyListeners();
  }

  bool isFavorite(String id){
    return favoriteBox.containsKey(id);
  }

}
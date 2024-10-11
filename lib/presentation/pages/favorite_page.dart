import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/favorite_provider.dart';
import '../widgets/comic_card.dart';
import 'detail_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final comics =Provider.of<FavoriteProvider>(context).favorites;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Favorites'),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
        ),
        body: comics.isEmpty
          ? const Center(child: Text('No favorites yet!'),)
          : ListView.builder(
          itemCount: comics.length,
          itemBuilder: (context,index){
            final comic = comics[index];
            final id = comic.id;
            final title = comic.title;
            final thumbnailImage = comic.thumbnailUrl;

            return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(id: id,)));
                },
                child: ComicCard(title: title, image: thumbnailImage)
            );
          },
        )
    );
  }
}

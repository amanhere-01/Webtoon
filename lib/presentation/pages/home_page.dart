import 'package:flutter/material.dart';
import 'package:webtoon/presentation/pages/detail_page.dart';
import 'package:webtoon/presentation/widgets/comic_card.dart';
import '../../database/comic_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('W E B T O O N'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
      ),
      body: ListView.builder(
        itemCount: comics.length,
        itemBuilder: (context,index){
          final comic = comics[index];
          final id = comic['id'] as String;
          final title = comic['title'] as String;
          final thumbnailImage = comic['thumbnailUrl'] as String;

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

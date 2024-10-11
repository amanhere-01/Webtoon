import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:webtoon/database/comic_hive.dart';
import 'package:webtoon/provider/favorite_provider.dart';

import '../../database/comic_list.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic> comic = {};
  bool isFavorite = false;
  double averageRating = 0;
  double userRating = 0;
  int? previousUserRating;

  @override
  void initState() {
    super.initState();
    comic = getComicById(widget.id)!;
    isFavorite = Provider.of<FavoriteProvider>(context, listen: false).isFavorite(widget.id);
    averageRating = calculateAverageRating(comic['ratings']);
  }

  double calculateAverageRating(List<int> ratings) {
    if (ratings.isEmpty) return 0;
    return ratings.reduce((a, b) => a + b) / ratings.length;
  }

  void addRating(double rating) {
    setState(() {
      if(previousUserRating!=null){
        comic['ratings'].remove(previousUserRating);
      }
      comic['ratings'].add(rating.toInt());
      previousUserRating = rating.toInt();
      averageRating = calculateAverageRating(comic['ratings']);
    });
  }

  Map<String, dynamic>? getComicById(String id) {
    return comics.firstWhere((comic) => comic['id'] == id,);
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
        actions: [
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 5),
           child: IconButton(
             onPressed: (){
               if(!isFavorite){
                 favoriteProvider.addFavorite(
                     Comic(id: comic['id'], title: comic['title'], thumbnailUrl: comic['thumbnailUrl'])
                 );
                 Fluttertoast.showToast(
                   msg: 'Added to Favorites',
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   backgroundColor: Colors.black,
                   textColor: Colors.white,
                 );
               } else{
                 favoriteProvider.removeFavorite(widget.id);
                 Fluttertoast.showToast(
                   msg: 'Removed from Favorites',
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   backgroundColor: Colors.black,
                   textColor: Colors.white,
                 );
               }
               setState(() {
                 isFavorite = !isFavorite;
               });
             },
             icon: Icon(
               isFavorite
                 ? Icons.favorite_outlined
                 : Icons.favorite_outline_rounded,
               color: isFavorite ? Colors.red : Colors.black,
             )
           ),
         )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(comic['title'],
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Average Rating: ${averageRating.toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 13),
                  ),
                  RatingBarIndicator(
                    rating: averageRating,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                  ),
                ],
              ),
              const SizedBox(height: 5,),

              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(comic['thumbnailUrl']),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'by ',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: comic['author'],
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 15,
                          ),
                        ),
                      ]
                    ),
                  ),
                  Text(comic['date'],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13
                    ),
                  )
                ],
              ),
              const Divider(),
              const SizedBox(height: 15),
              Text(
                  comic['shortDescription'],
                  style: const TextStyle(fontSize: 18)
              ),
              const SizedBox(height: 15),
              Text(
                  'Major Characters in ${comic['title']}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: comic['majorChar'].length,
                itemBuilder: (context, index){
                  final description = comic['majorChar'][index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          description['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(description['imageUrl']),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        description['detail'],
                        style: const TextStyle(
                            fontSize: 18
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  );
                }
              ),
              const SizedBox(height: 10,),
              Text(
                'Minor Characters in ${comic['title']}',
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: comic['minorChar'].length,
                  itemBuilder: (context, index){
                    final description = comic['minorChar'][index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(description['imageUrl']),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          description['detail'],
                          style: const TextStyle(
                              fontSize: 18
                          ),
                        ),
                        const SizedBox(height: 20,),
                      ],
                    );
                  }
              ),
              const Divider(),
              Row(
                children: [
                  const Text('Rate this: ',
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: userRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    tapOnlyMode: true,
                    glow: false,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        userRating = rating;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 10
                  ),
                  onPressed: () {
                    if(userRating!=0.0){
                      addRating(userRating);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Rating submitted!'))
                      );
                    }
                  },
                  child: const Text('Submit Rating'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

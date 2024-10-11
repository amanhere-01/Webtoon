import 'package:flutter/material.dart';

class ComicCard extends StatelessWidget {
  final String title;
  final String image;
  const ComicCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5) ,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(242, 242, 242, 1.0) ,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 5,),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(image),
          ),
        ],
      ),
    );
  }
}

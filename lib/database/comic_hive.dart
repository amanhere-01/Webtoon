import 'package:hive/hive.dart';

part 'comic_hive.g.dart';

@HiveType(typeId: 0)
class Comic {
  Comic({required this.id, required this.title, required this.thumbnailUrl});

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String thumbnailUrl;

}
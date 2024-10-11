// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComicAdapter extends TypeAdapter<Comic> {
  @override
  final int typeId = 0;

  @override
  Comic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comic(
      id: fields[0] as String,
      title: fields[1] as String,
      thumbnailUrl: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Comic obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.thumbnailUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

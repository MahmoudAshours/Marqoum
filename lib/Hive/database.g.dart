// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarqoumDBAdapter extends TypeAdapter<MarqoumDB> {
  @override
  final int typeId = 0;

  @override
  MarqoumDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MarqoumDB(
      pdfAsset: fields[0] as String,
      bookmarked: (fields[1] as List)?.cast<int>(),
      lastVisitedPage: fields[2] as int,
      pageNote: (fields[3] as Map)?.cast<int, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MarqoumDB obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.pdfAsset)
      ..writeByte(1)
      ..write(obj.bookmarked)
      ..writeByte(2)
      ..write(obj.lastVisitedPage)
      ..writeByte(3)
      ..write(obj.pageNote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarqoumDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

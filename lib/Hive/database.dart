import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'database.g.dart';

@HiveType(typeId: 0)
class MarqoumDB {
  @HiveField(0)
  String pdfAsset;
  @HiveField(1)
  List<int> bookmarked = new List<int>();
  @HiveField(2)
  int lastVisitedPage;
  @HiveField(3)
  Map<int, String> pageNote = Map<int, String>();
  MarqoumDB({
    this.pdfAsset,
    this.bookmarked,
    this.lastVisitedPage,
    this.pageNote,
  });

  updatePDf({@required int index, @required MarqoumDB snapshot}) {
    Hive.box('MarqoumDB').putAt(
      index,
      MarqoumDB(
        pdfAsset: snapshot.pdfAsset,
        bookmarked: snapshot.bookmarked,
        lastVisitedPage: snapshot.lastVisitedPage,
        pageNote: snapshot.pageNote,
      ),
    );
  }
}

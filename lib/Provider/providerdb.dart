import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:marqoum/Hive/database.dart';

class ProviderDB with ChangeNotifier {
  void addBookmark(bool bookmark,
      {int index, MarqoumDB snapshot, int currPage}) {
    Hive.box('pdfDB').putAt(
      index,
      MarqoumDB(
        lastVisitedPage: snapshot.lastVisitedPage,
        pageNote: snapshot.pageNote,
        bookmarked: _listBookmark(snapshot, index, currPage, bookmark),
      ),
    );
  }

  List<int> _listBookmark(
      MarqoumDB snapshot, int index, int currentPage, bool bookmark) {
    if (snapshot.bookmarked != null) {
      if (bookmark) {
        return [currentPage, ...Hive.box('pdfDB')?.getAt(index)?.bookmarked];
      } else {
        return [...Hive.box('pdfDB')?.getAt(index)?.bookmarked]
          ..remove(currentPage);
      }
    } else {
      return [currentPage];
    }
  }

  Future<void> updateLastSeen(MarqoumDB snapshot, int index) {
    return Hive.box('pdfDB').putAt(
      index,
      MarqoumDB(
        lastVisitedPage: snapshot.lastVisitedPage,
        pageNote: snapshot.pageNote,
        bookmarked: snapshot.bookmarked,
      ),
    );
  }
}

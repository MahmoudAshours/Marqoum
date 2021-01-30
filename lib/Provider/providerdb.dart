import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:marqoum/Hive/database.dart';

class ProviderDB with ChangeNotifier {
  void addBookmark(bool bookmark, {MarqoumDB snapshot, int currPage}) {
    Hive.box('MarqoumDB').putAt(
      0,
      MarqoumDB(
        lastVisitedPage: snapshot.lastVisitedPage,
        pageNote: snapshot.pageNote,
        bookmarked: _listBookmark(snapshot, currPage, bookmark),
      ),
    );
  }

  List<int> _listBookmark(MarqoumDB snapshot, int currentPage, bool bookmark) {
    if (snapshot.bookmarked != null) {
      if (bookmark) {
        return [currentPage, ...Hive.box('MarqoumDB')?.getAt(0)?.bookmarked];
      } else {
        return [...Hive.box('MarqoumDB')?.getAt(0)?.bookmarked]
          ..remove(currentPage);
      }
    } else {
      return [currentPage];
    }
  }

  Future<void> updateLastSeen(MarqoumDB snapshot, int index) {
    return Hive.box('MarqoumDB').putAt(
      index,
      MarqoumDB(
        lastVisitedPage: snapshot.lastVisitedPage,
        pageNote: snapshot.pageNote,
        bookmarked: snapshot.bookmarked,
      ),
    );
  }
}

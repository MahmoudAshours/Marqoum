import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marqoum/Hive/database.dart';
import 'package:marqoum/Provider/providerdb.dart';
import 'package:provider/provider.dart';

class BookmarkPdf extends StatelessWidget {
  final int currentPage;
  BookmarkPdf({@required this.currentPage});
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<ProviderDB>(context);
    final hive = Hive.box('MarqoumDB');

    return ValueListenableBuilder(
      valueListenable: hive.listenable(),
      builder: (_, Box snapshot, Widget child) {
        final MarqoumDB _pdf = hive.getAt(0);
        return GestureDetector(
          onTap: () => bookmark(_bloc, _pdf),
          child: Icon(
            Icons.bookmark,
            color: _bookmarkColorChecker(_pdf),
          ),
        );
      },
    );
  }

  void bookmark(ProviderDB _bloc, MarqoumDB _pdf) {
    if (_pdf.bookmarked != null) {
      if (_pdf.bookmarked.contains(currentPage)) {
        _bloc.addBookmark(
          false,
          currPage: currentPage,
          snapshot: _pdf,
        );
      } else {
        _bloc.addBookmark(
          true,
          currPage: currentPage,
          snapshot: _pdf,
        );
      }
    } else {
      _bloc.addBookmark(
        true,
        currPage: currentPage,
        snapshot: _pdf,
      );
    }
    print(_pdf.bookmarked);
  }

  Color _bookmarkColorChecker(MarqoumDB _pdf) {
    if (_pdf.bookmarked != null) {
      if (_pdf.bookmarked.contains(currentPage)) {
        return Colors.red;
      } else {
        return Colors.white;
      }
    } else {
      return Colors.white;
    }
  }
}

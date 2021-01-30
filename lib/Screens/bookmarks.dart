import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marqoum/Screens/pdf_screen.dart';

class Bookmarks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: RepaintBoundary(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                ValueListenableBuilder(
                  valueListenable: Hive.box('MarqoumDB').listenable(),
                  builder: (_, Box snap, __) {
                    if (snap.getAt(0).bookmarked == null ||
                        snap.getAt(0).bookmarked.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              'ليس لديك مفضلة إلى الآن',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    }
                    return Wrap(
                      children: <Widget>[
                        Container(
                          height: 400,
                          child: ListView(
                            children: snap.getAt(0).bookmarked.map<Widget>(
                              (int pageNumber) {
                                return ListTile(
                                  title: Text(
                                    'الصفحة رقم ${pageNumber + 1}',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => PDFScreen(
                                        pageNumber: pageNumber,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marqoum/Screens/pdf_screen.dart';
import 'package:marqoum/localization/app_localiztion.dart';

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
                              '${AppLocalizations.of(context).translate('bookmark_message')}',
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
                          height: MediaQuery.of(context).size.height,
                          child: ListView(
                            children: snap.getAt(0).bookmarked.map<Widget>(
                              (int pageNumber) {
                                return Container(
                                  color: Color(0xffDAD2C7),
                                  margin: EdgeInsets.only(top: 10),
                                  child: ListTile(
                                    trailing: FaIcon(FontAwesomeIcons.bookmark),
                                    title: Text(
                                      '${AppLocalizations.of(context).translate('page_number')} ${pageNumber + 1}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            PDFScreen(pageNumber: pageNumber),
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

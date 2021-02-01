import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:marqoum/Screens/book_content.dart';
import 'package:marqoum/Screens/bookmarks.dart';
import 'package:marqoum/localization/app_localiztion.dart';
import 'package:marqoum/localization/localization_widget.dart';

class HomeScaffold extends StatefulWidget {
  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _index = 0;
  final _pages = List.unmodifiable([BookContents(), Bookmarks()]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/library_background.png'),
              fit: BoxFit.cover),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              toolbarHeight: 130,
              elevation: 4,
              centerTitle: true,
              leading: LocalizationWidget(),
              shadowColor: Colors.black,
              backgroundColor: Color(0xffedece8),
              title: SafeArea(
                child: Column(
                  children: [
                    Text(
                      '${AppLocalizations.of(context).translate('moslmoon')}',
                      style: TextStyle(
                          color: Color(0xff493628), fontFamily: 'NeoSans'),
                    ),
                    FloatingNavbar(
                      backgroundColor: Color(0xffd9d1c0),
                      borderRadius: 50,
                      selectedBackgroundColor: Color(0xffd49448),
                      itemBorderRadius: 50,
                      fontSize: 18,
                      width: MediaQuery.of(context).size.width,
                      iconSize: 0,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Color(0xff493628),
                      items: [
                        FloatingNavbarItem(
                            title:
                                '${AppLocalizations.of(context).translate('content')}',
                            icon: Icons.arrow_back),
                        FloatingNavbarItem(
                            title:
                                '${AppLocalizations.of(context).translate('bookmarks')}',
                            icon: Icons.arrow_back),
                      ],
                      currentIndex: _index,
                      onTap: (itemIndex) => setState(() => _index = itemIndex),
                    ),
                  ],
                ),
              ),
            ),
            _pages[_index]
          ],
        ),
      ),
    );
  }
}

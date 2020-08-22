import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScaffold extends StatefulWidget {
  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _index = 2;
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
              toolbarHeight: 130,
              elevation: 4,
              shadowColor: Colors.black,
              backgroundColor: Color(0xffedece8),
              title: SafeArea(
                child: Column(
                  children: [
                    Text(
                      'المرقوم',
                      style: TextStyle(
                          color: Color(0xff493628), fontFamily: 'NeoSans'),
                    ),
                    FloatingNavbar(
                        backgroundColor: Color(0xffd9d1c0),
                        family: 'NeoSans',
                        borderRadius: 50,
                        selectedBackgroundColor: Color(0xffd49448),
                        itemBorderRadius: 50,
                        padding: const EdgeInsets.all(0),
                        fontSize: 18,
                        iconSize: 0,
                        selectedItemColor: Colors.white,
                        unselectedItemColor: Color(0xff493628),
                        items: [
                          FloatingNavbarItem(title: 'الملاحظات'),
                          FloatingNavbarItem(title: 'علامات مرجعية'),
                          FloatingNavbarItem(title: 'المحتويات'),
                        ],
                        currentIndex: _index,
                        onTap: (itemIndex) =>
                            setState(() => _index = itemIndex)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

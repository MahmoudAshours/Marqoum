import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marqoum/Screens/pdf_screen.dart';

class BookContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(
          1,
          (index) => Container(
            color: Color(0xffDAD2C7),
            margin: EdgeInsets.only(top: 10),
            child: ListTile(
              title: Text('المقدمة', textDirection: TextDirection.rtl),
              trailing: FaIcon(FontAwesomeIcons.book),
              contentPadding: EdgeInsets.all(10),
              visualDensity: VisualDensity.comfortable,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PDFScreen(pageNumber: 0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

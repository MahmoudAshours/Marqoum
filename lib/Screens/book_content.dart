import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marqoum/Screens/pdf_screen.dart';
import 'package:marqoum/localization/app_localiztion.dart';

class BookContents extends StatelessWidget {
  loadcsv(context) async {
    final myData = await rootBundle.loadString(
        "assets/index/${AppLocalizations.of(context).locale.languageCode}.csv");

    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(myData);
    print(rowsAsListOfValues);
    return rowsAsListOfValues;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadcsv(context),
      builder: (_, snap) => !snap.hasData
          ? SliverToBoxAdapter()
          : SliverList(
              delegate: SliverChildListDelegate(
                [
                  for (var i = 0; i < snap.data.length; i++)
                    Container(
                      color: Color(0xffDAD2C7),
                      margin: EdgeInsets.only(top: 10),
                      child: ListTile(
                        trailing: FaIcon(FontAwesomeIcons.book),
                        title: Text('${snap.data[i][0]}'),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PDFScreen(
                              pageNumber: int.parse('${snap.data[i][1]}'),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
    );
  }
}

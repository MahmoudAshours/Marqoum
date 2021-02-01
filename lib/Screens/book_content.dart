import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marqoum/Screens/pdf_screen.dart';
import 'package:marqoum/localization/app_localiztion.dart';

class BookContents extends StatelessWidget {
  Future<List<List>> loadcsv(context) async {
    final myData = await rootBundle.loadString(
        "assets/index/${AppLocalizations.of(context).locale.languageCode}.csv");

    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(myData);
    return rowsAsListOfValues;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadcsv(context),
      builder: (_, AsyncSnapshot<List<List>> snap) => !snap.hasData
          ? SliverToBoxAdapter()
          : SliverList(
              delegate: SliverChildListDelegate(
                [
                  for (var item
                      in snap.data.where((element) => element[2] == 1))
                    Container(
                      color: Color(0xffDAD2C7),
                      margin: EdgeInsets.only(top: 10),
                      child: ExpansionTile(
                        children: snap.data
                            .where((element) =>
                                 element[3] == item[1])
                            .toList()
                            .map(
                              (data) => ListTile(
                                title: Text('${data[0]}'),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PDFScreen(pageNumber: data[1]),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        trailing: FaIcon(
                          FontAwesomeIcons.bookReader,
                          color: Colors.orange,
                        ),
                        title: Text(
                          '${item[0]}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                ],
              ),
            ),
    );
  }
}

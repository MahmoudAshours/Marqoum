import 'package:flutter/material.dart';
import 'package:marqoum/localization/local_provider.dart';
import 'package:provider/provider.dart';

class LocalizationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<LocalProvider>(context);

    return Container(
      width: 70,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: IconButton(
                onPressed: () {
                  appLanguage.appLocal == Locale('ar')
                      ? appLanguage.changeLanguage(Locale("en"))
                      : appLanguage.changeLanguage(Locale("ar"));
                },
                icon: Icon(Icons.language),
                color: Colors.white),
          ),
          Text(
            appLanguage.appLocal == Locale('ar') ? 'ع' : 'e',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
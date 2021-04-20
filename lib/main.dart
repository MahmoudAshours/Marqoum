import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:marqoum/Hive/database.dart';
import 'package:marqoum/Provider/pdfscreen_bloc.dart';
import 'package:marqoum/Provider/providerdb.dart';
import 'package:marqoum/Screens/home_scaffold.dart';
import 'package:marqoum/localization/app_localiztion.dart';
import 'package:marqoum/localization/local_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(MarqoumDBAdapter());
  final _db = await Hive.openBox('MarqoumDB');
  _createDatabase(_db);
  runApp(MyApp());
}

void _createDatabase(Box box) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('first_time') == null) {
    prefs.setBool('first_time', true);
    box.add(MarqoumDB());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderDB()),
        ChangeNotifierProvider(create: (_) => PDFScreenBloc()),
      ],
      child: ChangeNotifierProvider<LocalProvider>(
        create: (_) => LocalProvider(),
        lazy: false,
        child: Consumer<LocalProvider>(
          builder: (context, localeSnapshot, __) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Muslims in Estrangement countries',
            supportedLocales: [
              const Locale('ar', ''),
              const Locale('en', 'US'),
            ],
            theme: ThemeData(fontFamily: 'NeoSans'),
            locale: localeSnapshot.appLocal,
            // These delegates make sure that the localization data for the proper language is loaded
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
            ],
            // Returns a locale which will be used by the app
            localeResolutionCallback: (locale, supportedLocales) {
              // Check if the current device locale is supported
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              // If the locale of the device is not supported, use the first one
              // from the list (English, in this case).
              return localeSnapshot.appLocal;
            },

            home: HomePage(),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScaffold(),
    );
  }
}

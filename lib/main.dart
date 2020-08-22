import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:marqoum/Hive/database.dart';
import 'package:marqoum/Screens/home_scaffold.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(MarqoumDBAdapter());
  await Hive.openBox('MarqoumDB');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مرقوم',
      localizationsDelegates: [
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      locale: Locale('ar'),
      home: HomePage(),
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
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true, // default false
      colorTransitionChild: Colors.black, // default Color.black54
      colorTransitionScaffold: Colors.transparent,
      offset: IDOffset.only(bottom: 0.06, right: 0.0, left: 0.0),
      velocity: 10,
      scale: IDOffset.horizontal(0.6),
      rightAnimationType: InnerDrawerAnimation.quadratic,
      backgroundDecoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/library_background.png'),
            fit: BoxFit.cover),
      ),

      rightChild: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 10.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: FaIcon(FontAwesomeIcons.book, size: 30),
                        backgroundColor: Color(0xffedece8),
                        foregroundColor: Color(0xffd49448),
                      ),
                      Material(
                        child: Text(
                          'الكتب',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        type: MaterialType.transparency,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 10.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: FaIcon(FontAwesomeIcons.solidBookmark, size: 30),
                        backgroundColor: Color(0xffedece8),
                        foregroundColor: Color(0xffd49448),
                      ),
                      Material(
                        child: Text(
                          'العلامات',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        type: MaterialType.transparency,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 10.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: FaIcon(FontAwesomeIcons.stickyNote, size: 30),
                        backgroundColor: Color(0xffedece8),
                        foregroundColor: Color(0xffd49448),
                      ),
                      Material(
                        child: Text(
                          'الملاحظات',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        type: MaterialType.transparency,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: FaIcon(FontAwesomeIcons.book, size: 30),
                        backgroundColor: Color(0xffedece8),
                        foregroundColor: Color(0xffd49448),
                      ),
                      Material(
                        child: Text(
                          'عن التطبيق',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        type: MaterialType.transparency,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      scaffold: HomeScaffold(),
    );
  }

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void _toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.end);
  }
}

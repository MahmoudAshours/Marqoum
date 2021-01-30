import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marqoum/Screens/bookmark.dart';

class PDFScreen extends StatefulWidget {
  final int index;
  PDFScreen({this.index});
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  int index;
  PDFDocument doc;
  PageController controller;
  int currentPage = 0;
  double _opacity = 1;
  @override
  void initState() {
    print(index);
    initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            backgroundColor: Color(0xffedece8),
            forceElevated: true,
            brightness: Brightness.dark,
            stretchTriggerOffset: 130,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Color(0xff493628),
                  ),
                ),
                BookmarkPdf(index: 0, currentPage: currentPage),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color(0xff26292D),
                child: RepaintBoundary(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: FutureBuilder(
                          future: PDFDocument.fromAsset('assets/legends.pdf'),
                          builder: (c, AsyncSnapshot<PDFDocument> s) => !s
                                  .hasData
                              ? CircularProgressIndicator()
                              : GestureDetector(
                                  onTap: () => setState(() {
                                    _opacity == 1 ? _opacity = 0 : _opacity = 1;
                                  }),
                                  child: PDFViewer(
                                    document: s.data,
                                    controller: controller,
                                    showIndicator: false,
                                    showPicker: false,
                                    reverse: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 150,
                        child: AnimatedOpacity(
                          opacity: _opacity,
                          duration: Duration(seconds: 1),
                          child: Container(
                            width: 90,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.clipboardList,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    'ملاحظة',
                                    style: TextStyle(
                                      color: Color(0xff493628),
                                      fontFamily: 'NeoSans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffd49448),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.elliptical(20, 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 250,
                        child: AnimatedOpacity(
                          opacity: _opacity,
                          duration: Duration(seconds: 1),
                          child: Container(
                            width: 90,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.shareSquare,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    'مشاركة',
                                    style: TextStyle(
                                      color: Color(0xff493628),
                                      fontFamily: 'NeoSans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffd49448),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.elliptical(20, 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initPage() async {
    controller = PageController(initialPage: 0);
  }
}

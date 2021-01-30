import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marqoum/Screens/bookmark.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PDFScreen extends StatefulWidget {
  final int pageNumber;
  PDFScreen({this.pageNumber});
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  PdfController pdfController;
  int _currentPage;
  double _opacity = 1;

  @override
  void initState() {
    pdfController = PdfController(
        document: PdfDocument.openAsset('assets/legends.pdf'),
        initialPage: 1,
        viewportFraction: 1.3);
    Future.delayed(
        Duration(milliseconds: 100),
        () => pdfController.animateToPage(widget.pageNumber,
            duration: Duration(milliseconds: 500), curve: Curves.ease));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xff26292D),
          child: RepaintBoundary(
            child: Stack(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Positioned(
                  child: GestureDetector(
                    onTap: () => setState(
                        () => _opacity == 0 ? _opacity = 1 : _opacity = 0),
                    child: PdfView(
                      scrollDirection: Axis.horizontal,
                      onDocumentLoaded: (d) {
                        setState(() {
                          _currentPage = widget.pageNumber;
                        });
                      },
                      onPageChanged: (int page) =>
                          setState(() => _currentPage = page),
                      reverse: true,
                      controller: pdfController,
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
                Positioned(
                  right: 0,
                  top: 350,
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
                              child: BookmarkPdf(currentPage: _currentPage)),
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
    );
  }
}

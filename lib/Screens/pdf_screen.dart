import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marqoum/Provider/pdfscreen_bloc.dart';
import 'package:marqoum/Screens/bookmark.dart';
import 'package:marqoum/Screens/share_page.dart';
import 'package:marqoum/localization/app_localiztion.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:provider/provider.dart';

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
  void didChangeDependencies() {
    pdfController = PdfController(
        document: PdfDocument.openAsset(
            'assets/${AppLocalizations.of(context).locale.languageCode}.pdf'),
        initialPage: 1,
        viewportFraction: 1.3);
    Future.delayed(
      Duration(seconds: 1),
      () => pdfController.animateToPage(
        widget.pageNumber,
        duration: Duration(milliseconds: 200),
        curve: Curves.decelerate,
      ),
    );
    setState(() {});

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _pdfProvider = Provider.of<PDFScreenBloc>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xff26292D),
          child: Stack(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Positioned(
                child: GestureDetector(
                  onTap: () => setState(
                      () => _opacity == 0 ? _opacity = 1 : _opacity = 0),
                  child: RepaintBoundary(
                    key: _pdfProvider.scr,
                    child: PdfView(
                      scrollDirection: Axis.horizontal,
                      documentLoader:
                          Center(child: CircularProgressIndicator()),
                      onDocumentLoaded: (_) =>
                          setState(() => _currentPage = widget.pageNumber),
                      onPageChanged: (int page) =>
                          setState(() => _currentPage = page),
                      controller: pdfController,
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
                    width: 50,
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SharePage(),
                        ),
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
                    width: 50,
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BookmarkPdf(currentPage: _currentPage)),
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
    );
  }
}

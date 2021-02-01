import 'dart:ui';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marqoum/Provider/pdfscreen_bloc.dart';
import 'package:provider/provider.dart';

class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pdfProvider = Provider.of<PDFScreenBloc>(context);

    return GestureDetector(
      onTap: () => _sharePage(context, _pdfProvider),
      child: FaIcon(
        FontAwesomeIcons.shareSquare,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  Future<void> _sharePage(
      BuildContext context, PDFScreenBloc pdfProvider) async {
    RenderRepaintBoundary boundary =
        pdfProvider.scr.currentContext.findRenderObject();
    final image = await boundary.toImage(pixelRatio: 2.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData.buffer.asUint8List();
    await Share.file(
        'Share Copia PDF page', 'copiaPdf.jpg', pngBytes, 'image/jpg',
        text: "Check this Page! #Copia");
  }
}

import 'package:flutter/material.dart';
import 'package:link_previewer/link_previewer.dart';

class VideosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LinkPreviewer(
            link: "https://www.linkedin.com/feed/",
            direction: ContentDirection.horizontal,
          ),
          LinkPreviewer(
            link: "https://www.linkedin.com/feed/",
            direction: ContentDirection.vertical,
          ),
        ],
      ),
    );
  }
}

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
            link: "https://www.youtube.com/watch?v=gPBby-Wfn_4",
            direction: ContentDirection.horizontal,
          ),
          Divider(),
          LinkPreviewer(
            link: "https://www.youtube.com/watch?v=7Ruw1iI6__s",
            direction: ContentDirection.vertical,
          ),
          Divider(),
          LinkPreviewer(
            link: "https://www.youtube.com/watch?v=SmAswkauXNg",
            direction: ContentDirection.vertical,
          ),
          Divider(),
          LinkPreviewer(
            link: "https://www.youtube.com/watch?v=MK71GDKj9oM",
            direction: ContentDirection.vertical,
          ),
        ],
      ),
    );
  }
}

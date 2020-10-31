import 'package:flutter/material.dart';

class Bookmarks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            child: Text('data'),
          )
        ],
      ),
    );
  }
}

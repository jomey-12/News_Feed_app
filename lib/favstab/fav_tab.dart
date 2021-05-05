import 'package:flutter/material.dart';
import 'package:news_feed/newstab/news_tile.dart';

class FavTab extends StatefulWidget {
  @override
  _FavTabState createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: fav.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: NewsTile(
                news: fav[index],
                tab: 1,
              ),
            );
          },
        ),
      ),
    );
  }
}

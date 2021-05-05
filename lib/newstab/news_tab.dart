import 'package:flutter/material.dart';
import 'package:news_feed/newstab/news_tile.dart';
import 'package:news_feed/services/newsfeed.dart';

var data;
var result;

class NewsTab extends StatefulWidget {
  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  @override
  Widget build(BuildContext context) {
    Future func() async {
      result = await getNews();
      setState(() {
        data = result;
      });
    }

    func();

    return data == null
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: data['data'].length - fav.length,
                itemBuilder: (context, index) {
                  int x = 0;
                  for (int i = 0; i < fav.length; i++) {
                    if (fav[i].id == data['data'][index]['id']) {
                      x = 1;

                      break;
                    }
                  }

                  News news = News(
                    id: data['data'][index]['id'],
                    title: data['data'][index]['title'] != null
                        ? data['data'][index]['title']
                        : " ",
                    desc: data['data'][index]['summary'] != null
                        ? data['data'][index]['summary']
                        : " ",
                    date: data['data'][index]['published'] != null
                        ? data['data'][index]['published']
                        : " ",
                  );

                  return x != 0
                      ? SizedBox(
                          height: 0.0,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NewsTile(
                            news: news,
                            tab: 0,
                          ),
                        );
                },
              ),
            ),
          );
  }
}

import 'package:flutter/material.dart';

class News {
  final int id;
  final String title;
  final String desc;
  final String date;
  bool isFav = false;

  News({this.id, this.title, this.desc, this.date});
}

List fav = [];

class NewsTile extends StatefulWidget {
  final News news;
  final int tab;

  NewsTile({this.news, this.tab});

  @override
  _NewsTileState createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  @override
  Widget build(BuildContext context) {
    return widget.tab == 0
        ? widget.news.isFav
            ? SizedBox(
                height: 0.0,
              )
            : Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      new BoxShadow(
                          color: Colors.grey,
                          blurRadius: 16.0,
                          offset: Offset(6.0, 6.0)),
                    ]),
                height: MediaQuery.of(context).size.height / 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: IconButton(
                            icon: widget.news.isFav
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border_outlined,
                                  ),
                            iconSize: 60,
                            onPressed: () {
                              setState(() {
                                widget.news.isFav = true;
                              });

                              if (widget.news.isFav) {
                                fav.add(widget.news);
                              }
                            },
                          )),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.news.title,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Text(
                                widget.news.desc,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Text(widget.news.date,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ))
                            ]),
                      ),
                    ],
                  ),
                ),
              )
        : widget.news.isFav
            ? Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      new BoxShadow(
                          color: Colors.grey,
                          blurRadius: 16.0,
                          offset: Offset(6.0, 6.0)),
                    ]),
                height: MediaQuery.of(context).size.height / 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: IconButton(
                            icon: widget.tab == 1
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(Icons.favorite_border_outlined),
                            iconSize: 60,
                            onPressed: () {
                              setState(() {
                                widget.news.isFav = false;
                              });
                              fav.remove(widget.news);
                            },
                          )),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.news.title,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Text(
                                widget.news.desc,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Text(widget.news.date,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ))
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: 0.0,
              );
  }
}

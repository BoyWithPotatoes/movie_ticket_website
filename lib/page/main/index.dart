import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:movie_ticket/widget/clickable.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import 'package:movie_ticket/global.dart' as g;

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late ScrollController _scrollController;
  final List _movieList = [];
  final List _ranList = [];

  getData() async {
    await g.db.collection("movie").get().then((value) {
      _movieList.clear();
      for (var e in value.docs) {
        Map data = e.data();
        data["id"] = e.id;
        _movieList.add(data);
      }
    });

    for (int i = 0; i < _movieList.length; i++) {
      _ranList.add(i);
    }
    _ranList.shuffle();

    return "done";
  }
  
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: g.defaultAppbar(context),

      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WebSmoothScroll(
              controller: _scrollController,
              scrollOffset: 80,
              animationDuration: 180,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                children: [
                  ImageSlideshow(
                    height: 640,
                    isLoop: true,
                    autoPlayInterval: 15000,
                    indicatorBackgroundColor: g.colorPallet[9],
                    indicatorColor: g.colorPallet[0],
                    children: List.generate(_movieList.length.clamp(0, 5), (index) => MovieSlideShow(movie: _movieList[_ranList[index]])),
                  ),
                  if (g.currentUser.isEmpty || g.currentUser["rank"].split(" ")[0] != "member") ... [
                    Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("BECOME A MEMBER NOW AND GET 20% OFF", style: TextStyle(fontSize: 42.0, color: g.colorPallet[0], fontWeight: FontWeight.w900)),
                          Button(
                            onClick: () {
                              if (g.currentUser.isEmpty) {
                                Navigator.pushNamed(context, "/register");
                              } else {
                                Navigator.pushNamed(context, "/member");
                              }
                            },
                            color: g.colorPallet[0],
                            size: const Size(200, 60),
                            child: const Text("BECOME A MEMBER", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w800)),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 64.0),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 32.0),
                              child: Text("Movies", style: TextStyle(fontSize: 42, color: g.colorPallet[9], fontWeight: FontWeight.w900)),
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 64.0,
                                runSpacing: 64.0 - 16.0,
                                children: List.generate(_movieList.length, (index) {
                                  return MoviePoster(movie: _movieList[index]);
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  g.footer,
                ]
              ),
            );
          }
          return Center(child: CircularProgressIndicator(color: g.colorPallet[9]));
        },
      ),
      
    );
  }
}

class MoviePoster extends StatelessWidget {
  final Map movie;
  const MoviePoster({
    required this.movie,
    super.key
  });

  final double _width = 300;

  final double _height = 300 * 3 / 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, "/movie", arguments: movie),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(
              movie["poster"], fit: BoxFit.cover, width: _width, height: _height,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          width: _width,
          child: Text(movie["name"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: g.colorPallet[9]), textAlign: TextAlign.center),
        )
      ],
    );
  }
}

class MovieSlideShow extends StatelessWidget {
  final Map movie;
  const MovieSlideShow({
    required this.movie,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 64),
            alignment: Alignment.topLeft,
            color: g.colorPallet[9],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie["name"], style: TextStyle(color: g.colorPallet[0], fontSize: 64, fontWeight: FontWeight.w400)),
                const SizedBox(height: 12),
                Text(" ${movie["gerne"]} | ${movie["year"]}", style: TextStyle(color: g.colorPallet[0], fontSize: 18)),
                const Spacer(),
                Button(
                  onClick: () => Navigator.pushNamed(context, "/movie", arguments: movie),
                  color: Colors.white,
                  size: const Size(200, 60),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.local_activity_outlined, size: 32, color: g.colorPallet[9]),
                        Text("GET TICKET", style: TextStyle(fontSize: 18, color: g.colorPallet[9], fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(movie["poster"]), fit: BoxFit.cover),
            ),
            child: ClipRRect(
              
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Image.network(movie["poster"]),
                ),
              ),
            )
          ),
        ),
      ],
    );
  }
}
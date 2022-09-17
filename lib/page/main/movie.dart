import 'package:flutter/material.dart';

import 'package:movie_ticket/global.dart' as g;
import 'package:movie_ticket/widget/clickable.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';


class Movie extends StatefulWidget {
  const Movie({super.key});

  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var setting = ModalRoute.of(context)!.settings;
    late Map movie;
    if (setting.arguments == null) {
      Navigator.pushReplacementNamed(context, "/notfound");
    } else {
      movie = setting.arguments as Map;
    }
    return Scaffold(
      appBar: g.defaultAppbar(context, allowMainMenu: true),

      body: WebSmoothScroll(
        scrollOffset: 80,
        animationDuration: 180,
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 20),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    movie["poster"],
                    height: 250 * 3 / 2,
                    width: 250,
                  ),
                  const SizedBox(width: 32.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                      Text(movie["name"], style: TextStyle(color: g.colorPallet[9], fontSize: 42, fontWeight: FontWeight.w600)),
                      Text("${movie["year"]} | ${movie["gerne"]}", style: TextStyle(color: g.colorPallet[9], fontSize: 14, fontWeight: FontWeight.w200))
                    ],
                  )
                ],
              )
            ),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 200), child: Container(height: 1, color: g.colorPallet[4])),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 20),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Button(
                    onClick: () {
                      if (movie["ticket"] > 0) {
                        g.db.collection("movie").doc(movie["id"]).update({"ticket": movie["ticket"] - 1}).then(
                          (value) => Navigator.pushNamed(context, "/bill", arguments: movie)
                        );
                      }
                    },
                    color: g.colorPallet[movie["ticket"] > 0 ? 9 : 4],
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    size: const Size(double.maxFinite, 50),
                    child: Text(movie["ticket"] > 0 ? "BUY TICKET" : "UNAVIALIBLE", style: TextStyle(color: g.colorPallet[movie["ticket"] > 0 ? 0 : 9], fontSize: 18, fontWeight: FontWeight.w400)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("IN STOCK: ${movie["ticket"]}", style: TextStyle(color: g.colorPallet[6], fontSize: 12, fontWeight: FontWeight.w200)),
                  )
                ],
              ),
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
            const SizedBox(height: 500),
            g.footer,
          ],
        ),
      ),

    );
  }
}
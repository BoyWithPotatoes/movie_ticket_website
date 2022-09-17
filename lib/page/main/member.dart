import 'package:flutter/material.dart';

import 'package:movie_ticket/global.dart' as g;
import 'package:movie_ticket/widget/clickable.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class Member extends StatefulWidget {
  const Member({super.key});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  bool _clickable = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (g.currentUser.isEmpty) {
      Navigator.pushReplacementNamed(context, "/notfound");
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: g.defaultAppbar(context, allowMainMenu: true),
      body: WebSmoothScroll(
        controller: _scrollController,
        scrollOffset: 80,
        animationDuration: 180,
        child: ListView(
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 64.0),

            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              width: double.maxFinite,
              child: Text("CHOOSE YOUR PLAN", style: TextStyle(fontSize: 42.0, fontWeight: FontWeight.w400, color: g.colorPallet[9])),
            ),
            const SizedBox(height: 64.0),

            Wrap(
              spacing: 64.0,
              runSpacing: 32.0,
              alignment: WrapAlignment.center,
              children: [
                createCard("sliver", Colors.grey[400], 39, 5),
                createCard("gold", Colors.yellow[400], 69, 10, best: true),
                createCard("Diamond", Colors.blue[300], 99, 20),
              ],
            ),
            const SizedBox(height: 128.0),

            g.footer,
          ],
        ),
      ),
    );
  }

  createCard(name, color, price, sale, {best = false}) {
    return SizedBox(
      width: 400,
      height: 420 * 3 / 2,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 8.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: color,
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(name.toUpperCase(), style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w200, color: g.colorPallet[9]))
            ),

            Container(
              height: 504,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w400, color: g.colorPallet[9]),
                      text: "$price",
                      children: const [
                        TextSpan(
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w200),
                          text: "/mo"
                        )
                      ],
                    ),
                  ),
                  
                  Text("Get $sale% off everytime you buy a ticket\n", style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w200)),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(color: g.colorPallet[4], height: 1, width: double.maxFinite),
                      const SizedBox(height: 32.0),
                      Button(
                        onClick: () async {
                          if (_clickable) {
                            _clickable = false;
                            g.currentUser["rank"] = "member $name";
                            g.db.collection("users").doc(g.currentUser["id"]).update({"rank": "member $name"}).then((value) => Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false));
                          }
                        },
                        size: const Size(200, 64),
                        color: color,
                        child: Text("CHOOSE", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w200, color: g.colorPallet[9])),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            if(best) ... [
              Container(
                color: Colors.red[600],
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text("BEST SELLING", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w200, color: g.colorPallet[0]))
              ),
            ] else ... [
              const SizedBox(height: 44)
            ]

          ],
        ),
      ),
    );
  }
}
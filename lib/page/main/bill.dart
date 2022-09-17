import 'package:flutter/material.dart';

import 'package:movie_ticket/global.dart' as g;
import 'package:movie_ticket/widget/clickable.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class Bill extends StatefulWidget {
  const Bill({
    super.key
  });

  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var setting = ModalRoute.of(context)!.settings;
    late Map movie;
    String ticketNumber = "test";
    if (setting.arguments == null) {
      Navigator.pushReplacementNamed(context, "/notfound");
    } else {
      movie = setting.arguments as Map;
      ticketNumber = getTicketNumber(60 - movie["ticket"] + 1);
    }
    return Scaffold(
      appBar: g.defaultAppbar(context, allowMainMenu: true),
      body: WebSmoothScroll(
        animationDuration: 180,
        scrollOffset: 80,
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 20),
              alignment: Alignment.center,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("FS CINEMA", style: TextStyle(color: g.colorPallet[9], fontSize: 30, fontWeight: FontWeight.w700)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                      width: 800,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Holder: ${g.currentUser.isNotEmpty ? g.currentUser["name"] : "Guest"}", style: TextStyle(color: g.colorPallet[9], fontSize: 16, fontWeight: FontWeight.w400)),
                              Text("Movie: ${movie["name"]}", style: TextStyle(color: g.colorPallet[9], fontSize: 16, fontWeight: FontWeight.w400)),
                              Text("Ticket Number: $ticketNumber", style: TextStyle(color: g.colorPallet[9], fontSize: 16, fontWeight: FontWeight.w400)),
                              Text("Ticket Id: ${movie["id"]}", style: TextStyle(color: g.colorPallet[9], fontSize: 16, fontWeight: FontWeight.w400)),
                            ],
                          ),

                          Image.network("https://upload.wikimedia.org/wikipedia/commons/2/2f/Rickrolling_QR_code.png", width: 180, height: 180,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 8.0),
              child: Container(height: 1, color: g.colorPallet[4]),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 800, vertical: 16.0),
              child: Button(
                onClick: () => Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false),
                size: const Size(300, 50),
                color: g.colorPallet[9],
                child: Text("RETURN TO MAIN MENU", style: TextStyle(color: g.colorPallet[0], fontSize: 24, fontWeight: FontWeight.w700)),
              ),
            ),

            const SizedBox(height: 600),

            g.footer,
          ],
        ),
      ),
    );
  }

  String getTicketNumber (number) {
    String text = "";
    if (number / 10 == 0) {
      text = "A$number";
    } else if (number / 10 == 1) {
      text = "B${(number % 10) + 1}";
    } else if (number / 10 == 2) {
      text = "C${(number % 10) + 1}";
    } else if (number / 10 == 3) {
      text = "D${(number % 10) + 1}";
    } else if (number / 10 == 4) {
      text = "E${(number % 10) + 1}";
    } else if (number / 10 == 5) {
      text = "F${(number % 10) + 1}";
    } else {
      text = "G${(number % 10) + 1}";
    }
    return text;
  }

}
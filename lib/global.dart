import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:movie_ticket/widget/clickable.dart';

// database
final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

final List colorPallet = [
  const Color.fromARGB(255, 255, 255, 255),
  const Color.fromARGB(255, 248, 249, 250),
  const Color.fromARGB(255, 233, 236, 239),
  const Color.fromARGB(255, 222, 226, 230),
  const Color.fromARGB(255, 206, 212, 218),
  const Color.fromARGB(255, 173, 181, 189),
  const Color.fromARGB(255, 108, 117, 125),
  const Color.fromARGB(255, 73, 80, 87),
  const Color.fromARGB(255, 52, 58, 64),
  const Color.fromARGB(255, 33, 37, 41),
  const Color.fromARGB(255, 14, 16, 17),
];

//encryp
const String encKey = "0eMz9+VoV2g=";

// currentUser
Map currentUser = {};

//Widget
defaultAppbar(context, {allowMainMenu = false}) {
  return AppBar(
    elevation: 8,
    automaticallyImplyLeading: false,
    flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentUser["rank"] != "admin") ... [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (allowMainMenu) {
                    Navigator.pushReplacementNamed(context, "/home");
                  }
                },
                child: Image.asset("assets/logo/white_logo.png", color: colorPallet[9])
              ),
            ] else ... [
              const SizedBox(),
            ],
              
            if (currentUser.isEmpty) ... [
              Button(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                onClick: () => Navigator.pushNamed(context, "/register"),
                color: colorPallet[9],
                size: const Size(160, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.person_outlined, color: colorPallet[0]),
                    Text("Login / Register", style: TextStyle(color: colorPallet[0])),
                  ],
                ),
              ),
            ] else ... [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (currentUser["rank"] != "normal" && currentUser["rank"] != "admin") ... [
                    Container(
                      alignment: Alignment.center,
                      height: 20,
                      color: currentUser["rank"].split(" ")[1] == "sliver" ? Colors.grey[400] : currentUser["rank"].split(" ")[1] == "gold" ? Colors.yellow[400] : Colors.blue[300],
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(currentUser["rank"].split(" ")[1].toUpperCase(), style: TextStyle(color: colorPallet[0], fontWeight: FontWeight.w400)),
                    )
                  ],
                  const SizedBox(width: 10.0),

                  Text("|  ${currentUser["name"]}  |", style: TextStyle(color: colorPallet[9], fontWeight: FontWeight.w400, fontSize: 20)),
                  const SizedBox(width: 16.0),

                  Button(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    onClick: () {
                      currentUser.clear();
                      String currentRoute = ModalRoute.of(context)!.settings.name!;
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        currentRoute == "/member" || currentRoute == "/admin" ? "/home" : currentRoute,
                        (route) => false
                      );
                    },
                    size: const Size(100, 40),
                    color: colorPallet[9],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.logout_sharp, color: colorPallet[0]),
                        Text("Logout", style: TextStyle(color: colorPallet[0])),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ],
        ),
      ),
  );
}

Widget footer = Container(
  height: 100,
  color: colorPallet[9],
  padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 16.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          Icon(Icons.copyright, color: colorPallet[6]),
          const SizedBox(width: 8,),
          Text("2022 | This is a mock up website made for homework purpose only.", style: TextStyle(color: colorPallet[6], fontSize: 14.0)),
        ]
      ),
      Text("FS Cinema call : 42069", style: TextStyle(color: colorPallet[6], fontSize: 24.0)),
    ],
  ),
);
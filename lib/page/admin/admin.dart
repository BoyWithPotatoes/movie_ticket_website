import 'dart:math';

import 'package:encryptor/encryptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:movie_ticket/global.dart' as g;

import 'package:movie_ticket/widget/clickable.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String _currentPage = "none";

  @override
  void initState() {
    if (g.currentUser.isEmpty || g.currentUser["rank"] != "admin") {
      Navigator.pushReplacementNamed(context, "/notfound");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: g.defaultAppbar(context),
      body: Container(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 64.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: ListView(
                clipBehavior: Clip.none,
                children: [
                  Button(
                    size: const Size(double.maxFinite, 50),
                    color: g.colorPallet[_currentPage == "user" ? 9 : 3],
                    onClick: () {
                      if (_currentPage == "user") {return;}
                      setState(() => _currentPage = "user");
                    },
                    child: Text("USERS", style: TextStyle(color: g.colorPallet[_currentPage == "user" ? 0 : 9], fontSize: 18, fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 32.0),

                  Button(
                    size: const Size(double.maxFinite, 50),
                    color: g.colorPallet[_currentPage == "movie" ? 9 : 3],
                    onClick: () {
                      if (_currentPage == "movie") {return;}
                      setState(() => _currentPage = "movie");
                    },
                    child: Text("MOVIES", style: TextStyle(color: g.colorPallet[_currentPage == "movie" ? 0 : 9], fontSize: 18, fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 32.0),

                ],
              )
            ),
            Flexible(
            flex: 3,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 32.0),
                child: _currentPage == "none" ? createEmptyPage() : _currentPage == "user" ? const UserInfo() : const MovieInfo(),
              ),
            ),
          ],
        ),
      ),
    );

  }
 
  createEmptyPage() {
    bool ran = Random().nextInt(10) == 7;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(ran ? "🗿" : "🙂", style: const TextStyle(fontSize: 100.0)),
        const SizedBox(height: 8.0,),
        Text(ran ? "oOOooOOOoAAAAaaAAAAAAaaAAaaaAAaA" : "wow, such empty", style: TextStyle(color: g.colorPallet[9], fontSize: 16.0, fontWeight: FontWeight.w200)),
      ],
    );
  }
  
}

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}
class _UserInfoState extends State<UserInfo> {
  final List _enable = [];
  Future _getData () async {
    List data = [];
    await g.db.collection("users").get().then((value) {
      for (var e in value.docs) {
        Map user = e.data();
        user["id"] = e.id;
        _enable.add(false);
        data.add(user);
      }
    });
    return data;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data as List;
          return ListView(
            clipBehavior: Clip.none,
            children: List.generate(data.length, (index) {
              var controller = [
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ];
              return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 8,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: controller[0]..text = data[index]["user"],
                          enabled: _enable[index],
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 10.0),
                            labelText: "USERNAME",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[6]
                              )
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[2]
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.2,
                                color: g.colorPallet[8]
                              )
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextField(
                          controller: controller[1]..text = Encryptor.decrypt(g.encKey, data[index]["pass"]),
                          enabled: _enable[index],
                          obscureText: !_enable[index],
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 10.0),
                            labelText: "PASSWORD",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[6]
                              )
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[2]
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.2,
                                color: g.colorPallet[8]
                              )
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextField(
                          controller: controller[2]..text = data[index]["email"],
                          enabled: _enable[index],
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 10.0),
                            labelText: "EMAIL",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[6]
                              )
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[2]
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.2,
                                color: g.colorPallet[8]
                              )
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextField(
                          controller: controller[3]..text = data[index]["name"],
                          enabled: _enable[index],
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 10.0),
                            labelText: "NAME",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[6]
                              )
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[2]
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.2,
                                color: g.colorPallet[8]
                              )
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextField(
                          controller: controller[4]..text = data[index]["rank"],
                          enabled: _enable[index],
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 10.0),
                            labelText: "MAMERSHIP",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[6]
                              )
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[2]
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.2,
                                color: g.colorPallet[8]
                              )
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
            
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(data[index]["id"], style: TextStyle(color: data[index]["rank"] == "admin" ? Colors.blue : g.colorPallet[4], fontWeight: FontWeight.w200, fontSize: 14.0)),
                            const Spacer(),
            
                            ClickableText(
                              _enable[index] ? "Done" : "edit",
                              fontColor: _enable[index] ? Colors.green : g.colorPallet[6],
                              onClick: () async {
                                if (_enable[index]) {
                                  await g.db.collection("users").doc(data[index]["id"]).update({
                                    "user": controller[0].text,
                                    "pass": Encryptor.encrypt(g.encKey, controller[1].text),
                                    "email": controller[2].text,
                                    "name": controller[3].text,
                                    "rank": controller[4].text,
                                  });

                                }
                                setState(() => _enable[index] = !_enable[index]);
                              },
                            ),
                            const SizedBox(width: 12),
            
                            ClickableText(
                              !_enable[index] ? "Delete" : "Cancel",
                              fontColor: !_enable[index] ? Colors.red : g.colorPallet[6],
                              onClick: () async {
                                if (_enable[index]) {
                                  _enable[index] = false;
                                } else {
                                  await g.db.collection("users").doc(data[index]["id"]).delete();
                                }
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8.0)
              ],
            );
            }),
          );
        }
        return CircularProgressIndicator(color: g.colorPallet[9]);
      }
    );
  }
}

class MovieInfo extends StatefulWidget {
  const MovieInfo({super.key});

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  final List _enable = [];
  final List _err = [];
  final List _addController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  String _addErr = "";
  final Map _addImage = {};
  bool _addLoading = false;

  _getData () async {
    List data = [];
    await g.db.collection("movie").get().then((value) {
      for (var e in value.docs) {
        Map movie = e.data();
        movie["id"] = e.id;
        data.add(movie);
        _enable.add(false);
        _err.add("");
      }
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data as List;
          return ListView(
            clipBehavior: Clip.none,
            children: List.generate(data.length + 1, (i) {
              int index = i - 1;
              var editController = [
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ];
              return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (i == 0) ... [
                  Card(
                    elevation: 8,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context, 
                          builder: (context) {
                            _addController[0].clear();
                            _addController[1].clear();
                            _addController[2].clear();
                            _addErr = "";
                            _addImage.clear();
                            _addLoading = false;
                            return StatefulBuilder(
                              builder: (context, setS) =>  Dialog(
                                elevation: 8,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  width: 500,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("ADD MOVIE", style: TextStyle(color: g.colorPallet[9], fontSize: 20, fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 16),

                                      TextField(
                                        controller: _addController[0],
                                        enabled: !_addLoading,
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(fontSize: 10.0),
                                          labelText: "NAME",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[6]
                                            )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[2]
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.2,
                                              color: g.colorPallet[8]
                                            )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                            
                                      TextField(
                                        controller: _addController[1],
                                        enabled: !_addLoading,
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(fontSize: 10.0),
                                          labelText: "GERNE",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[6]
                                            )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[2]
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.2,
                                              color: g.colorPallet[8]
                                            )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                            
                                      TextField(
                                        controller: _addController[2],
                                        enabled: !_addLoading,
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(fontSize: 10.0),
                                          labelText: "YEAR",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[6]
                                            )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[2]
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.2,
                                              color: g.colorPallet[8]
                                            )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      Text(_addErr, style: const TextStyle(color: Colors.red)),
                                      const SizedBox(height: 8),
                            
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Button(
                                            onClick: () async {
                                              final result = await FilePicker.platform.pickFiles(type: FileType.image);
                                              if (result != null) {
                                                setS(() {
                                                  _addImage["name"] = result.files.first.name;
                                                  _addImage["byte"] = result.files.first.bytes;
                                                });
                                              }
                                            },
                                            color: g.colorPallet[9],
                                            padding: const EdgeInsets.all(8.0),
                                            size: const Size(160, 42),
                                            child: Text("UPLOAD IMAGE", style: TextStyle(color: g.colorPallet[0], fontSize: 14)),
                                          ),
                                          const SizedBox(width: 12),
                                          
                                          if (_addImage["name"] != null) ... [
                                            Text(_addImage["name"], style: TextStyle(color: g.colorPallet[9], fontSize: 14, fontWeight: FontWeight.w200)),
                                          ]
                                        ],
                                      ),
                                      
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          if (_addLoading) ... [
                                            const Text("Loading...", style: TextStyle(fontSize: 14, color: Colors.blue)),
                                          ],
                                          const SizedBox(width: 16),

                                          ClickableText(
                                            "Done",
                                            fontColor: Colors.green,
                                            onClick: () async {
                                              _addErr = "";
                                              if (_addController[0].text.trim().isEmpty) {
                                                _addErr = "Name cannnot be blank";
                                              } else if (_addController[1].text.trim().isEmpty) {
                                                _addErr = "Gerne cannot be blank";
                                              } else if (_addController[2].text.trim().isEmpty) {
                                                _addErr = "Year cannot be blank";
                                              } else if (_addImage["byte"] == null) {
                                                _addErr = "Cannot find any image";
                                              }
                                              setS(() {});
                                              if (_addErr.isEmpty) {
                                                setS(() => _addLoading = true);
                                                var task = g.storage.ref().child("movie_poster/${_addImage["name"]}").putData(_addImage["byte"]);
                                                var snapshot = await task.whenComplete(() {});
                                                var url = await snapshot.ref.getDownloadURL();
                                                g.db.collection("movie").add({
                                                  "name": _addController[0].text,
                                                  "gerne": _addController[1].text,
                                                  "year": _addController[2].text,
                                                  "ticket": 60,
                                                  "poster": url,
                                                }).then((value) {
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                });
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 12),
                                                
                                          ClickableText(
                                            "Cancel",
                                            fontColor: g.colorPallet[6],
                                            onClick: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: double.maxFinite,
                        child: Icon(Icons.add, color: g.colorPallet[5], size: 32.0),
                      ),
                    ),
                  ),
                ] else ... [
                  Card(
                    elevation: 8,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      width: double.maxFinite,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Image.network(data[index]["poster"], height: 200 * 3 / 2, width: 200, fit: BoxFit.cover)
                                ),
                              ),
                              Flexible(
                                flex: 6,
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  height: 200 * 3 / 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      TextField(
                                        controller: editController[0]..text = data[index]["name"],
                                        enabled: _enable[index],
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(fontSize: 10.0),
                                          labelText: "NAME",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[6]
                                            )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[2]
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.2,
                                              color: g.colorPallet[8]
                                            )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      TextField(
                                        controller: editController[1]..text = data[index]["gerne"],
                                        enabled: _enable[index],
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(fontSize: 10.0),
                                          labelText: "GERNE",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[6]
                                            )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[2]
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.2,
                                              color: g.colorPallet[8]
                                            )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      TextField(
                                        controller: editController[2]..text = data[index]["year"],
                                        enabled: _enable[index],
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(fontSize: 10.0),
                                          labelText: "GERNE",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[6]
                                            )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[2]
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.2,
                                              color: g.colorPallet[8]
                                            )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      TextField(
                                        controller: editController[3]..text = data[index]["ticket"].toString(),
                                        enabled: _enable[index],
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(fontSize: 10.0),
                                          labelText: "TICKET",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[6]
                                            )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.0,
                                              color: g.colorPallet[2]
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              width: 1.2,
                                              color: g.colorPallet[8]
                                            )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(_err[index], style: const TextStyle(color: Colors.red))
                                    ],
                                  ),
                                )
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(data[index]["id"], style: TextStyle(color: g.colorPallet[4], fontWeight: FontWeight.w200, fontSize: 14.0)),
                              const Spacer(),
              
                              ClickableText(
                                _enable[index] ? "Done" : "edit",
                                fontColor: _enable[index] ? Colors.green : g.colorPallet[6],
                                onClick: () async {
                                  if (_enable[index]) {
                                    _err[index] = "";
                                    if (RegExp(r'^\d*').stringMatch(editController[3].text) != "") {
                                      await g.db.collection("movie").doc(data[index]["id"]).update({
                                        "name": editController[0].text,
                                        "gerne": editController[1].text,
                                        "year": editController[2].text,
                                        "ticket": int.parse(RegExp(r'(^\d*)').stringMatch(editController[3].text)!),
                                      });
                                    } else {
                                      _err[index] = "Incorrect number format";
                                    }
                                  }
                                  setState(() => _enable[index] = !_enable[index]);
                                },
                              ),
                              const SizedBox(width: 12),
              
                              ClickableText(
                                !_enable[index] ? "Delete" : "Cancel",
                                fontColor: !_enable[index] ? Colors.red : g.colorPallet[6],
                                onClick: () async {
                                  if (_enable[index]) {
                                    _enable[index] = false;
                                  } else {
                                    await g.db.collection("movie").doc(data[index]["id"]).delete();
                                    await g.storage.ref(data[index]["poster"]).delete();
                                  }
                                  setState(() {});
                                },
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 8.0)
              ],
            );
            }),
          );
        }
        return CircularProgressIndicator(color: g.colorPallet[9]);
      }
    );
  }
}

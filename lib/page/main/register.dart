import 'package:encryptor/encryptor.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket/widget/clickable.dart';

import '../../global.dart' as g;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final double _sHeight = 20.0;
  bool _loginFail = false;
  bool _login = false;
  final List _regFail = ["", "", "", "", ""];
  final List _loginController = [
    TextEditingController(),
    TextEditingController(),
  ];
  final List _regController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List _password = [
    true,
    true,
    true,
  ];

  void reset () {
    _loginFail = false;
    for (int i = 0; i < _regFail.length; i++) { _regFail[i] = ""; }
    for (int i = 0; i < _password.length; i++) { _password[i] = true; }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 6,
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 240.0, vertical: 50.0),
                  child: Form(
                    child: ListView(
                      addAutomaticKeepAlives: true,
                      clipBehavior: Clip.none,
                      children: !_login ? [
                        Text("Create\nyour\naccount".toUpperCase(), style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w400, color: g.colorPallet[8])),
                        SizedBox(height: _sHeight * 3),

                        TextField(
                          controller: _regController[0],
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.2,
                                color: g.colorPallet[8]
                              )
                            ),
                          ),
                        ),
                        Text(_regFail[0], style: const TextStyle(color: Colors.red)),
                        SizedBox(height: _sHeight),

                        TextField(
                          controller: _regController[1],
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.2,
                                color: g.colorPallet[8]
                              )
                            ),
                          ),
                        ),
                        Text(_regFail[1], style: const TextStyle(color: Colors.red)),
                        SizedBox(height: _sHeight),

                        TextFormField(
                          controller: _regController[2],
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 10.0),
                            labelText: "E-MAIL",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[6]
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
                        Text(_regFail[2], style: const TextStyle(color: Colors.red)),
                        SizedBox(height: _sHeight),

                        TextFormField(
                          controller: _regController[3],
                          obscureText: _password[0],
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.2,
                                color: g.colorPallet[8]
                              )
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_password[0] ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                              onPressed: () => setState(() => _password[0] = !_password[0]),
                            ),
                          ),
                        ),
                        Text(_regFail[3], style: const TextStyle(color: Colors.red)),
                        SizedBox(height: _sHeight),

                        TextFormField(
                          controller: _regController[4],
                          obscureText: _password[2],
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 10.0),
                            labelText: "CONFIRM PASSWORD",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: g.colorPallet[6]
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.2,
                                color: g.colorPallet[8]
                              )
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_password[2] ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                              onPressed: () => setState(() => _password[2] = !_password[2]),
                            ),
                          ),
                        ),
                        Text(_regFail[4], style: const TextStyle(color: Colors.red)),
                        SizedBox(height: _sHeight),

                        Button(
                          onClick: () {
                            bool err = false;
                            setState(() {
                              _regFail[0] = "";
                              _regFail[1] = "";
                              _regFail[2] = "";
                              _regFail[3] = "";
                              _regFail[4] = "";
                            });
                            if (_regController[0].text.isEmpty) {
                              setState(() => _regFail[0] = "Name cannot be blank");
                              err = true;
                            }

                            if (_regController[2].text.isEmpty) {
                              setState(() => _regFail[2] = "E-mail cannot be blank");
                              err = true;
                            } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_regController[2].text)) {
                              setState(() => _regFail[2] = "Incorrect e-mail format. Example : example@example.com");
                              err = true;
                            }
                            
                            if (_regController[3].text.isEmpty) {
                              setState(() => _regFail[3] = "Password cannot be blank");
                              err = true;
                            } else if (_regController[3].text.split(" ").length > 1) {
                              setState(() => _regFail[3] = "Password cannot contain space character");
                              err = true;
                            } else if (_regController[3].text.length < 8) {
                              setState(() => _regFail[3] = "Password must be at least 8 character long");
                              err = true;
                            }

                            if (_regController[4].text.isEmpty) {
                              setState(() => _regFail[4] = "Password cannot be blank");
                              err = true;
                            } else if (_regController[3].text != _regController[4].text) {
                              setState(() => _regFail[4] = "Password did not match. Please try again");
                              err = true;
                            }

                            if (_regController[1].text.isEmpty) {
                              setState(() => _regFail[1] = "Username cannot be blank");
                              err = true;
                            } else if (_regController[1].text.split(" ").length > 1) {
                              setState(() => _regFail[1] = "Username cannot contain space character");
                              err = true;
                            } else {
                              g.db.collection("users").where("user", isEqualTo: _regController[1].text).get().then((value) {
                                for (var e in value.docs) {
                                  if (e.data()["user"] == _regController[1].text) {
                                    err = true;
                                    setState(() => _regFail[1] = "This user already exist");
                                  }
                                }
                                if (!err) {
                                  Map<String, dynamic> user = {
                                    "name": _regController[0].text.trim(),
                                    "user": _regController[1].text,
                                    "pass": Encryptor.encrypt(g.encKey, _regController[3].text),
                                    "e-mail": _regController[2].text,
                                    "rank": "normal"
                                  };
                                  g.db.collection("users").add(user).then((value) {
                                    g.currentUser = user;
                                    g.currentUser["id"] = value.id;
                                    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                                  });
                                  }
                              });
                            }

                          },
                          size: const Size(double.infinity, 50),
                          color: g.colorPallet[9],
                          child: Text("REGISTER", style: TextStyle(color: g.colorPallet[0], fontSize: 20)),
                        ),
                        SizedBox(height: _sHeight),

                        Container(height: 1.0, color: g.colorPallet[5]),
                        SizedBox(height: _sHeight),

                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(text: "Already have an account ? "),
                              WidgetSpan(
                                child: ClickableText(
                                  "Login",
                                  onClick: () {
                                    setState(() {
                                      _login = true;
                                      reset();
                                    });
                                  },
                                  fontColor: Colors.blue,
                                )
                              ),
                            ]
                          ),
                        ),

                      ] : [
                        Text("LOGIN".toUpperCase(), style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w400, color: g.colorPallet[8])),
                        SizedBox(height: _sHeight * 3),

                        TextFormField(
                          controller: _loginController[0],
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.2,
                                color: g.colorPallet[8]
                              )
                            ),
                          ),
                        ),
                        SizedBox(height: _sHeight),

                        TextFormField(
                          controller: _loginController[1],
                          obscureText: _password[1],
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                width: 1.2,
                                color: g.colorPallet[8]
                              )
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_password[1] ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                              onPressed: () => setState(() => _password[1] = !_password[1]),
                            ),
                          ),
                        ),
                        SizedBox(height: _sHeight),

                        if (_loginFail) ... [
                          const Text("Your username or your password is incorrect. Please try again.", style: TextStyle(color: Colors.red)),
                          SizedBox(height: _sHeight),
                        ],

                        Button(
                          onClick: () {
                            setState(() => _loginFail = false);
                            g.db.collection("users").where("user", isEqualTo: _loginController[0].text).get().then((value) {
                              for (var e in value.docs) {
                                if (Encryptor.decrypt(g.encKey, e.data()["pass"]) == _loginController[1].text) {
                                  g.currentUser = e.data();
                                  g.currentUser["id"] = e.id;
                                  Navigator.pushNamedAndRemoveUntil(context, g.currentUser["rank"] == "admin" ? "/admin" : "/home", (route) => false);
                                  setState(() => _loginFail = false);
                                  return;
                                }
                              }
                              setState(() => _loginFail = true);
                            });
                          },
                          size: const Size(double.infinity, 50),
                          color: g.colorPallet[9],
                          child: Text("LOGIN", style: TextStyle(color: g.colorPallet[0], fontSize: 20)),
                        ),
                        SizedBox(height: _sHeight),

                        Container(height: 1.0, color: g.colorPallet[5]),
                        SizedBox(height: _sHeight),

                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(text: "Don't have an account ? "),
                              WidgetSpan(
                                child: ClickableText(
                                  "Register",
                                  onClick: () => setState(() {
                                    _login = false;
                                    reset();
                                  }),
                                  fontColor: Colors.blue,
                                )
                              ),
                            ]
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (screenSize.width > 1500)
              Flexible(
                flex: 4,
                child: Image.asset("assets/login/movie_theater.jpg", fit: BoxFit.fitHeight, height: screenSize.height)
              )
          ],
        ),
      ),
    );
  }
}
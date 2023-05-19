import 'dart:convert';

import 'package:classroom/auth/login.dart';
import 'package:classroom/home/rep_features.dart';
import 'package:classroom/report/all_applicant.dart';
import 'package:classroom/report/report.dart';
import 'package:classroom/upload/DocumentUploader.dart';
import 'package:flutter/material.dart';

import '../auth/profile.dart';

class homepage extends StatefulWidget {
  final token;
  const homepage({super.key, required this.token});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "ClassRoom",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.notifications,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://4.bp.blogspot.com/-Jx21kNqFSTU/UXemtqPhZCI/AAAAAAAAh74/BMGSzpU6F48/s1600/funny-cat-pictures-047-001.jpg"),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => repFeatures(
                                token: widget.token,
                              )));
                },
                child: Container(
                  height: size.height * 0.4,
                  width: size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromARGB(255, 251, 223, 226)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Assignment Report",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("All the Detail's of Student Marks"),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 150,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(252, 147, 116, 248),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: const Padding(
                          padding: EdgeInsets.all(13.0),
                          child: Center(
                              child: Text(
                            "Check Now",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      Image.asset(
                        "assets/images/car.jpg",
                        height: size.height * 0.16,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color.fromARGB(255, 217, 234, 253)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      "assets/images/card2.jpg",
                      height: size.height * 0.16,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Submit Assignment",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Upload documents in Pdf/Docs Only"),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentUploader(
                                      token: widget.token,
                                    )));
                      },
                      child: Container(
                        width: 150,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(252, 147, 116, 248),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: const Padding(
                          padding: EdgeInsets.all(13.0),
                          child: Center(
                              child: Text(
                            "Upload Now",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

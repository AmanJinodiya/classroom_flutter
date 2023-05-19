import 'package:classroom/report/report.dart';
import 'package:classroom/report/teachReport.dart';
import 'package:flutter/material.dart';

import '../report/all_applicant.dart';

class repFeatures extends StatefulWidget {
  final token;
  const repFeatures({super.key, required this.token});

  @override
  State<repFeatures> createState() => _repFeaturesState();
}

class _repFeaturesState extends State<repFeatures> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => allApplicant(
                              token: widget.token,
                            )));
              },
              child: Container(
                height: size.height * 0.2,
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
                      "Plagiarism Detector",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      "assets/images/car.jpg",
                      height: size.height * 0.05,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            teachReport(token: widget.token)));
              },
              child: Container(
                height: size.height * 0.2,
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
                      height: size.height * 0.08,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Similarity from Teacher File",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

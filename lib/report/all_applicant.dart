import 'dart:convert';

import 'package:classroom/report/report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../upload/docScree.dart';
import 'details.dart';

import 'package:http/http.dart' as http;

class allApplicant extends StatefulWidget {
  final String token;
  const allApplicant({super.key, required this.token});

  @override
  State<allApplicant> createState() => _allApplicantState();
}

class _allApplicantState extends State<allApplicant> {
  List<Map<String, Object>> lis = [];

  getdata() async {
    final urlprofile = Uri.parse('http://10.0.2.2:8000/profile/');
    final headers = {'Authorization': 'Token ${widget.token}'};
    print(widget.token);
    final response = await http.get(urlprofile, headers: headers);
    if (response.statusCode == 200) {
      // Request was successful
      final data = jsonDecode(response.body);
      final url = Uri.parse('http://10.0.2.2:8000/show_paper/');
      print(data["class_num"]);
      final queryParams = {'class_num': data["class_num"].toString()};
      final response1 = await http
          .get(url.replace(queryParameters: queryParams), headers: headers);
      if (response1.statusCode == 200) {
        // Request was successful
        print("here");
        print(response1.body.toString());
        final List<dynamic> data = jsonDecode(response1.body);
        final List<Map<String, Object>> dataList =
            data.map((item) => Map<String, Object>.from(item)).toList();
        setState(() {
          lis = dataList;
        });
      } else {
        // Request failed
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } else {
      // Request failed
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: lis.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => report(
                                        token: widget.token,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            title: Text(
                              'UE20801${index.toString()}',
                              style: TextStyle(color: Colors.green),
                            ),
                            subtitle: Text(
                                "Submitted AssIgnment at ${DateFormat('MMM dd, yyyy - hh:mm a').format(DateTime.parse(lis[index]['time'] as String))}"),
                            leading: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://4.bp.blogspot.com/-Jx21kNqFSTU/UXemtqPhZCI/AAAAAAAAh74/BMGSzpU6F48/s1600/funny-cat-pictures-047-001.jpg"),
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DocumentScreen(
                                              documentUrl:
                                                  "http://10.0.2.2:8000${lis[index]['paper'] as String}")));
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 217, 234, 253)),
                                ),
                                child: const Text(
                                  "See File",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => report(
                              token: widget.token,
                            )));
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 217, 234, 253),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: const Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Text(
                    "Report",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

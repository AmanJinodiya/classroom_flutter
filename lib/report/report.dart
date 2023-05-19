import 'dart:convert';
import 'dart:ffi';
import 'package:classroom/report/details.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class report extends StatefulWidget {
  final String token;
  const report({super.key, required this.token});

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  List<dt> lis = [];

  var inp = [];

  getRequest() async {
    final urlprofile = Uri.parse('http://10.0.2.2:8000/profile/');
    final headers = {'Authorization': 'Token ${widget.token}'};
    print(widget.token);
    final response = await http.get(urlprofile, headers: headers);
    if (response.statusCode == 200) {
      // Request was successful
      final data = jsonDecode(response.body);
      final url = Uri.parse('http://10.0.2.2:8000/check_result/');
      print(data["class_num"]);
      final queryParams = {'class_num': data["class_num"].toString()};
      final response1 = await http
          .get(url.replace(queryParameters: queryParams), headers: headers);
      if (response1.statusCode == 200) {
        // Request was successful
        print("here");
        print(response1.body.toString());
        final data = jsonDecode(response1.body);

        setState(() {
          inp = data;
          // fake_datea = data;
          inp = inp.reversed.toList();
          for (int i = 0; i < inp.length; i++) {
            lis.add(dt(i + 1, double.parse(inp[i]) * 100));
          }
          // print(fake_datea.length);
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

  List<String> fake_datea = [];

  Map<String, Map<String, double>> fakeDict = {};

  List<double> de = [];
  List<List<String>> paperInfo = [];

  List<dtq> am = [];
  over() {
    // for (String paperData in fake_datea) {
    //   List<String> info = paperData.split(',');
    //   am.add(dtq(info[0], info[1]));
    //   // String paperName =
    //   //     info[0].replaceAll('paper/', '').replaceAll('.docx', '');
    //   // String similarity = info[1];
    //   // paperInfo.add([paperName, similarity]);
    // }

    // fake_datea.forEach((item) {
    //   List<String> values = item.split(',');
    //   String paper1 = values[0][6];
    //   String paper2 = values[1][6];
    //   double similarity = double.parse(values[2]);
    //   double score = double.parse(values[3]);

    //   if (fakeDict.containsKey(paper1)) {
    //     fakeDict[paper1]![paper2] = similarity;
    //   } else {
    //     fakeDict[paper1] = {paper2: similarity};
    //   }

    //   if (fakeDict.containsKey(paper2)) {
    //     fakeDict[paper2]![paper1] = similarity;
    //   } else {
    //     fakeDict[paper2] = {paper1: similarity};
    //   }
    // });

    // for (int i = 1; i <= de.length; i++) {
    //   double a = 0, b = 0;
    //   fakeDict[(i - 1).toString()]!.forEach((key, value) {
    //     a += value;
    //   });

    // print(fakeDict.toString());
  }

  give_value(double a, int len) {
    return ((a / len) * 100).toStringAsFixed(2);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    over();
    getRequest();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: SfCartesianChart(
                  primaryXAxis: NumericAxis(minimum: 0, interval: 1),
                  series: <ChartSeries>[
                    ColumnSeries<dt, double>(
                        dataSource: lis,
                        xValueMapper: (dt l, _) => l.roll,
                        yValueMapper: (dt l, _) => l.chet)
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: inp.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => details(
                          //             roll: index,
                          //             det: fakeDict[(index + 1).toString()]!)));
                        },
                        child: ListTile(
                          title: Text(
                            'UE20801${index.toString()}',
                            style: TextStyle(
                                color: (double.parse(inp[index]) > 0.8)
                                    ? Colors.red
                                    : Colors.green),
                          ),
                          // subtitle: Text(paperInfo[index][1]),
                          trailing: Text(
                            ((double.parse(inp[index]) * 100).toInt())
                                    .toString() +
                                "%",
                            style: TextStyle(
                                color: (double.parse(inp[index]) > 0.8)
                                    ? Colors.red
                                    : Colors.black),
                          ),
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://4.bp.blogspot.com/-Jx21kNqFSTU/UXemtqPhZCI/AAAAAAAAh74/BMGSzpU6F48/s1600/funny-cat-pictures-047-001.jpg"),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class dt {
  dt(this.roll, this.chet);
  final double roll;
  final double chet;
}

class dtq {
  dtq(this.roll, this.chet);
  final String roll;
  final String chet;
}

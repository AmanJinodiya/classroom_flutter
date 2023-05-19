import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'details.dart';

class teachReport extends StatefulWidget {
  final String token;
  const teachReport({super.key, required this.token});

  @override
  State<teachReport> createState() => _teachReportState();
}

class _teachReportState extends State<teachReport> {
  List<dt> lis = [];

  getRequest() async {
    // //replace your restFull API here.
    // String url = "http://127.0.0.1:8000/check_result/?class_num=1";
    // final response = await http.get(Uri.parse(url));

    // var responseData = json.decode(response.body);

    // //Creating a list to store input data;
    // List<String> users = [];
    // for (var x in responseData) {
    //   users.add(x);
    // }

    // print(users.toString());

    // return users;

    final urlprofile = Uri.parse('http://10.0.2.2:8000/profile/');
    final headers = {'Authorization': 'Token ${widget.token}'};
    print(widget.token);
    final response = await http.get(urlprofile, headers: headers);
    if (response.statusCode == 200) {
      // Request was successful
      final data = jsonDecode(response.body);
      final url = Uri.parse('http://10.0.2.2:8000/check_answers/');
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
          fake_datea = data;
          fake_datea = fake_datea.reversed.toList();
          for (int i = 0; i < fake_datea.length; i++) {
            lis.add(dt(i + 1, double.parse(fake_datea[i]) * 100));
          }
          print(fake_datea.length);
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

  var fake_datea = [];

  give_value(double a, int len) {
    return ((a / len) * 100).toStringAsFixed(2);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // over();
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
                    itemCount: fake_datea.length,
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
                          title: Text('UE20801${index.toString()}',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          trailing: Text(
                            ((double.parse(fake_datea[index]) * 100).toInt())
                                    .toString() +
                                "%",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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

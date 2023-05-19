import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class details extends StatefulWidget {
  final roll;
  final Map<String, double> det;
  const details({super.key, required this.roll, required this.det});

  @override
  State<details> createState() => _detailsState();
}

List<dt> li = [];

class _detailsState extends State<details> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.det.forEach((key, value) {
      var ob = dt(double.parse(key), value);
      print("${ob.roll}, ${ob.chet}");
      li.add(ob);
    });

    print(li.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 250,
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    LineSeries<dt, double>(
                        dataSource: li,
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
                    itemCount: li.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          'UE20801${index.toString()}',
                          style: TextStyle(color: Colors.green),
                        ),
                        subtitle: Text(li[index].chet.toString()),
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://4.bp.blogspot.com/-Jx21kNqFSTU/UXemtqPhZCI/AAAAAAAAh74/BMGSzpU6F48/s1600/funny-cat-pictures-047-001.jpg"),
                        ),
                      );
                    }),
              ),
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

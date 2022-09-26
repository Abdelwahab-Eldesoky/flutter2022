import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:project/SecondPage.dart';
import 'dart:async';
import 'Info.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Info data = new Info();

  // This widget is the root of your application.
  Future<Null> selectInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: this.data.checkIN,
      firstDate: DateTime(DateTime.now().day),
      lastDate: DateTime(2040),
    );
    if (picked != Null && picked != this.data.checkIN) {
      setState(() {
        this.data.checkIN = picked!;
        print(this.data.checkIN.toString());
      });
    }
  }

  Future<Null> selectOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: this.data.checkIN,
      firstDate: DateTime(this.data.checkIN.year, this.data.checkIN.month,
          this.data.checkIN.day),
      lastDate: DateTime(2040),
    );
    if (picked != Null && picked != this.data.checkOUT) {
      setState(() {
        this.data.checkOUT = picked!;
        print(this.data.checkOUT.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Castaway Resort"), backgroundColor: Colors.cyan),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Image(image: AssetImage("images/welcome.jpg")),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text("Pick up Your Check In: ",style: TextStyle(color: Colors.cyan[800],fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        selectInDate(context);
                      },
                      icon: Icon(Icons.date_range),
                      color: Colors.cyan,
                    ),
                    Text(
                        ('${data.checkIN.year}-${data.checkIN.month}-${data.checkIN.day}')
                            .toString())
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Pick up Your Check Out: ",style: TextStyle(color: Colors.cyan[800],fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        selectOutDate(context);
                      },
                      icon: Icon(Icons.date_range),
                      color: Colors.cyan,
                    ),
                    Text(
                        ('${data.checkOUT.year}-${data.checkOUT.month}-${data.checkOUT.day}')
                            .toString())
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text("Adults:",style: TextStyle(color: Colors.cyan[800],fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 30,
                    ),
                    Slider(
                      value: data.noAdult,
                      onChanged: (count) {
                        setState(() {
                          data.noAdult = count;
                        });
                      },
                      label: data.noAdult.toInt().toString(),
                      min: 0,
                      max: 10,
                      divisions: 10,
                      activeColor: Colors.cyan,
                      inactiveColor: Colors.cyan[100],
                    ),
                    SizedBox(width: 10),
                    Text(data.noAdult.toInt().toString(),style: TextStyle(color: Colors.cyan[800],fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text("Children:",style: TextStyle(color: Colors.cyan[800],fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 30,
                    ),
                    Slider(
                      value: data.noChildren,
                      onChanged: (count) {
                        setState(() {
                          data.noChildren = count;
                        });
                      },
                      label: data.noChildren.toInt().toString(),
                      min: 0,
                      max: 10,
                      divisions: 10,
                      activeColor: Colors.cyan,
                      inactiveColor: Colors.cyan[100],
                    ),
                    SizedBox(width: 10),
                    Text(data.noChildren.toInt().toString(),style: TextStyle(color: Colors.cyan[800],fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Extras",style: TextStyle(color: Colors.cyan[800],fontWeight: FontWeight.bold)),
                    CheckboxGroup(
                        labels: <String>[
                          "Breakfast (50EGP/day)",
                          "Internet WiFi (50EGP/day)",
                          "Parking (100EGP/day)"
                        ],
                        onSelected: (List<String> checked) {
                          data.dataList = List.from(checked);
                          print(data.dataList.toString());
                        }),
                    Text("View",style: TextStyle(color: Colors.cyan[800],fontWeight: FontWeight.bold)),
                    RadioButtonGroup(
                      labels: <String>["Garden View", "Sea View"],
                      onSelected: (String selected) {
                        data.view = selected;
                        print(selected);
                      },
                    )
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan,
                      //onPrimary: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (Context) {
                        return SecondPage(data);
                      }));
                    },
                    child: Text("Search Rooms",style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

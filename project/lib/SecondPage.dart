import 'package:flutter/material.dart';
import 'Info.dart';

class MyItem {
  bool isExpanded;
  final Widget body;
  final Widget header;

  MyItem({this.isExpanded = false, required this.body, required this.header});
}

class SecondPage extends StatefulWidget {
  Info myInfo;

  SecondPage(Info this.myInfo);

  @override
  State<SecondPage> createState() => _SecondPageState(myInfo);
}

class _SecondPageState extends State<SecondPage> {
  Info? myInfo;
  bool singleRoomChoosen = false;
  bool doubleRoomChoosen = false;
  bool suiteRoomChoosen = false;

  List<MyItem> singleRoom = <MyItem>[
    MyItem(
      body: Row(
        children: [
          Image(
            image: NetworkImage(
                'https://as1.ftcdn.net/v2/jpg/03/22/73/02/1000_F_322730229_d3WmzXvTumDznXMxpz0ePEnmCvuuJrXm.jpg'),
            width: 100,
            height: 30,
          ),
          SizedBox(
            width: 50,
          ),
          Container(
              width: 200,
              child: Text(
                'A room assigned to one person.',
                style: TextStyle(fontSize: 18,color: Colors.cyan[800]),
              ))
        ],
      ),
      header: Row(children: <Widget>[
        Image(
          image: NetworkImage(
              'https://www.hotelparadies.com/fileadmin/_optimized_/1280/976935/csm_paradies-latsch-wohnen-single-room-1_105edfc753.jpg'),
          width: 100,
          height: 100,
        ),
        SizedBox(
          width: 15,
        ),
        Text('Single Room'),
        SizedBox(
          width: 15,
        ),
      ]),
    )
  ];

  List<MyItem> doubleRoom = <MyItem>[
    MyItem(
        body: Row(
          children: [
            Image(
              image: NetworkImage(
                  'https://as2.ftcdn.net/v2/jpg/03/42/48/61/1000_F_342486113_ifLbH9Y9c9bJvyrN5M3RAjnJc3jgmjHK.jpg'),
              width: 100,
              height: 30,
            ),
            SizedBox(
              width: 50,
            ),
            Column(children: [
              Container(
                  width: 200,
                  child: Text(
                      'A room For two people,May have one or more beds.',
                      style: TextStyle(fontSize: 18,color: Colors.cyan[800])))
            ]),
          ],
        ),
        header: Row(
          children: <Widget>[
            Image(
              image: NetworkImage(
                  'https://assets-global.website-files.com/5c6d6c45eaa55f57c6367749/628d35d6b9575f5b35b4231a_Twin%20Hotel%20Room%20(1)%20(1).jpg'),
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 15,
            ),
            Text('Double Room'),
            SizedBox(
              width: 15,
            ),
          ],
        ))
  ];
  List<MyItem> Suite = <MyItem>[
    MyItem(
        body: Row(
          children: [
            Image(
              image: NetworkImage(
                  'https://as1.ftcdn.net/v2/jpg/03/22/73/02/1000_F_322730229_d3WmzXvTumDznXMxpz0ePEnmCvuuJrXm.jpg'),
              width: 100,
              height: 30,
            ),
            SizedBox(
              width: 50,
            ),
            Column(children: [
              Container(
                width: 210,
                child: Text(
                    'A room with one or more bedrooms and a separate living spaces',
                    style: TextStyle(fontSize: 18,color: Colors.cyan[800])),
              )
            ])
          ],
        ),
        header: Row(children: <Widget>[
          Image(
            image: NetworkImage(
                'https://ecck.or.kr/wp-content/uploads/2019/05/GrandHyattSeoul-Presidential-Suite-1320x910.jpg'),
            width: 100,
            height: 100,
          ),
          SizedBox(
            width: 15,
          ),
          Text('Suite Room'),
          SizedBox(
            width: 25,
          ),
        ]))
  ];

  void showAlertDialog(BuildContext context) {
    String tmp =
        'This is a confirmation message that you agree all data entered\n Check in: ${myInfo!.checkIN.toString()}\nCheck out: ${myInfo!.checkOUT.toString()}\nNumber of Adults: ${myInfo!.noAdult}\nNumber of Children: ${myInfo!.noChildren}';

    if (singleRoomChoosen == true ||
        doubleRoomChoosen == true ||
        suiteRoomChoosen == true) {
      tmp = tmp + "\nChoosen Rooms: ";
      if (singleRoomChoosen) {
        tmp = tmp + "Single Room, ";
      }
      if (doubleRoomChoosen) {
        tmp = tmp + "Double Room, ";
      }
      if (suiteRoomChoosen) {
        tmp = tmp + "Suite Room, ";
      }
    }
    tmp = tmp + "\nExtras: ";
    myInfo!.dataList.forEach((element) {
      tmp = tmp + element;
    });
    var alertDialog = AlertDialog(
        title: Text('Are you sure you want to proceed to check out?'),
        content: Text(tmp),
        actions: [
          ElevatedButton(
              onPressed: () {
                print("Thanks");
                Navigator.pop(context);
              },
              child: Text('Confirm')),
        ]);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  _SecondPageState(Info? this.myInfo);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Castaway Resort"),
            backgroundColor: Colors.cyan,
          ),
          body: ListView(
            children: <Widget>[
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    singleRoom[index].isExpanded =
                        !singleRoom[index].isExpanded;
                  });
                },
                children: singleRoom.map<ExpansionPanel>((MyItem item) {
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Row(children: <Widget>[
                        Image(
                          image: NetworkImage(
                              'https://media-cdn.tripadvisor.com/media/photo-s/11/d7/82/0c/single-room.jpg'),
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('Single Room',
                            style: TextStyle(
                                color: Colors.cyan[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        SizedBox(
                          width: 15,
                        ),
                        Switch(
                          value: singleRoomChoosen,
                          onChanged: (bool val) {
                            setState(() {
                              singleRoomChoosen = val;
                            });
                          },
                          activeColor: Colors.cyanAccent,
                          inactiveThumbColor: Colors.cyan[200],
                        ),
                      ]);
                    },
                    body: item.body,
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    doubleRoom[index].isExpanded =
                        !doubleRoom[index].isExpanded;
                  });
                },
                children: doubleRoom.map<ExpansionPanel>((MyItem item) {
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Row(
                        children: <Widget>[
                          Image(
                            image: NetworkImage(
                                'https://media-cdn.tripadvisor.com/media/photo-s/0d/3d/4f/af/double-double-room.jpg'),
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Double Room',
                              style: TextStyle(
                                  color: Colors.cyan[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          SizedBox(
                            width: 15,
                          ),
                          Switch(
                            value: doubleRoomChoosen,
                            onChanged: (bool val) {
                              setState(() {
                                doubleRoomChoosen = val;
                              });
                            },
                            activeColor: Colors.cyanAccent,
                            inactiveThumbColor: Colors.cyan[200],
                          ),
                        ],
                      );
                    },
                    body: item.body,
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    Suite[index].isExpanded = !Suite[index].isExpanded;
                  });
                },
                children: Suite.map<ExpansionPanel>((MyItem item) {
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Row(children: <Widget>[
                        Image(
                          image: NetworkImage(
                              'https://media-cdn.tripadvisor.com/media/photo-s/22/ac/7b/b8/the-amayaa.jpg'),
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('Suite Room',
                            style: TextStyle(
                                color: Colors.cyan[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        SizedBox(
                          width: 25,
                        ),
                        Switch(
                          value: suiteRoomChoosen,
                          onChanged: (bool val) {
                            setState(() {
                              suiteRoomChoosen = val;
                            });
                          },
                          activeColor: Colors.cyanAccent,
                          inactiveThumbColor: Colors.cyan[200],
                        ),
                      ]);
                    },
                    body: item.body,
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    child: Text("Book Now"),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ))),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'Info.dart';

class MyItem {
  bool isExpanded;
  Widget header;
  String body;
  bool IsChoosen;
  String title;

  MyItem(
      {this.isExpanded = false,
      this.IsChoosen = false,
      required this.header,
      required this.body,
        required this.title});
}

class SecondPage extends StatefulWidget {
  Info myInfo;

  SecondPage(Info this.myInfo);

  @override
  State<SecondPage> createState() => _SecondPageState(myInfo);
}

class _SecondPageState extends State<SecondPage> {
  Info? myInfo;
  bool iexpander = false;
  List<MyItem> _itmes = <MyItem>[];

  void initState() {
    _itmes = <MyItem>[
      MyItem(
          IsChoosen: false,
          header: Row(
            children: <Widget>[
              Image(
                image: AssetImage("images/welcome.jpg"),
                width: 100,
                height: 80,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Single Room"),
            ],
          ),
          body: "Body1",title: "Single Room"),
      MyItem(
          header: Row(
            children: <Widget>[
              Image(
                image: AssetImage("images/welcome.jpg"),
                width: 100,
                height: 80,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Single Room"),
            ],
          ),
          body: "Body2",title: "Double Room"),
      MyItem(
          header: Row(
            children: <Widget>[
              Image(
                image: AssetImage("images/welcome.jpg"),
                width: 100,
                height: 80,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Single Room"),
            ],
          ),
          body: "Body3",title: "Suite Room"),
    ];
    settingHeaders(
        _itmes[0],
        "https://media-cdn.tripadvisor.com/media/photo-s/11/d7/82/0c/single-room.jpg",
        "Single Room");
    settingHeaders(
        _itmes[1],
        "https://media-cdn.tripadvisor.com/media/photo-s/0d/3d/4f/af/double-double-room.jpg",
        "Double Room");
    settingHeaders(
        _itmes[2],
        "https://media-cdn.tripadvisor.com/media/photo-s/22/ac/7b/b8/the-amayaa.jpg",
        "Suite Room");
  }

  void settingHeaders(MyItem x, String path, String title) {
    x.header = Row(
      children: <Widget>[
        Image(
          image: NetworkImage(path),
          width: 100,
          height: 80,
        ),
        SizedBox(
          width: 10,
        ),
        Text(title),
        SizedBox(
          width: 30,
        ),
        Switch(
          value: x.IsChoosen,
          onChanged: (state) {
            setState(() {
              x.IsChoosen = state;

            });
          },
          activeColor: Colors.purpleAccent,
          inactiveThumbColor: Colors.deepPurple,
        ),
      ],
    );
  }

  void showAlertDialog(BuildContext context) {
    String tmp='This is a confirmation message that you agree all data entered\n Check in: ${myInfo!.checkIN.toString()}\nCheck out: ${myInfo!.checkOUT.toString()}\nNumber of Adults: ${myInfo!.noAdult}\nNumber of Children: ${myInfo!.noChildren}\nChoosen Rooms: ';
    _itmes.forEach((element) {
      if(element.IsChoosen){
        tmp=tmp+"${element.title},";
      }
    });
    tmp=tmp+"\nExtras: ";
    myInfo!.dataList.forEach((element) {
      tmp=tmp+element;
    });
    var alertDialog = AlertDialog(
        title: Text('Are you sure you want to proceed to check out?'),
        content: Text(tmp),
        actions: [
          ElevatedButton(
              onPressed: () {
                print("Thanks");
                Navigator.pop(context);
              },
              child: Text('Confirm')),
        ]);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  _SecondPageState(Info? this.myInfo);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Castaway Resort"),
          ),
          body: ListView(
            children: <Widget>[
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _itmes[index].isExpanded = !_itmes[index].isExpanded;
                  });
                },
                children: _itmes.map<ExpansionPanel>((MyItem item) {
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: item.header,
                      );
                    },
                    body: ListTile(
                      title: Text(item.body),
                    ),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    child: Text("Book Now"),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),))),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
*/

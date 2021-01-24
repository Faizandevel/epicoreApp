import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testproject/BAQDT.dart';
// import 'package:baq/BAQDT.dart';

class BAQScreen extends StatefulWidget {
  const BAQScreen({
    Key key,
  }) : super(key: key);
  @override
  _BAQScreenState createState() => _BAQScreenState();
}

class _BAQScreenState extends State<BAQScreen> {
  Future baqData;
  Future showButton;
  Future addtofavButton;
  Future deleteFavBAQ;

  var respKey1;
  var allBaqs;
  var postData;
  List baqDataType = [];
  var allBaqsName;
  var customSearch = "";
  bool isVisibleSearch = false;
  bool isVisibleBAQ = false;
  bool isVisibleFavBAQ = false;

  var params = "";
  var dataKeys = "";
  var keys;
  var baqName;
  String dropDownValue;
  String favbaqsdropDownValue;
  String url = "https://m.kairossolutions.co/";
  var favbaqsdropdownitems = [];
  var favbaqsdropdownitemsadd = [];

  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNWZlYzY4ODJlYjRkMzk4ODk0OTNlYmE3IiwibmFtZSI6IkVwaWNvciBVU0EiLCJiYXNlNjR0b2tlbiI6IlMyRnBjbTl6UkdWMk1UcExRR2x5YjNOUVlYTnpPVGs9IiwidXNlcm5hbWUiOiJLYWlyb3NEZXYxIiwiYXBpdXJsIjoiaHR0cHM6Ly9jbG91ZDEua2Fpcm9zc29sdXRpb25zLmNvL2UxMGRlbW8vYXBpL3YxLyIsImNvbXBhbnkiOiJFUElDMDMiLCJGaXJzdE5hbWUiOiJpbXJhbiIsIkxhc3ROYW1lIjoiQWZ6YWwiLCJFbWFpbCI6ImZhbGFjeTEyMzQ1Njc4OUBnbWFpbC5jb20iLCJQaG9uZSI6IiIsIkNvdW50cnkiOiJVU0EiLCJBZGRyZXNzIjoiMTI2MDAgUyBUb3JyZW5jZSBBdmUiLCJDb21wYW55TmFtZSI6Im1lcmN1cnlzc29scyIsIkRhdGUiOiIyMDIxLTAxLTIyVDExOjU0OjAxLjY0OFoiLCJMaWNlbnNlIjoiNWZlYzY4MjUzZjIxZmQ4ODc2OThiMWNlIiwiaXNMaWNlbnNlaG9sZGVyIjp0cnVlLCJpc0FkbWluIjpmYWxzZSwicGxhbnQiOiJNZmdTeXMiLCJQbGFudE5hbWUiOiJDaGljYWdvIiwic2VjdXJpdHkiOlsiL3BvLyIsIi9wb2FwcHJvdmFsIiwiL3RpbWVlbnRyeSIsIi9iYXEiLCIvdGltZWFwcHJvdmFsIl0sInNlY3VyaXR5SnNvbiI6IltcIi9wby9cIixcIi9wb2FwcHJvdmFsXCIsXCIvdGltZWVudHJ5XCIsXCIvYmFxXCIsXCIvdGltZWFwcHJvdmFsXCJdIn0sImlhdCI6MTYxMTMxNjQ0MX0.ojoTCSmnjUjABMgtBnQQEmMUJRoIfGwaD-eO7EpkCvI";
  Future getBAQData() async {
    favbaqsdropdownitems.clear();
    var response = await http.get("${url}api/mbaq", headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    });
    //print(response.statusCode);
    if (response.statusCode == 200) {
      var dataforBaqDT = jsonDecode(response.body);
      keys = dataforBaqDT['key'];
      respKey1 = dataforBaqDT['key1'];
      favbaqsdropdownitems = dataforBaqDT["favbaq"];
      allBaqs = dataforBaqDT['allbaqs'];
      //allBaqsName = allBaqs[0]['name'];

      for (var item in respKey1) {
        baqDataType.add(item["DataType"]);
      }
      // print(dataKeys.toString());
      // var dataForkeys = response.body;
      // dataKeys = dataForkeys["key"]
      //print(dataKeys);

      for (var item in keys) {
        dataKeys = dataKeys + "," + item;
      }
      dataKeys = dataKeys.substring(1);
      // print(dataKeys);

      baqName = dataforBaqDT["baq"];

      return dataforBaqDT;
    }
  }

  Future showBAQData() async {
    var response = await http.get("${url}api/mbaq?baq=$dropDownValue",
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        });

    if (response.statusCode == 200) {
      var showdataforBaqDT = jsonDecode(response.body);

      // for (var item in respKey1) {
      //   baqDataType.add(item["DataType"]);
      // }

      setState(() {
        respKey1 = showdataforBaqDT['key1'];
        allBaqs = showdataforBaqDT['allbaqs'];
        // allBaqsName = allBaqs[0]['name'];
        baqName = showdataforBaqDT["baq"];
        postData = postBAQData();
      });

      return showdataforBaqDT;
    }
  }

  Future postBAQData() async {
    try {
      var response = await http.post('${url}api/mbaq/ajax',
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json"
          },
          body: jsonEncode(<String, dynamic>{
            "headertypes": "${baqDataType.join(",")}",
            "baq": "$baqName",
            "customsearch": customSearch,
            "params": params,
            "key": dataKeys
          }));

      if (response.statusCode == 200) {
        print("HERE INSIDE");
        var postwwData = jsonDecode(response.body);
        return postwwData;
      }
    } catch (e) {
      print(e);
    }
  }

  Future addtoFavBAQData() async {
    var response = await http.post('${url}api/mbaq/addfavbaq',
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{"baq": "$dropDownValue"}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var postfavbaqData = jsonDecode(response.body);
      baqData = getBAQData();
      baqData.then((value) {
        postData = postBAQData();
      });
      setState(() {});
      return postfavbaqData;
    }
  }

  Future deleteFavBAQData() async {
    var response = await http.post('${url}api/mbaq/delete',
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{"id": "$favbaqsdropDownValue"}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      favbaqsdropdownitems.clear();
      favbaqsdropdownitemsadd.clear();
      var deletefavbaqData = jsonDecode(response.body);
      baqData = getBAQData();
      print("HERE 1");

      baqData.then((valueg) {
        postData = postBAQData();
        postData.then((value) {
          print("HERE 2");
          print(valueg["allbaqs"][0]["url"]);
          dropDownValue = valueg["allbaqs"][0]["url"];
          setState(() {});
        });
      });

      return deletefavbaqData;
    }
  }

  @override
  void initState() {
    super.initState();
    baqData = getBAQData();
    baqData.then((value) {
      postData = postBAQData();
      dropDownValue = value["allbaqs"][0]["url"];
      // favbaqsdropDownValue = value["favbaq"]
      // favbaqsdropdownitemsadd = favbaqsdropdownitemsadd[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BAQ"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isVisibleSearch = !isVisibleSearch;
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        child: buildColumn(context),
      ),
    );
  }

  Widget buildColumn(context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return portraitScreen();
    } else {
      return landScapeScreen();
    }
  }

  Widget portraitScreen() {
    return Column(
      children: [
        FutureBuilder(
          future: baqData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    backgroundColor: Colors.green,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("Error Occured, Please Try Again");
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var data = snapshot.data;

                var dropdownitems =
                    data["allbaqs"].map<DropdownMenuItem<String>>((value) {
                  return new DropdownMenuItem<String>(
                    value: value["url"],
                    child: new Text(value["name"]),
                  );
                }).toList();

                // favbaqsdropdownitems.clear();
                favbaqsdropdownitemsadd = favbaqsdropdownitems
                    .map<DropdownMenuItem<String>>((favbaqvalue) {
                  print(favbaqvalue);
                  var a = favbaqvalue["_id"];
                  return new DropdownMenuItem<String>(
                    value: a,
                    child: new Text(favbaqvalue["baq"]),
                  );
                }).toList();
                return Column(
                  children: [
                    Visibility(
                      visible: isVisibleSearch,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            onChanged: (text) {
                              if (text.isEmpty) {
                                setState(() {
                                  customSearch = "";
                                });
                              } else {
                                setState(() {
                                  customSearch = text;
                                });
                              }
                            },
                            decoration: new InputDecoration(
                                labelText: "Search",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                prefixIcon: Icon(Icons.search)
                                //fillColor: Colors.green
                                ),
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(4.0),
                          child: FlatButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 1.0),
                              child: Text("Select BAQ",
                                  style: TextStyle(color: Color(0xff8950fc))),
                            ),
                            onPressed: () {
                              setState(() {
                                isVisibleBAQ = !isVisibleBAQ;
                              });
                            },
                            color: Color(0xffeee5ff),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(4.0),
                          child: FlatButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 1.0),
                              child: Text("Show Fav BAQ",
                                  style: TextStyle(color: Color(0xffffa800))),
                            ),
                            onPressed: () {
                              setState(() {
                                isVisibleFavBAQ = !isVisibleFavBAQ;
                              });
                            },
                            color: Color(0xfffff4de),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isVisibleBAQ,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 6.0),
                                child: Text("BAQ:"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                          color: Colors.grey[400], width: 1.0)),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: DropdownButtonHideUnderline(
                                      child: Text(''),
                                    ),
                                    items: dropdownitems,
                                    value: dropDownValue,
                                    onChanged: (value) {
                                      setState(() {
                                        dropDownValue = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: FlatButton(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 1.0),
                                    child: Text("Show BAQ's",
                                        style: TextStyle(
                                            color: Color(0xff8950FC))),
                                  ),
                                  onPressed: () {
                                    showButton = showBAQData();
                                  },
                                  color: Color(0xffEEE5FF),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: FlatButton(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 1.0),
                                    child: Text("Add to Fav's",
                                        style: TextStyle(
                                            color: Color(0xfff64e60))),
                                  ),
                                  onPressed: () {
                                    addtofavButton = addtoFavBAQData();
                                    setState(() {});
                                  },
                                  color: Color(0xffffe2e5),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isVisibleFavBAQ,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 1),
                                child: Text("Favbaq's:"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                          color: Colors.grey[400], width: 1.0)),
                                  child: DropdownButton<String>(
                                    key: UniqueKey(),
                                    isExpanded: true,
                                    underline: DropdownButtonHideUnderline(
                                      child: Text(''),
                                    ),
                                    items: favbaqsdropdownitemsadd,
                                    value: favbaqsdropDownValue,
                                    onChanged: (value) {
                                      setState(() {
                                        favbaqsdropDownValue = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: FlatButton(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 1.0),
                                    child: Text("Show",
                                        style: TextStyle(
                                            color: Color(0xff8950FC))),
                                  ),
                                  onPressed: () {
                                    showButton = showBAQData();
                                  },
                                  color: Color(0xffEEE5FF),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: FlatButton(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 1.0),
                                    child: Text("Delete",
                                        style: TextStyle(
                                            color: Color(0xfff64e60))),
                                  ),
                                  onPressed: () {
                                    deleteFavBAQ = deleteFavBAQData();

                                    setState(() {});
                                  },
                                  color: Color(0xffffe2e5),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey[100],
                            padding: const EdgeInsets.only(bottom: 16, top: 16),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    '${respKey1[0]["FieldLabel"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${respKey1[1]["FieldLabel"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${respKey1[2]["FieldLabel"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return Card(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Column(
                                      children: snapshot.data.map<Widget>(
                                        (e) {
                                          return BAQDT(
                                            baqdata: e,
                                            keys: data["key"],
                                            values: data["data"],
                                            respKey1: respKey1,
                                          );
                                        },
                                      ).toList(),
                                      // children: [Text(data.toString())],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                        return CircularProgressIndicator();
                      },
                      future: postData,
                    )
                  ],
                );
              }
            }
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: Text("Processing"),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget landScapeScreen() {
    return Column(
      children: [
        FutureBuilder(
          future: baqData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    backgroundColor: Colors.green,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("Error Occured, Please Try Again");
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var data = snapshot.data;

                var dropdownitems =
                    data["allbaqs"].map<DropdownMenuItem<String>>((value) {
                  return new DropdownMenuItem<String>(
                    value: value["url"],
                    child: new Text(value["name"]),
                  );
                }).toList();
                dropdownitems.insert(
                    0,
                    DropdownMenuItem<String>(
                      value: "Select",
                      child: new Text("SELECT"),
                    ));
                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("BAQ:"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    color: Colors.grey[400], width: 1.0)),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: DropdownButtonHideUnderline(
                                child: Text(''),
                              ),
                              items: dropdownitems,
                              value: dropDownValue,
                              onChanged: (value) {
                                setState(() {
                                  dropDownValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                        FlatButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text("Show",
                                style: TextStyle(color: Color(0xff8950FC))),
                          ),
                          onPressed: () {
                            showButton = showBAQData();
                          },
                          color: Color(0xffEEE5FF),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey[100],
                            padding: const EdgeInsets.only(bottom: 16, top: 16),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    '${respKey1[0]["FieldLabel"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${respKey1[1]["FieldLabel"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${respKey1[2]["FieldLabel"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${respKey1[3]["FieldLabel"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${respKey1[4]["FieldLabel"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${respKey1[5]["FieldLabel"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return Card(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Column(
                                      children: snapshot.data.map<Widget>(
                                        (e) {
                                          return BAQDT(
                                            baqdata: e,
                                            keys: data["key"],
                                            values: data["data"],
                                            respKey1: data["key1"],
                                          );
                                        },
                                      ).toList(),
                                      // children: [Text(data.toString())],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                        return CircularProgressIndicator();
                      },
                      future: postData,
                    )
                  ],
                );
              }
            }
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: Text("Processing"),
              ),
            );
          },
        ),
      ],
    );
  }
}

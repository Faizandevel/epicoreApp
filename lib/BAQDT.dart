import 'package:flutter/material.dart';

class BAQDT extends StatefulWidget {
  // final dynamic snapshot;
  final baqdata;
  final keys;
  final values;
  final respKey1;

  // final Function setterFunction;

  const BAQDT({Key key, this.baqdata, this.keys, this.values, this.respKey1})
      : super(key: key);
  @override
  _BAQDTState createState() => _BAQDTState();
}

class _BAQDTState extends State<BAQDT> with TickerProviderStateMixin {
  int i = 0;
  AnimationController _controller;
  Animation<double> _animation;
  var expansionIcon = Icons.expand_more;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRowList = [];
    int index = 0;
    int objIteration = 0;
    int portraitDisp = 2;
    int landscapeDisp = 6;
    int displayHeadings = portraitDisp;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      displayHeadings = landscapeDisp;
    }
    widget.baqdata.forEach((k, v) {
      if (objIteration > displayHeadings) {
        tableRowList.add(
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text(
                            '${widget.respKey1[index]["FieldLabel"]}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      // Divider(),
                    ],
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text(
                            '$v',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      // Divider(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
      if (objIteration < displayHeadings + 1) {
        objIteration++;
      }
      if (index < widget.respKey1.length - 1) {
        ++index;
      }
    });

    return buildColumn(context, tableRowList);
  }

  Widget buildColumn(context, tableRowList) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return portraitScreen(tableRowList);
    } else {
      return landScapeScreen(tableRowList);
    }
  }

  Widget portraitScreen(List<TableRow> tableRowList) {
    return GestureDetector(
      onLongPress: () {},
      child: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_controller.isCompleted) {
                              _controller.reverse();
                              setState(() {
                                expansionIcon = Icons.expand_more;
                              });
                            } else {
                              _controller.forward();
                              setState(() {
                                expansionIcon = Icons.expand_less;
                              });
                            }
                          },
                          child: Icon(
                            expansionIcon,
                            color: Colors.purple,
                            size: 26.0,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            widget.baqdata[widget.baqdata.keys.toList()[0]]
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.baqdata[widget.baqdata.keys.toList()[1]]
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.baqdata[widget.baqdata.keys.toList()[2]]
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 10, top: 8.0),
                    child: SizeTransition(
                      sizeFactor: _animation,
                      axis: Axis.vertical,
                      axisAlignment: -1,
                      child: Table(
                        columnWidths: {
                          1: FlexColumnWidth(
                            2.1,
                          ),
                        },
                        children: tableRowList,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget landScapeScreen(List<TableRow> tableRowList) {
    return GestureDetector(
      onLongPress: () {},
      child: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_controller.isCompleted) {
                              _controller.reverse();
                              setState(() {
                                expansionIcon = Icons.expand_more;
                              });
                            } else {
                              _controller.forward();
                              setState(() {
                                expansionIcon = Icons.expand_less;
                              });
                            }
                          },
                          child: Icon(
                            expansionIcon,
                            color: Colors.purple,
                            size: 26.0,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            widget.baqdata[widget.baqdata.keys.toList()[0]]
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.baqdata[widget.baqdata.keys.toList()[1]]
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.baqdata[widget.baqdata.keys.toList()[2]]
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.baqdata[widget.baqdata.keys.toList()[3]]
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.baqdata[widget.baqdata.keys.toList()[4]]
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.baqdata[widget.baqdata.keys.toList()[5]]
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 10, top: 8.0),
                    child: SizeTransition(
                      sizeFactor: _animation,
                      axis: Axis.vertical,
                      axisAlignment: -1,
                      child: Table(
                        columnWidths: {
                          1: FlexColumnWidth(
                            2.1,
                          ),
                        },
                        children: tableRowList,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test_fragment/Controller/SecondPage_Controller.dart';
import 'package:test_fragment/Screens/ViewText.dart';
import 'package:test_fragment/config/Const.dart';
import 'package:test_fragment/config/Mystrings.dart';
import 'package:test_fragment/config/Utils.dart';
import 'package:test_fragment/config/colors.dart';
import 'package:test_fragment/elements/ContentText.dart';
import 'package:test_fragment/elements/Drawer.dart';


class SecondScreen extends StatefulWidget {
  var values;
  var fragNav;

  var index;


  SecondScreen({this.fragNav, this.values, this.index});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> implements ActionInterface {
  SecondpageController scontroller = Get.put(SecondpageController());
  bool copypasteVisible = false;
  bool showSearchBar = false;
  var search_Map = {};
  Timer? _debounce;
  TextEditingController filterController = TextEditingController();

  var tmpentry;
  var tmpentry2;

  _onSearchChanged(String value) {

      if(value.isNotEmpty){
        if(value[0] == " "){
          filterController.clear();
        }
      }

    print("currentindex: ${currentIndex.value}");
    if (count.value == 1) {
      print( "1$temp_mainRoot");
      print( "2$temp_mainRoot_Map");
      print( "3$tmpentry");
      if(temp_mainRoot.length != 0) {
        temp_mainRoot.clear();
      }
      if(temp_mainRoot_Map.length != 0) {
        temp_mainRoot_Map.clear();
      }
      if(tmpentry != null) {
        tmpentry.clear();
      }

      if (widget.values.runtimeType == List) {
        for (int i = 0; i < widget.values.length; i++) {
          if (!temp_mainRoot.contains(widget.values[i])) {
            temp_mainRoot.add(widget.values[i]);
          }
        }
      } else {
        tmpentry = widget.values.entries.toList();
//print("mapcheck: ${tmpentry}");
        for (int j = 0; j < tmpentry.length; j++) {
          if (!temp_mainRoot_Map.containsKey(tmpentry[j].key)) {
            temp_mainRoot_Map.addEntries(tmpentry);
          }
          //   print("map entry of ${temp_mainRoot_Map}");
        }
      }
      // print("onceforList: $temp_mainRoot");
      //print("onceforMap: $temp_mainRoot_Map");
      setState(() {
        count.value --;
      });
    }

//    print("chech whole copy set: ${temp_mainRoot_Map}");

    if (value.isEmpty) {
      setState(() {
        count.value = 1;
        widget.values.clear();
        if (widget.values.runtimeType == List) {
          for (int i = 0; i < temp_mainRoot.length; i++) {
            widget.values.add(temp_mainRoot[i]);
          }
        } else {
          for (int j = 0; j < tmpentry.length; j++) {
            widget.values.addEntries(tmpentry);
          }
        }
        //    print("after close: ${widget.values}");
        //   print("empty: $count");
        // nv = temp_mainRoot;
      });
    }

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      // do something with query

      if (value.isNotEmpty && widget.values.runtimeType == List) {
        widget.values.clear();
        //   print("chechtemplist: ${temp_mainRoot}");
        for (int i = 0; i < temp_mainRoot.length; i++) {
          if (temp_mainRoot[i].toString().toLowerCase().contains(value.toLowerCase())) {
            if (!widget.values.contains(temp_mainRoot[i])) {
              widget.values.add(temp_mainRoot[i]);
            }
            //   print("for SEARCHlist: ${ widget.values}");
          }
          setState(() {});
        }
      } else if(value.isNotEmpty){
        widget.values.clear();
        for (int i = 0; i < tmpentry.length; i++) {
          if (tmpentry[i].toString().toLowerCase().contains(value.toLowerCase())) {
            widget.values[tmpentry[i].key.toString()] = tmpentry[i].value;
            //  print("for SEARCHmap: ${widget.values}");
          }
          setState(() {});
        }
        // var mapentry = temp_mainRoot.entries.toList();
        // var check = temp_mainRoot.entries.toList();
        // print(mapentry[1]);
        // check.clear();

        // int j;
        // for (j = 0; j < mapentry.length; j++) {
        //   if (mapentry[j].toString().toLowerCase().contains(value.toLowerCase())) {
        //     check.add(mapentry[j]);
        //     search_Map = Map.fromEntries(check);
        //   //  print("search_Map ${search_Map}");
        //   }
        //   setState(() {
        //
        //   });
        // }here

        //widget.values = Map.fromEntries(mapentry);
      }
      // widget.values = temp_mainRoot;
    });
  }

  @override
  void initState() {
    filterController.addListener(() {
      setState(() {});
    });
   showFab.value = true;
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  getAlldataAfterSearch() {
    setState(() {
      filterController.clear();
      print(showSearchBar);
      if (showSearchBar == true) {
        widget.values.clear();
        print("widget.values ${widget.values}");
        if (widget.values.runtimeType == List && temp_mainRoot.isNotEmpty) {
          for (int i = 0; i < temp_mainRoot.length; i++) {
            if (!widget.values.contains(temp_mainRoot[i])) {
              widget.values.add(temp_mainRoot[i]);
            }
          }
        } else if (tmpentry != null) {
          for (int j = 0; j < tmpentry.length; j++) {
            widget.values.addEntries(tmpentry);
          }
        }
        print("after close: ${widget.values}");
        showSearchBar = false;
      }

      print("www: ${widget.values.length}");
    });
  }

  void handleClick_forList({var index, var item, var value, var nextIndex, var previousIndex}) async {
    print("index ${index}");
    print("item ${item}");
    print("value ${value}");
    switch (item) {
      case 0:

        show_Dialog_forDelete(kname: index.toString(),
          ontap: (onvalue){
            Get.back();
            if(onvalue == true){
              print(value);
              if (value.runtimeType == List<dynamic>) {
                value.removeAt(index);


                setState(() {});
                // print("mainroot after removed: ${value}");
              } else {
                // print("its map Del");
                value.remove(index);
                setState(() {});
                // print("root ${value}");
              }
            }
          }
        );

        break;
      case 2:
        print("11 ${widget.values[index]}");
        print("12 ${widget.values[nextIndex]}");

        setState(() {
          if (widget.values.runtimeType == List) {
            widget.values.insert(index, widget.values.removeAt(nextIndex));
          } else {
            final index1 = widget.values.keys.toList().indexWhere((k) => k == index);
            final indexnxt = widget.values.keys.toList().indexWhere((k) => k == nextIndex);
            final mapentry = widget.values.entries.toList();
            mapentry.insert(index1, mapentry.removeAt(indexnxt));

            if(widget.values != null){
              widget.values.clear();
            }
            widget.values.addEntries(mapentry);

            // widget.values = Map.fromEntries(mapentry);
            // mainRoot = widget.values;
            setState(() {});
          }
        });

        break;
      case 3:
        print("widget.values[index]: ${widget.values[index]}");
        print("[index]: ${index}");
        var name = await getName_Dialog(context, "name", textvalue: index.toString());
        setState(() {
          if (name != null) {
            if (widget.values.containsKey(index.toString())) {
              final value = widget.values[index.toString()];
              final index1 = widget.values.keys.toList().indexWhere((k) => k == index);

              final mapEntriesList = widget.values.entries.toList();
              mapEntriesList.removeAt(index1);

              mapEntriesList.insert(index1, MapEntry(name, value));

              if(widget.values != null){
                widget.values.clear();
              }
              widget.values.addEntries(mapEntriesList);
              // widget.values = Map.fromEntries(mapEntriesList);
              // mainRoot = widget.values;

              setState(() {});

              print("updated map: ${widget.values}");
            }
          }
        });
        break;
      case 4:
        setState(() {
          if (widget.values.runtimeType == List) {
            widget.values.insert(index, widget.values.removeAt(previousIndex));
          } else {
            final index1 = widget.values.keys.toList().indexWhere((k) => k == index);
            final indexprvs = widget.values.keys.toList().indexWhere((k) => k == previousIndex);

            final mapentry = widget.values.entries.toList();
            mapentry.insert(index1, mapentry.removeAt(indexprvs));

            if(widget.values != null){
              widget.values.clear();
            }
            widget.values.addEntries(mapentry);

            // widget.values = Map.fromEntries(mapentry);
            // mainRoot = widget.values;
            setState(() {});
          }
        });
        break;
      case 5:
        setState(() {
          if (widget.values.runtimeType == List) {
            widget.values.insert(nextIndex, widget.values[index]);
          } else {
            print("P");
            final index1 = widget.values.keys.toList().indexWhere((k) => k == index);
            final indexnxt = widget.values.keys.toList().indexWhere((k) => k == nextIndex);

            final mapentry = widget.values.entries.toList();
            print("A ${mapentry[index1]}");
            print("B ${mapentry[indexnxt]}");
            mapentry.insert(indexnxt, mapentry[index1]);
            print(mapentry);

            setState(() {
              if(widget.values != null){
                widget.values.clear();
              }
              widget.values.addEntries(mapentry);
              // widget.values = Map.fromEntries(mapentry);
              // mainRoot = widget.values;
              print(mainRoot);
            });
          }
        });
        break;
      case 1:
        setState(() {
          copypasteVisible = true;
          FlutterClipboard.copy(json.encode(widget.values[index])).then((value) => showToastSnack(Mystrings.copied));
          //  FlutterClipboard.paste().then((value) => widget.values.insert(nextIndex,json.decode(value)));
        });
    }
  }

  getNumofJson(var index) {
    List numArray = [];
    List numObject = [];
    List numKeyVal = [];

    for (int i = 0; i < widget.values[index].values.toList().length; i++) {
      if (widget.values[index][widget.values[index].keys.toList()[i]].runtimeType == List<dynamic>) {
        numArray.add(widget.values[index][widget.values[index].keys.toList()[i]]);
      } else if (widget.values[index][widget.values[index].keys.toList()[i]].runtimeType.toString().toLowerCase().contains("map")) {
        numObject.add(widget.values[index][widget.values[index].keys.toList()[i]]);
      } else if (widget.values[index][widget.values[index].keys.toList()[i]].runtimeType == String ||
          widget.values[index][widget.values[index].keys.toList()[i]].runtimeType == int ||
          widget.values[index][widget.values[index].keys.toList()[i]].runtimeType == double) {
        if (widget.values[index][widget.values[index].keys.toList()[i]].runtimeType == double) {}
        numKeyVal.add(widget.values[index][widget.values[index].keys.toList()[i]]);
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          (widget.values[index].runtimeType != List<dynamic>)
              ? ContentText(
                  text: widget.values[index] == null
                      ? ""
                      : numKeyVal.length == 0
                          ? "0 Properties"
                          : "${numKeyVal.length} Properties",
                  color: Appcolor().colorBlack,
                  textSize: 1.6.h,
                )
              : Container(),
          SizedBox(
            width: 3.w,
          ),
          (widget.values[index].runtimeType != List<dynamic>)
              ? ContentText(
                  text: widget.values[index] == null
                      ? ""
                      : numArray.length == 0
                          ? ""
                          : "${numArray.length} array",
                  color: Appcolor().colorBlack,
                  textSize: 1.6.h,
                )
              : Container(),
          SizedBox(
            width: 3.w,
          ),
          (widget.values[index].runtimeType != List<dynamic>)
              ? ContentText(
                  text: widget.values[index] == null
                      ? ""
                      : numObject.length == 0
                          ? ""
                          : "${numObject.length} objects",
                  color: Appcolor().colorBlack,
                  textSize: 1.6.h,
                )
              : Container(),
        ],
      ),
    );
  }

  getvalueofArray(var index) {
    List allvalues = [];

    for (int i = 0; i < widget.values[index].length; i++) {
      if (widget.values[index][i].runtimeType == String || widget.values[index][i].runtimeType == int) {
        allvalues.add(widget.values[index][i]);
      }
    }

    return Text(allvalues.length == 0 ? "" : "${allvalues.toString().replaceAll("[", "").replaceAll("]", "")}");
  }

  swap(var list1, var list2) {
    RangeError.checkValidIndex(list1, 'index1');
    RangeError.checkValidIndex(list2, 'index2');
    var tmp = list1;
    list1 = list2;
    list2 = tmp;
  }

  getKeysAndValuesUsingForEach(Map map) {
    List tmp2 = [1, 2, 3];
    Map allkeyval = {};
    List<InlineSpan> tmp = [];

    map.forEach((key, value) {
      // print('Key = $key : Value = $value');
      if (value.runtimeType == String || value.runtimeType == int) {
        allkeyval["$key"] = " ${value}" + ",";
        tmp.add(TextSpan(
          text: " ${key}",
          style: TextStyle(decoration: TextDecoration.underline, fontSize: 1.5.h, color: Appcolor().colorGrey400),
        ));
        tmp.add(TextSpan(text: ": ${value},", style: TextStyle(fontSize: 1.5.h, color: Appcolor().colorGrey400)));
      }
    });

    return Text.rich(
      TextSpan(
        children: tmp,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        Get.to(() => ViewText());
        break;
      case 1:
        showDialog_for_Share(scontroller);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);

    return Scaffold(
        drawer: ShowDrawer(widget.fragNav),
        appBar: isFirstPage.value == false
            ? AppBar(
                titleSpacing: 0,
                backgroundColor: Appcolor().maincolor,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    showSearchBar == true
                        ? Container(
                            width: 50.w,
                            child: TextField(
                              style: TextStyle(
                                color: Appcolor().colorWhite
                              ),
                              autofocus: true,
                              onChanged: _onSearchChanged,
                              cursorColor: Appcolor().colorWhite,
                              controller: filterController,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: Mystrings.filter,
                                hintStyle: TextStyle(color: Appcolor().colorGrey400, fontSize: 2.2.h),
                                border: InputBorder.none,
                              ),
                            ))
                        : Text(Mystrings.json_reader),
                    InkWell(
                        onTap: () {
                          setState(() {
                            showSearchBar = !showSearchBar;
                            filterController.clear();
                            if (showSearchBar == false ) {

                              if (widget.values.runtimeType == List && temp_mainRoot.isNotEmpty) {
                                widget.values.clear();
                                for (int i = 0; i < temp_mainRoot.length; i++) {
                                  if (!widget.values.contains(temp_mainRoot[i])) {
                                    widget.values.add(temp_mainRoot[i]);
                                  }
                                }
                              } else if (tmpentry != null) {
                                widget.values.clear();
                                for (int j = 0; j < tmpentry.length; j++) {
                                  widget.values.addEntries(tmpentry);
                                }
                              }
                              print("after close: ${widget.values}");
                            }

                            print("www: ${widget.values.length}");
                          });

                          print("screenindex ${currentIndex.value}");
                          print("Stroedindex ${storedIndex.value}");
                        },
                        child: showSearchBar == true ? Icon(Icons.cancel_outlined) : Icon(Icons.search)),
                    InkWell(
                        onTap: () async {
                          showDialog_for_save(scontroller);
                        },
                        child: Icon(Icons.save)),
                  ],
                ),
                actions: <Widget>[
                  PopupMenuButton<int>(
                    onSelected: (item) => handleClick(item),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(value: 0, child: Text(Mystrings.viewtext)),
                      PopupMenuItem<int>(value: 1, child: Text(Mystrings.share)),
                    ],
                  ),
                ],
              )
            : null,
        body: Column(
          children: [
            Container(
                color: Appcolor().maincolor,
                height: 9.h,
                width: double.infinity,
                child: Stack(children: [
                  Visibility(
                    visible: copypasteVisible,
                    child: Positioned(
                      right: 0.w,
                      top: 5.9.w,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () async {
                                print("paste");

                                FlutterClipboard.paste().then((value) async {
                                  print("1: ${value}");
                                  try {
                                    setState(() {
                                      widget.values.add(json.decode(value));
                                    });
                                  } catch (e) {
                                    print(e.toString());
                                    showToastSnack(Mystrings.invalid_json);
                                  }
                                });
                              },
                              child: Icon(
                                Icons.paste,
                                color: Appcolor().colorWhite,
                                size: 3.5.h,
                              )),
                          IconButton(
                            icon: Icon(Icons.cancel_presentation, color: Appcolor().colorWhite, size: 3.5.h),
                            onPressed: () {
                              print("press");
                              setState(() {
                                copypasteVisible = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(

                    child: Row(
                      children: [
                        // InkWell(
                        //   onTap: () async {
                        //     print("press");
                        //     onBack();
                        //    },
                        //     child: Container(alignment: Alignment.centerLeft,child: Icon(Icons.arrow_back_ios_rounded,color: Appcolor().colorGrey400,))),
                        SizedBox(
                          width: 2.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 90.w,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ContentText(
                                    text: queue.isEmpty ? "Root" : "#${queue.last}",
                                    color: Appcolor().maincolor_light,
                                    textSize: 2.3.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: ContentText(
                                      text: "${currentIndex.value == 1 ? "" : widget.values.runtimeType == List ? "Array" : "Object"}",
                                      color: Appcolor().maincolor_light,
                                      textSize: 2.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 80.w,
                              child: Text.rich(
                               TextSpan( text: "Root > #${queue.toString().replaceAll(",", " >").replaceAll("{", "").replaceAll("}", "")}"),
                                style: TextStyle(
                                  color: Appcolor().maincolor_light,
                                  fontSize: 1.5.h,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,

                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ])),
            Expanded(
              child: widget.values.length == 0
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ContentText(textSize: 2.1.h, color: Appcolor().colorGrey400, text: Mystrings.emptyjson),
                    ))
                  : NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        final ScrollDirection direction = notification.direction;
                        setState(() {
                          if (direction == ScrollDirection.reverse && isHideFab.value == true) {
                            showFab.value = false;
                          } else if (direction == ScrollDirection.forward && isHideFab.value == true) {
                            showFab.value = true;
                          }
                        });
                        return true;
                      },
                      child:
                          // temp_mainRoot.length != 0
                          //     ? ListView.builder(
                          //         itemCount: temp_mainRoot.length,
                          //         itemBuilder: (context, index) {
                          //           return ListTile(
                          //             title: Text("${index + 1}"),
                          //             subtitle: Text(temp_mainRoot[index].toString()),
                          //           );
                          //         },
                          //       ):

                          ListView.builder(
                              itemCount: (widget.values.runtimeType != List<dynamic>) ? widget.values.length : widget.values.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  visualDensity: VisualDensity(horizontal: -4, vertical: 1),
                                  trailing: PopupMenuButton(
                                      padding: EdgeInsets.only(left: 4.w, bottom: 7.w),
                                      itemBuilder: (context) => [
                                            if (widget.values.runtimeType == List) PopupMenuItem<int>(value: 5, child: Text(Mystrings.clone)),
                                            PopupMenuItem<int>(value: 0, child: Text(Mystrings.delete)),
                                            PopupMenuItem<int>(value: 1, child: Text(Mystrings.copy)),
                                            if ((widget.values.runtimeType == List ? widget.values.length != 1 : widget.values.keys.toList().length != 1))
                                              PopupMenuItem<int>(value: 2, child: Text(Mystrings.movedown)),
                                            if (widget.values.runtimeType.toString().toLowerCase().contains("map"))
                                              PopupMenuItem<int>(value: 3, child: Text(Mystrings.changename)),
                                            if (widget.values.runtimeType == List ? widget.values.length != 1 : widget.values.keys.toList().length != 1)
                                              PopupMenuItem<int>(value: 4, child: Text(Mystrings.moveup)),
                                          ],
                                      onSelected: (item) => handleClick_forList(
                                          index: (widget.values.runtimeType == List<dynamic>) ? index : widget.values.keys.toList()[index],
                                          nextIndex: (widget.values.runtimeType == List<dynamic>)
                                              ? index == widget.values.indexOf(widget.values.last)
                                                  ? 0
                                                  : index + 1
                                              : widget.values.keys.toList().length == 1
                                                  ? widget.values.keys.toList()[index]
                                                  : widget.values.keys.toList()[index] != widget.values.keys.toList().last
                                                      ? widget.values.keys.toList()[(index + 1)]
                                                      : widget.values.keys.toList().first,
                                          previousIndex: (widget.values.runtimeType == List<dynamic>)
                                              ? index == 0
                                                  ? widget.values.indexOf(widget.values.last)
                                                  : index - 1
                                              : index == 0
                                                  ? widget.values.keys.toList().last
                                                  : widget.values.keys.toList()[index - 1],
                                          item: item,
                                          value: (widget.values.runtimeType == List<dynamic>) ? widget.values : widget.values)),
                                  title: widget.values.runtimeType != List
                                      ? (widget.values[widget.values.keys.toList()[index]].runtimeType == String)
                                          ? Padding(
                                              padding: const EdgeInsets.only(),
                                              child: Text("${widget.values.keys.toList()[index]}"),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(),
                                              child: Text("${widget.values.keys.toList()[index]}"),
                                            )
                                      : widget.values[index].runtimeType == String
                                          ? Text("${widget.values[index]}")
                                          : Text("#${index + 1}"),
                                  subtitle: widget.values.runtimeType == List
                                      ? widget.values[index].runtimeType == String || widget.values[index].runtimeType == int
                                          ? Container()
                                          : widget.values[index].runtimeType.toString().toLowerCase().contains("map")
                                              ? Container(
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [getNumofJson(index), getKeysAndValuesUsingForEach(widget.values[index])]))
                                              : getvalueofArray(index)
                                      : Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              widget.values[index].runtimeType.toString().toLowerCase().contains("map")
                                                  ? getNumofJson(index)
                                                  : widget.values.runtimeType != List
                                                      ? widget.values[widget.values.keys.toList()[index]].runtimeType
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains("map")
                                                          ? getNumofJson(widget.values.keys.toList()[index])
                                                          : widget.values[widget.values.keys.toList()[index]].runtimeType == int ||
                                                                  widget.values[widget.values.keys.toList()[index]].runtimeType == bool
                                                              ? Text(widget.values[widget.values.keys.toList()[index]].toString())
                                                              : Container()
                                                      : Container(),
                                              SizedBox(
                                                height: 0.2.h,
                                              ),
                                              widget.values.runtimeType != List
                                                  ? (widget.values[widget.values.keys.toList()[index]].runtimeType == String)
                                                      ? ContentText(
                                                          textSize: 1.5.h, color: Appcolor().colorGrey400, text: "${widget.values.values.toList()[index]}")
                                                      : widget.values[widget.values.keys.toList()[index]].runtimeType
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains("map")
                                                          ? getKeysAndValuesUsingForEach(widget.values[widget.values.keys.toList()[index]])
                                                          : Container()
                                                  : widget.values[index].runtimeType.toString().toLowerCase().contains("map")
                                                      ? getKeysAndValuesUsingForEach(widget.values[index])
                                                      : Container(),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                  onTap: () async {
                                    setState(() {
                                      showFab.value = true;
                                    });
                                    var tmpKey;
                                    var indexOf_tmpKey;

                                    if(showSearchBar == true){
                                     filterController.clear();
                                     setState(() {

                                         if (widget.values.runtimeType == List && temp_mainRoot.isNotEmpty) {
                                           print("index@: ${index}");
                                           tmpKey = widget.values[index];
                                           print("tmpvalue of list77: ${tmpKey}");
                                           widget.values.clear();
                                           for (int i = 0; i < temp_mainRoot.length; i++) {
                                             if (!widget.values.contains(temp_mainRoot[i])) {
                                               widget.values.add(temp_mainRoot[i]);
                                             }
                                           }


                                           indexOf_tmpKey = widget.values.indexWhere((k) => k == tmpKey);
                                           print("indexOf_tmpKey for List: ${indexOf_tmpKey}");
                                         } else if (tmpentry != null) {


                                           tmpKey = widget.values.keys.toList()[index];
                                           widget.values.clear();
                                           for (int j = 0; j < tmpentry.length; j++) {
                                             widget.values.addEntries(tmpentry);
                                           }
                                           indexOf_tmpKey = widget.values.keys.toList().indexWhere((k) => k == tmpKey);
                                           print("indexOf_tmpKey for Map: ${indexOf_tmpKey}");

                                           print("index@: ${widget.values.keys.toList()[index]}");
                                         }
                                         print("after close: ${widget.values}");
                                         showSearchBar = false;

                                       print("www: ${widget.values.length}");


                                         print("indexOf_tmpKey: ${indexOf_tmpKey}");
                                         print("index%%% $index");
                                        index = indexOf_tmpKey;

                                     });
                                    }

                                  //  final index1 = widget.values.keys.toList().indexWhere((k) => k == widget.values.keys.toList()[index]);


                                    print("index%%% $index");

                                    //print("+_+_ ${ widget.values.values.toList()[index] == null}");
                                    // print("ontap ${widget.values[index].keys.toList()}");  //get all keys/values of selected index
                                    //  print("type ${widget.values[widget.values.values.toList()[index]]}");
                                    if (widget.values.runtimeType != List) {
                                      // print("check ${widget.values[widget.values.keys.toList()[index]]}"); // when runtimetype is not list
                                      print("index of map: ${widget.values.keys.toList()[index]}");
                                      // print("index of map: ${widget.values.values.toList()[index]}");

                                    }

                                    if (widget.values.runtimeType != List &&
                                        (widget.values[widget.values.keys.toList()[index]].runtimeType == String ||
                                            widget.values[widget.values.keys.toList()[index]].runtimeType == int ||
                                            widget.values[widget.values.keys.toList()[index]].runtimeType == bool ||
                                            widget.values.values.toList()[index] == null)) {
                                      var data;

                                      print("hello type ${widget.values.values.toList()[index].runtimeType}");

                                      data = await showMyDialog_for_Value(context,
                                          key: widget.values.keys.toList()[index].toString(),
                                          value: widget.values.values.toList()[index].toString(),
                                          isbool: widget.values.values.toList()[index].runtimeType == bool ||  widget.values.values.toList()[index].toString().toLowerCase().contains("true") || widget.values.values.toList()[index].toString().toLowerCase().contains("false") ? true : false);
                                      setState(() {
                                      if (data != null) {
                                        print("getdata: ${data[0]}");
                                        print("getdata: ${data[1]}");

                                        // widget.values.remove(widget.values.keys.toList()[index]);
                                        // widget.values.insert(widget.values.keys.toList()[index],MapEntry(data[0], data[1]));

                                            if (widget.values.containsKey(widget.values.keys.toList()[index])) {
                                              //   final value = bd['nm'];
                                               final index1 = widget.values.keys.toList().indexWhere((k) => k == widget.values.keys.toList()[index]);
                                            //  widget.values.remove(widget.values.keys.toList()[index]);


                                              final mapEntriesList = widget.values.entries.toList();
                                              mapEntriesList.removeAt(index1);
                                              print("++++:${MapEntry(data[0], data[1])}");
                                              print("+--+:${MapEntry(data[0], data[1]).runtimeType}");

                                              mapEntriesList.insert(index1, MapEntry(data[0] as String, data[1]));
                                              var check;
                                              setState(() {
                                               // widget.values[data[0]] = data[1];
                                                if(widget.values != null){
                                                  widget.values.clear();
                                                }
                                                widget.values.addEntries(mapEntriesList);
                                               // mainRoot = widget.values;
                                                // widget.values = check;
                                             //   mainRoot[widget.index] = widget.values;
                                              });
                                           //   print("updated map: $check}");
                                              print("updated map: ${widget.values}");
                                            }
                                        }
                                      });
                                    } else {
                                      if (widget.values[index].runtimeType == String &&
                                          (!widget.values[index].toString().toLowerCase().contains("true") &&
                                              !widget.values[index].toString().toLowerCase().contains("false"))) {

                                        print("widget.values[index]: ${widget.values[index]}");
                                        var name = await getName_Dialog(context, "name", textvalue: widget.values[index]);
                                        setState(() {
                                          if (name != null) {
                                            widget.values.removeAt(index);
                                            widget.values.insert(index, name);
                                            print("value after update: ${widget.values[index]}");
                                          }
                                        });
                                      }
                                      else if(widget.values[index].toString().toLowerCase() == "true" || widget.values[index].toString().toLowerCase() == "false"){
                                        var data =  await showMyDialog_for_Value_ForList(context,
                                            key: widget.values[index].toString(),
                                            value: widget.values[index].toString(),
                                            isbool: true);

                                         if (data != null) {
                                        print("data_forList ${data[0]}");
                                        setState(() {
                                          widget.values.removeAt(index);
                                          widget.values.insert(index,data[0]);
                                        });
                                         }
                                      }
                                      else {
                                        print("PPPP");
                                        widget.values.runtimeType != List
                                            ? (widget.values[widget.values.keys.toList()[index]].runtimeType == String)
                                                ? queue.add(widget.values.keys.toList()[index].toString())
                                                : queue.add(widget.values.keys.toList()[index].toString())
                                            : widget.values[index].runtimeType == String
                                                ? queue.add(widget.values[index].toString())
                                                : queue.add((index + 1).toString());
                                      //  path_forsave.value = "";
                                        widget.fragNav.screenList[pageKeys[currentIndex.value]] = Posit(
                                            key: pageKeys[currentIndex.value],
                                            title: "Properties ${currentIndex.value}",
                                            fragment: SecondScreen(
                                                fragNav: widget.fragNav,
                                                index: index,
                                                values: (widget.values.runtimeType == List<dynamic>)
                                                    ? widget.values[index]
                                                    : widget.values[widget.values.keys.toList()[index]]));
                                        widget.fragNav.putPosit(
                                          key: pageKeys[currentIndex.value],
                                        );
                                        count.value =1;
                                        showFab.value = true;

                                      }
                                    }
                                      }
                                    );
                              }),
                    ),
            ),
          ],
        ),
        floatingActionButton: AnimatedSlide(
          duration: duration,
          offset: showFab.value ? Offset.zero : Offset(0, 2),
          child: AnimatedOpacity(
            duration: duration,
            opacity: showFab.value ? 1 : 0,
            child: FloatingActionButton(
              backgroundColor: Appcolor().colorOrange,
              heroTag: "secondpage",
              onPressed: () {
                print("valueee ${widget.values}");

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: Container(
                          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                          decoration: BoxDecoration(border: Border.all(color: Appcolor().colorGrey)),
                          height: 18.h,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      width: 70.w,
                                      child: InkWell(
                                          onTap: () async {
                                            print("press Array");
                                            print("thirdpagecontroller.rootType ${widget.values.runtimeType}");

                                            if (widget.values.runtimeType == List) {
                                              setState(() {
                                                widget.values.add([]);
                                              });

                                              print("mainroot : ${mainRoot}");
                                            } else {
                                              Get.back();
                                              var name = await getName_Dialog(context, "name");
                                              if (name != null) {
                                                setState(() {
                                                  widget.values["${name}"] = [];
                                                });
                                              }

                                              print("mainroot : ${mainRoot}");
                                            }
                                            Get.back();

                                            // fragNav.screenList[pageKeys[currentIndex.value]] = Posit(
                                            //     key: pageKeys[currentIndex.value],
                                            //     title: "Properties ${currentIndex.value}",
                                            //     fragment: SecondScreen(fragNav: fragNav,values: mainRoot));
                                            // fragNav.putPosit(
                                            //   key: pageKeys[currentIndex.value],
                                            // );
                                            //  currentIndex.value++;
                                          },
                                          child: ContentText(
                                            color: Appcolor().maincolor,
                                            textSize: 2.2.h,
                                            text: 'Array',
                                          )))),
                              Divider(
                                color: Appcolor().colorGrey,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      width: 70.w,
                                      child: InkWell(
                                          onTap: () async {
                                            if (widget.values.runtimeType == List) {
                                              setState(() {
                                                widget.values.add({});
                                              });
                                              print("mainroot : ${mainRoot}");
                                            } else {
                                              Get.back();
                                              var name = await getName_Dialog(context, "Name");
                                              if (name != null) {
                                                setState(() {
                                                  widget.values["${name}"] = {};
                                                });
                                              }

                                              print("mainroot : ${mainRoot}");
                                            }
                                            Get.back();
                                            // fragNav.screenList[pageKeys[currentIndex.value]] = Posit(
                                            //     key: pageKeys[currentIndex.value],
                                            //     title: "Properties ${currentIndex.value}",
                                            //     fragment: SecondScreen(fragNav: fragNav,values: mainRoot));
                                            // fragNav.putPosit(
                                            //   key: pageKeys[currentIndex.value],
                                            // );
                                            // currentIndex.value++;
                                          },
                                          child: ContentText(
                                            color: Appcolor().maincolor,
                                            textSize: 2.2.h,
                                            text: 'Object',
                                          )))),
                              Divider(
                                color: Appcolor().colorGrey,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      width: 70.w,
                                      child: InkWell(
                                          onTap: () async {
                                            Get.back();
                                            TextEditingController valueTController = TextEditingController();
                                            TextEditingController nameTController = TextEditingController();

                                            All selectedVal = All.Text;
                                            TF selectedTF = TF.True;
                                            bool visibility_of_textF1 = true;
                                            bool visibility_of_textF2 = true;
                                            bool visibility_of_radioB = false;
                                            Get.back();
                                            if (widget.values.runtimeType == List) {
                                              visibility_of_textF2 = false;
                                            }

                                            return await Get.dialog(StatefulBuilder(
                                                builder: (context, state) => AlertDialog(
                                                      contentPadding: EdgeInsets.only(top: 0.5.w, left: 2.w, right: 2.w),
                                                      content: Container(

                                                        padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
                                                        height: (widget.values.runtimeType == List) ? 13.h : 21.h,
                                                        child: Column(children: [
                                                          Visibility(
                                                            visible: visibility_of_textF2,
                                                            child: TextField(
                                                              cursorColor: Appcolor().colorOrange,
                                                              controller: nameTController,
                                                              decoration: InputDecoration(
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(color: Appcolor().colorOrange),
                                                                  ),
                                                                hintText: "Name",
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 1.w,
                                                          ),
                                                          Row(

                                                            children: [
                                                              Radio(
                                                                  focusColor: Appcolor().colorOrange,
                                                                  activeColor: Appcolor().colorOrange,
                                                                  visualDensity: const VisualDensity(
                                                                      horizontal: -4, vertical: VisualDensity.minimumDensity),
                                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                  value: All.Text,
                                                                  groupValue: selectedVal,
                                                                  onChanged: (All? val) {
                                                                    FocusScope.of(context).requestFocus(FocusNode());
                                                                    setState(() {
                                                                      selectedVal = val!;
                                                                      visibility_of_radioB = false;
                                                                      visibility_of_textF1 = true;
                                                                    });
                                                                    state(() {
                                                                      selectedVal = val!;
                                                                      visibility_of_radioB = false;
                                                                      visibility_of_textF1 = true;
                                                                    });
                                                                  }),
                                                              SizedBox(width: 2.w,),
                                                              ContentText(
                                                                text: "Text",
                                                                textSize: 2.h,
                                                                color: Appcolor().colorBlack,
                                                              ),
                                                              SizedBox(width: 2.w,),
                                                              Radio(
                                                                focusColor: Appcolor().colorOrange,
                                                                  activeColor: Appcolor().colorOrange,
                                                                  visualDensity: const VisualDensity(
                                                                      horizontal: -4, vertical: VisualDensity.minimumDensity),
                                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                  value: All.Number,
                                                                  groupValue: selectedVal,
                                                                  onChanged: (All? val) {
                                                                    FocusScope.of(context).requestFocus(FocusNode());

                                                                    setState(() {

                                                                      selectedVal = val!;
                                                                      visibility_of_radioB = false;
                                                                      visibility_of_textF1 = true;
                                                                    });
                                                                    state(() {
                                                                      selectedVal = val!;
                                                                      visibility_of_radioB = false;
                                                                      visibility_of_textF1 = true;
                                                                    });
                                                                  }),
                                                              SizedBox(width: 2.w,),
                                                              ContentText(
                                                                text: "Number",
                                                                textSize: 2.h,
                                                                color: Appcolor().colorBlack,
                                                              ),
                                                              SizedBox(width: 2.w,),
                                                              Radio(
                                                                  focusColor: Appcolor().colorOrange,
                                                                  activeColor: Appcolor().colorOrange,
                                                                  visualDensity: const VisualDensity(
                                                                      horizontal: -4, vertical: VisualDensity.minimumDensity),
                                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                  value: All.Boolean,
                                                                  groupValue: selectedVal,

                                                                  onChanged: (All? val) {

                                                                    setState(() {
                                                                      selectedVal = val!;
                                                                      visibility_of_radioB = true;
                                                                      visibility_of_textF1 = false;
                                                                    });
                                                                    state(() {
                                                                      selectedVal = val!;
                                                                      visibility_of_radioB = true;
                                                                      visibility_of_textF1 = false;
                                                                    });
                                                                  }),
                                                              SizedBox(width: 2.w,),
                                                              ContentText(
                                                                text: "Boolean",
                                                                textSize: 2.h,
                                                                color: Appcolor().colorBlack,
                                                              ),
                                                            ],
                                                          ),
                                                          Visibility(
                                                            visible: visibility_of_textF1,
                                                            child: TextField(
                                                              cursorColor: Appcolor().colorOrange,
                                                              controller: valueTController,
                                                              keyboardType: selectedVal.toString().contains("Text")
                                                                  ? TextInputType.text
                                                                  : selectedVal.toString().contains("Number")
                                                                      ? TextInputType.number
                                                                      : null,
                                                              decoration: InputDecoration(
                                                                focusedBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: Appcolor().colorOrange),
                                                                ),
                                                                focusColor:Appcolor().colorOrange,
                                                                fillColor: Appcolor().colorOrange,
                                                                hintText: "${selectedVal.toString().split('.').last}",

                                                              ),
                                                            ),
                                                          ),
                                                          Visibility(
                                                            visible: visibility_of_radioB,
                                                            child: Container(
                                                              padding: EdgeInsets.only(top: 1.5.h),
                                                              child: Row(
                                                                children: [
                                                                  Radio(
                                                                      focusColor: Appcolor().colorOrange,
                                                                      activeColor: Appcolor().colorOrange,
                                                                      visualDensity: const VisualDensity(
                                                                          horizontal: VisualDensity.minimumDensity,
                                                                          vertical: VisualDensity.minimumDensity),
                                                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                      value: TF.True,
                                                                      groupValue: selectedTF,
                                                                      onChanged: (TF? val) {
                                                                        setState(() {
                                                                          selectedTF = val!;
                                                                        });
                                                                        state(() {
                                                                          selectedTF = val!;
                                                                        });
                                                                      }),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  ContentText(
                                                                    text: "True",
                                                                    textSize: 2.h,
                                                                    color: Appcolor().colorBlack,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8.w,
                                                                  ),
                                                                  Radio(
                                                                      focusColor: Appcolor().colorOrange,
                                                                      activeColor: Appcolor().colorOrange,
                                                                      visualDensity: const VisualDensity(
                                                                          horizontal: VisualDensity.minimumDensity,
                                                                          vertical: VisualDensity.minimumDensity),
                                                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                      value: TF.False,
                                                                      groupValue: selectedTF,
                                                                      onChanged: (TF? val) {
                                                                        setState(() {
                                                                          selectedTF = val!;
                                                                        });
                                                                        state(() {
                                                                          selectedTF = val!;
                                                                        });
                                                                      }),
                                                                  SizedBox(
                                                                    width: 3.w,
                                                                  ),
                                                                  ContentText(
                                                                    text: "False",
                                                                    textSize: 2.h,
                                                                    color: Appcolor().colorBlack,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                      ),
                                                      actions: [
                                                        MaterialButton(
                                                          child: ContentText(
                                                            text: "Cancel",
                                                            color: Appcolor().maincolor,
                                                            textSize: 2.h,
                                                          ),
                                                          color: Appcolor().colorWhite,
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                        ),
                                                        MaterialButton(
                                                          child: ContentText(
                                                            text: "Save",
                                                            color: Appcolor().maincolor,
                                                            textSize: 2.h,
                                                          ),
                                                          color: Appcolor().colorWhite,
                                                          onPressed: () {
                                                            if (widget.values.runtimeType == List<dynamic>) {
                                                              if (selectedVal == All.Boolean) {
                                                                print("bool is selected");
                                                                if (selectedTF == TF.True) {
                                                                  print("its true");
                                                                  widget.values.add("true");
                                                                } else {
                                                                  print("its false");
                                                                  widget.values.add("false");
                                                                }
                                                              } else {
                                                                if(valueTController.text.isNotEmpty){
                                                                  widget.values.add("${valueTController.text}");
                                                                }
                                                                print("mainRoot ${mainRoot}");
                                                              }
                                                            } else {
                                                              if (selectedVal == All.Boolean) {
                                                                if (selectedTF == TF.True) {
                                                                  widget.values["${nameTController.text}"] = "true";
                                                                } else {
                                                                  widget.values["${nameTController.text}"] = "false";
                                                                }
                                                              } else {
                                                                if(nameTController.text.isEmpty){
                                                                  showToastSnack(Mystrings.nameempty);
                                                                }
                                                                if(nameTController.text.isNotEmpty){
                                                                  widget.values["${nameTController.text}"] = "${valueTController.text}";
                                                                }
                                                              }
                                                            }
                                                            setState(() {});
                                                            state(() {});

                                                            Get.back();
                                                            Get.back();
                                                          },
                                                        ),

                                                      ],
                                                    )));
                                          },
                                          child: ContentText(
                                            color: Appcolor().maincolor,
                                            textSize: 2.2.h,
                                            text: 'Value',
                                          )))),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Icon(Icons.add, color: Appcolor().colorWhite),
            ),
          ),
        ));
  }

  @override
  void action(String tag, {dynamic params}) {
    print('called on secondScreen with tag: $tag');
  }

  @override
  Future<bool> onBack() async {
    print("++${currentIndex.value}");
    print("++${storedIndex.value}");

    if (currentIndex.value == storedIndex.value) {
      print("--${currentIndex.value}");
      //backPressed();

       await getPrefBool_forexit("isAskToExit").then((value) {
           print("checkval: $value");
           isshowExitBox.value = value;
        });

      print("isexit ${isshowExitBox.value}");
      if(isshowExitBox.value == true){
        await show_Dialog_forExit();
      } else {
        if (Platform.isAndroid)
          SystemNavigator.pop();
        else
          exit(0);
      }

      return false;
    } else {
      currentIndex.value--;
      queue.removeLast();
      return true;
    }
  }

  @override
  Future<bool> onPut() async {
    currentIndex.value++;
    return true;
  }
}

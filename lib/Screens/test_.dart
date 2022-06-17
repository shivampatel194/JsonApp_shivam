// import 'package:flutter/material.dart';
// import 'package:fragment_navigate/navigate-control.dart';
// import 'package:get/get.dart';
//
// import 'package:test_fragment/config/Const.dart';
// import 'package:test_fragment/config/colors.dart';
// import 'package:test_fragment/elements/ContentText.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Main(),
//     );
//   }
// }
// enum All { Text, Number, Boolean }
// enum TF { True, False }
// var mainJSon;
// List pageKeys = List.generate(1000, (index) => "Key${index}");
// ValueNotifier<int> currentIndex = ValueNotifier(1);
//
// class Main extends StatefulWidget {
//   @override
//   State<Main> createState() => _MainState();
// }
//
// class _MainState extends State<Main> {
//
//   late FragNavigate fragNav;
//
//   @override
//   void initState() {
//     fragNav = FragNavigate(firstKey: pageKeys.first, screens: <Posit>[
//       Posit(
//           key: pageKeys.first,
//           title: "joirf9ej",
//           fragment: Container(
//             color: Colors.amberAccent,
//           )),
//     ],);
//     mainJSon = [];
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     fragNav.setDrawerContext = context;
//
//     return StreamBuilder<FullPosit>(
//         stream: fragNav.outStreamFragment,
//         builder: (con, s) {
//           if (s.data != null)
//             return DefaultTabController(
//                 length: s.data!.bottom?.length ?? 1,
//                 child: Scaffold(
//                     key: fragNav.drawerKey,
//                     appBar: AppBar(
//                       title: Text(s.data!.title ?? 'NULL'),
//                       actions: s.data?.actions,
//                       bottom: s.data?.bottom?.child,
//                     ),
//                     floatingActionButton: ValueListenableBuilder(
//                       builder: (context, value, child) {
//                         return value == 1 ?
//                         FloatingActionButton(
//                           onPressed: () {
//                             showDialog(context: context, builder: (context){
//                               return AlertDialog(
//                                 contentPadding: EdgeInsets.zero,
//                                 content: Container(
//                                   padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
//                                   decoration: BoxDecoration(border: Border.all(color: Appcolor().colorGrey)),
//                                   height: 18.h,
//                                   child: Column(
//                                     children: [
//                                       Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                               width: 70.w,
//                                               child: InkWell(
//                                                   onTap: () async{
//                                                     print("press Array");
//                                                     print("thirdpagecontroller.rootType ${mainJSon.runtimeType}");
//
//                                                     if (mainJSon.runtimeType == List) {
//                                                       mainJSon.add([]);
//                                                       print("mainroot : ${mainJSon}");
//                                                     } else {
//                                                       var name = "Arpit";
//                                                       mainJSon["${name}"] = [];
//                                                       print("mainroot : ${mainJSon}");
//                                                     }
//                                                     Navigator.pop(context);
//                                                     fragNav.screenList[pageKeys[currentIndex.value]] = Posit(
//                                                         key: pageKeys[currentIndex.value],
//                                                         title: "Properties ${currentIndex.value}",
//                                                         fragment: SecondScreen(
//                                                             fragNav, mainJSon
//                                                         ));
//                                                     fragNav.putPosit(key: pageKeys[currentIndex.value],);
//                                                   },
//                                                   child: ContentText(
//                                                     color: Appcolor().colorBlack,
//                                                     textSize: 2.2.h,
//                                                     text: 'array',
//                                                   )))),
//                                       Divider(
//                                         color: Appcolor().colorGrey,
//                                       ),
//                                       Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                               width: 70.w,
//                                               child: InkWell(
//                                                   onTap: () async{
//                                                     if (mainJSon.runtimeType == List) {
//                                                       mainJSon.add({});
//                                                       print("mainroot : ${mainJSon}");
//                                                     } else {
//                                                       var name = "Arpit";
//                                                       mainJSon["${name}"] = {};
//                                                       print("mainroot : ${mainJSon}");
//                                                     }
//                                                     Navigator.pop(context);
//                                                     fragNav.screenList[pageKeys[currentIndex.value]] = Posit(
//                                                         key: pageKeys[currentIndex.value],
//                                                         title: "Properties ${currentIndex.value}",
//                                                         fragment: SecondScreen(
//                                                             fragNav, mainJSon
//                                                         ));
//                                                     fragNav.putPosit(key: pageKeys[currentIndex.value],);
//                                                   },
//                                                   child: ContentText(
//                                                     color: Appcolor().colorBlack,
//                                                     textSize: 2.2.h,
//                                                     text: 'object',
//                                                   )))),
//                                       Divider(
//                                         color: Appcolor().colorGrey,
//                                       ),
//                                       Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                               width: 70.w,
//                                               child: InkWell(
//                                                   onTap: () async {
//
//                                                     TextEditingController valueTController = TextEditingController();
//                                                     TextEditingController nameTController = TextEditingController();
//
//                                                     All selectedVal = All.Text;
//                                                     TF selectedTF = TF.True;
//                                                     bool visibility_of_textF1 = true;
//                                                     bool visibility_of_textF2 = true;
//                                                     bool visibility_of_radioB = false;
//
//                                                     if(mainJSon.runtimeType == List){
//                                                       visibility_of_textF2 = false;
//                                                     }
//
//                                                     return await Get.dialog( StatefulBuilder(
//                                                         builder: (context, setState) => AlertDialog(
//                                                           contentPadding: EdgeInsets.only(top: 0.5.w,left: 2.w,right: 2.w),
//                                                           content: Container(
//                                                             width: 72.w,
//                                                             padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
//                                                             height: (mainJSon.runtimeType == List) ? 13.h : 21.h,
//                                                             child: Column(children: [
//                                                               Visibility(
//                                                                 visible: visibility_of_textF2,
//                                                                 child: TextField(
//                                                                   controller: nameTController,
//                                                                   decoration: InputDecoration(
//                                                                     hintText: "Name",
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               SizedBox(height: 1.w,),
//                                                               Row(
//                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                 children: [
//                                                                   Radio(
//                                                                       visualDensity: const VisualDensity(
//                                                                           horizontal: VisualDensity.minimumDensity,
//                                                                           vertical: VisualDensity.minimumDensity),
//                                                                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                                       value: All.Text,
//                                                                       groupValue: selectedVal,
//                                                                       onChanged: (All? val) {
//                                                                         setState(() {
//                                                                           selectedVal = val!;
//                                                                           visibility_of_radioB = false;
//                                                                           visibility_of_textF1 = true;
//                                                                         });
//                                                                       }),
//                                                                   ContentText(
//                                                                     text: "Text",
//                                                                     textSize: 2.h ,
//                                                                     color: Appcolor().colorBlack,
//                                                                   ),
//                                                                   Radio(
//                                                                       visualDensity: const VisualDensity(
//                                                                           horizontal: VisualDensity.minimumDensity,
//                                                                           vertical: VisualDensity.minimumDensity),
//                                                                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                                       value: All.Number,
//                                                                       groupValue: selectedVal,
//                                                                       onChanged: (All? val) {
//                                                                         setState(() {
//                                                                           selectedVal = val!;
//                                                                           visibility_of_radioB = false;
//                                                                           visibility_of_textF1 = true;
//                                                                         });
//                                                                       }),
//                                                                   ContentText(
//                                                                     text: "Number",
//                                                                     textSize: 2.h ,
//                                                                     color: Appcolor().colorBlack,
//                                                                   ),
//                                                                   Radio(
//                                                                       visualDensity: const VisualDensity(
//                                                                           horizontal: VisualDensity.minimumDensity,
//                                                                           vertical: VisualDensity.minimumDensity),
//                                                                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                                       value: All.Boolean,
//                                                                       groupValue: selectedVal,
//                                                                       onChanged: (All? val) {
//                                                                         setState(() {
//                                                                           selectedVal = val!;
//                                                                           visibility_of_radioB = true;
//                                                                           visibility_of_textF1 = false;
//                                                                         });
//                                                                       }),
//                                                                   ContentText(
//                                                                     text: "Bool",
//                                                                     textSize: 2.h ,
//                                                                     color: Appcolor().colorBlack,
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               Visibility(
//                                                                 visible: visibility_of_textF1,
//                                                                 child: TextField(
//                                                                   controller: valueTController,
//                                                                   keyboardType: selectedVal.toString().contains("Text")
//                                                                       ? TextInputType.text
//                                                                       : selectedVal.toString().contains("Number")
//                                                                       ? TextInputType.number
//                                                                       : null,
//                                                                   decoration: InputDecoration(
//                                                                     hintText: "${selectedVal.toString().split('.').last}",
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Visibility(
//
//                                                                 visible: visibility_of_radioB,
//                                                                 child: Container(
//                                                                   padding: EdgeInsets.only(top: 1.5.h),
//                                                                   child: Row(
//                                                                     children: [
//                                                                       Radio(
//                                                                           visualDensity: const VisualDensity(
//                                                                               horizontal: VisualDensity.minimumDensity,
//                                                                               vertical: VisualDensity.minimumDensity),
//                                                                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                                           value: TF.True,
//                                                                           groupValue: selectedTF,
//                                                                           onChanged: (TF? val) {
//                                                                             setState(() {
//                                                                               selectedTF = val!;
//                                                                             });
//                                                                           }),
//                                                                       ContentText(
//                                                                         text: "True",
//                                                                         textSize: 2.h ,
//                                                                         color: Appcolor().colorBlack,
//                                                                       ),
//                                                                       SizedBox(
//                                                                         width: 8.w,
//                                                                       ),
//                                                                       Radio(
//                                                                           visualDensity: const VisualDensity(
//                                                                               horizontal: VisualDensity.minimumDensity,
//                                                                               vertical: VisualDensity.minimumDensity),
//                                                                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                                           value: TF.False,
//                                                                           groupValue: selectedTF,
//                                                                           onChanged: (TF? val) {
//                                                                             setState(() {
//                                                                               selectedTF = val!;
//                                                                             });
//                                                                           }),
//                                                                       ContentText(
//                                                                         text: "False",
//                                                                         textSize: 2.h ,
//                                                                         color: Appcolor().colorBlack,
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//
//                                                             ]),
//                                                           ),
//                                                           actions: [
//                                                             MaterialButton(
//                                                               child: ContentText(
//                                                                 text: "ok",
//                                                                 color: Appcolor().colorBlack,
//                                                                 textSize: 2.h,
//                                                               ),
//                                                               color: Appcolor().colorWhite,
//                                                               onPressed: () {
//                                                                 Get.back();
//                                                                 Get.back();
//                                                               },
//                                                             ),
//                                                             MaterialButton(
//                                                               child: ContentText(
//                                                                 text: "cancel",
//                                                                 color: Appcolor().colorBlack,
//                                                                 textSize: 2.h,
//                                                               ),
//                                                               color: Appcolor().colorWhite,
//                                                               onPressed: () {
//                                                                 Get.back();
//                                                               },
//                                                             ),
//                                                           ],
//                                                         )));
//                                                   } ,
//                                                   child: ContentText(
//                                                     color: Appcolor().colorBlack,
//                                                     textSize: 2.2.h,
//                                                     text: 'value',
//                                                   )))),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             });
//                           },
//                           child: Icon(Icons.add),
//                         ) : Container();
//                       },
//                       valueListenable: currentIndex,
//                     ),
//                     body: ScreenNavigate(
//                         child: s.data!.fragment, control: fragNav)));
//
//           return Container();
//         });
//   }
// }
//
// class SecondScreen extends StatelessWidget implements ActionInterface {
//   var values;
//   var fragNav;
//   SecondScreen(this.fragNav,this.values);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//           itemCount: values.length,
//           itemBuilder: (BuildContext context,int index){
//             return ListTile(
//               leading: Icon(Icons.list),
//               trailing: Text("GFG",
//                 style: TextStyle(
//                     color: Colors.green,fontSize: 15),),
//               title:Text("List item $index"),
//               onTap: (){
//                 showDialog(context: context, builder: (context){
//                   return AlertDialog(
//                     contentPadding: EdgeInsets.zero,
//                     content: Container(
//                       padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
//                       decoration: BoxDecoration(border: Border.all(color: Appcolor().colorGrey)),
//                       height: 18.h,
//                       child: Column(
//                         children: [
//                           Expanded(
//                               flex: 1,
//                               child: Container(
//                                   width: 70.w,
//                                   child: InkWell(
//                                       onTap: () async{
//                                         print("press Array");
//                                         print("thirdpagecontroller.rootType ${values.runtimeType}");
//
//                                         if (values[index].runtimeType == List) {
//                                           values[index].add([]);
//                                           print("values : ${values[index]}");
//                                         } else {
//                                           var name = "Arpit";
//                                           Iterable ljd = values.keys;
//                                           var ksjdfn = ljd.toList();
//                                           print("byugujihn ${ksjdfn}");
//                                           values[ksjdfn[index]] = [];
//                                           print("values : ${values[index]}");
//                                         }
//                                         Navigator.pop(context);
//                                         fragNav.screenList[pageKeys[currentIndex.value]] = Posit(
//                                             key: pageKeys[currentIndex.value],
//                                             title: "Properties ${currentIndex.value}",
//                                             fragment: SecondScreen(
//                                                 fragNav, values[index]
//                                             ));
//                                         fragNav.putPosit(key: pageKeys[currentIndex.value],);
//                                       },
//                                       child: ContentText(
//                                         color: Appcolor().colorBlack,
//                                         textSize: 2.2.h,
//                                         text: 'array',
//                                       )))),
//                           Divider(
//                             color: Appcolor().colorGrey,
//                           ),
//                           Expanded(
//                               flex: 1,
//                               child: Container(
//                                   width: 70.w,
//                                   child: InkWell(
//                                       onTap: () async{
//                                         if (values[index].runtimeType == List) {
//                                           values[index].add({});
//                                           print("values : ${values[index]}");
//                                         } else {
//                                           var name = "Arpit";
//                                           values[index]["${name}"] = {};
//                                           print("values : ${values[index]}");
//                                         }
//                                         Navigator.pop(context);
//                                         fragNav.screenList[pageKeys[currentIndex.value]] = Posit(
//                                             key: pageKeys[currentIndex.value],
//                                             title: "Properties ${currentIndex.value}",
//                                             fragment: SecondScreen(
//                                                 fragNav, values[index]
//                                             ));
//                                         fragNav.putPosit(key: pageKeys[currentIndex.value],);
//                                       },
//                                       child: ContentText(
//                                         color: Appcolor().colorBlack,
//                                         textSize: 2.2.h,
//                                         text: 'object',
//                                       )))),
//                           Divider(
//                             color: Appcolor().colorGrey,
//                           ),
//                           Expanded(
//                               flex: 1,
//                               child: Container(
//                                   width: 70.w,
//                                   child: InkWell(
//                                       onTap: () async {
//
//                                         TextEditingController valueTController = TextEditingController();
//                                         TextEditingController nameTController = TextEditingController();
//
//                                         All selectedVal = All.Text;
//                                         TF selectedTF = TF.True;
//                                         bool visibility_of_textF1 = true;
//                                         bool visibility_of_textF2 = true;
//                                         bool visibility_of_radioB = false;
//
//                                         if(mainJSon.runtimeType == List){
//                                           visibility_of_textF2 = false;
//                                         }
//
//                                         return await Get.dialog( StatefulBuilder(
//                                             builder: (context, setState) => AlertDialog(
//                                               contentPadding: EdgeInsets.only(top: 0.5.w,left: 2.w,right: 2.w),
//                                               content: Container(
//                                                 width: 72.w,
//                                                 padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
//                                                 height: (mainJSon.runtimeType == List) ? 13.h : 21.h,
//                                                 child: Column(children: [
//                                                   Visibility(
//                                                     visible: visibility_of_textF2,
//                                                     child: TextField(
//                                                       controller: nameTController,
//                                                       decoration: InputDecoration(
//                                                         hintText: "Name",
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 1.w,),
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       Radio(
//                                                           visualDensity: const VisualDensity(
//                                                               horizontal: VisualDensity.minimumDensity,
//                                                               vertical: VisualDensity.minimumDensity),
//                                                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                           value: All.Text,
//                                                           groupValue: selectedVal,
//                                                           onChanged: (All? val) {
//                                                             setState(() {
//                                                               selectedVal = val!;
//                                                               visibility_of_radioB = false;
//                                                               visibility_of_textF1 = true;
//                                                             });
//                                                           }),
//                                                       ContentText(
//                                                         text: "Text",
//                                                         textSize: 2.h ,
//                                                         color: Appcolor().colorBlack,
//                                                       ),
//                                                       Radio(
//                                                           visualDensity: const VisualDensity(
//                                                               horizontal: VisualDensity.minimumDensity,
//                                                               vertical: VisualDensity.minimumDensity),
//                                                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                           value: All.Number,
//                                                           groupValue: selectedVal,
//                                                           onChanged: (All? val) {
//                                                             setState(() {
//                                                               selectedVal = val!;
//                                                               visibility_of_radioB = false;
//                                                               visibility_of_textF1 = true;
//                                                             });
//                                                           }),
//                                                       ContentText(
//                                                         text: "Number",
//                                                         textSize: 2.h ,
//                                                         color: Appcolor().colorBlack,
//                                                       ),
//                                                       Radio(
//                                                           visualDensity: const VisualDensity(
//                                                               horizontal: VisualDensity.minimumDensity,
//                                                               vertical: VisualDensity.minimumDensity),
//                                                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                           value: All.Boolean,
//                                                           groupValue: selectedVal,
//                                                           onChanged: (All? val) {
//                                                             setState(() {
//                                                               selectedVal = val!;
//                                                               visibility_of_radioB = true;
//                                                               visibility_of_textF1 = false;
//                                                             });
//                                                           }),
//                                                       ContentText(
//                                                         text: "Bool",
//                                                         textSize: 2.h ,
//                                                         color: Appcolor().colorBlack,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Visibility(
//                                                     visible: visibility_of_textF1,
//                                                     child: TextField(
//                                                       controller: valueTController,
//                                                       keyboardType: selectedVal.toString().contains("Text")
//                                                           ? TextInputType.text
//                                                           : selectedVal.toString().contains("Number")
//                                                           ? TextInputType.number
//                                                           : null,
//                                                       decoration: InputDecoration(
//                                                         hintText: "${selectedVal.toString().split('.').last}",
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Visibility(
//
//                                                     visible: visibility_of_radioB,
//                                                     child: Container(
//                                                       padding: EdgeInsets.only(top: 1.5.h),
//                                                       child: Row(
//                                                         children: [
//                                                           Radio(
//                                                               visualDensity: const VisualDensity(
//                                                                   horizontal: VisualDensity.minimumDensity,
//                                                                   vertical: VisualDensity.minimumDensity),
//                                                               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                               value: TF.True,
//                                                               groupValue: selectedTF,
//                                                               onChanged: (TF? val) {
//                                                                 setState(() {
//                                                                   selectedTF = val!;
//                                                                 });
//                                                               }),
//                                                           ContentText(
//                                                             text: "True",
//                                                             textSize: 2.h ,
//                                                             color: Appcolor().colorBlack,
//                                                           ),
//                                                           SizedBox(
//                                                             width: 8.w,
//                                                           ),
//                                                           Radio(
//                                                               visualDensity: const VisualDensity(
//                                                                   horizontal: VisualDensity.minimumDensity,
//                                                                   vertical: VisualDensity.minimumDensity),
//                                                               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                               value: TF.False,
//                                                               groupValue: selectedTF,
//                                                               onChanged: (TF? val) {
//                                                                 setState(() {
//                                                                   selectedTF = val!;
//                                                                 });
//                                                               }),
//                                                           ContentText(
//                                                             text: "False",
//                                                             textSize: 2.h ,
//                                                             color: Appcolor().colorBlack,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//
//                                                 ]),
//                                               ),
//                                               actions: [
//                                                 MaterialButton(
//                                                   child: ContentText(
//                                                     text: "ok",
//                                                     color: Appcolor().colorBlack,
//                                                     textSize: 2.h,
//                                                   ),
//                                                   color: Appcolor().colorWhite,
//                                                   onPressed: () {
//                                                     Get.back();
//                                                     Get.back();
//                                                   },
//                                                 ),
//                                                 MaterialButton(
//                                                   child: ContentText(
//                                                     text: "cancel",
//                                                     color: Appcolor().colorBlack,
//                                                     textSize: 2.h,
//                                                   ),
//                                                   color: Appcolor().colorWhite,
//                                                   onPressed: () {
//                                                     Get.back();
//                                                   },
//                                                 ),
//                                               ],
//                                             )));
//                                       } ,
//                                       child: ContentText(
//                                         color: Appcolor().colorBlack,
//                                         textSize: 2.2.h,
//                                         text: 'value',
//                                       )))),
//                         ],
//                       ),
//                     ),
//                   );
//                 });
//               },
//             );
//           }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (values.runtimeType == List) {
//             values.add([]);
//             print("values : ${values}");
//           } else {
//             var name = "Arpit";
//             values["${name}"] = [];
//             print("values : ${values}");
//           }
//         },
//       ),
//     );
//   }
//
//   @override
//   void action(String tag, {dynamic params}) {
//     print('called on secondScreen with tag: $tag');
//   }
//
//   @override
//   Future<bool> onBack() async {
//     currentIndex.value--;
//     return true;
//   }
//
//   @override
//   Future<bool> onPut() async {
//     currentIndex.value++;
//     return true;
//   }
// }

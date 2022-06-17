// import 'dart:collection';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:test_fragment/Controller/SecondPage_Controller.dart';
// import 'package:test_fragment/config/Const.dart';
// import 'package:test_fragment/config/Mystrings.dart';
// import 'package:test_fragment/config/Utils.dart';
// import 'package:test_fragment/config/colors.dart';
// import 'package:test_fragment/elements/ContentText.dart';
//
// showFloatingButton_SecondPage(BuildContext context , SecondpageController secondpagecontroller){
//  return
//    FloatingActionButton(
//       backgroundColor: Appcolor().colorOrange,
//       onPressed: () async{
//
//               return await Get.dialog( AlertDialog(
//                 contentPadding: EdgeInsets.zero,
//                 content: Container(
//                   padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
//                   decoration: BoxDecoration(border: Border.all(color: Appcolor().colorGrey)),
//                   height: 18.h,
//                   child: Column(
//                     children: [
//                       Expanded(
//                           flex: 1,
//                           child: Container(
//                               width: 70.w,
//                               child: InkWell(
//                                   onTap: () async{
//                                     print("press Array");
//                                     print("thirdpagecontroller.rootType ${secondpagecontroller.mainRoot.runtimeType}");
//
//                                     if (secondpagecontroller.mainRoot.runtimeType == List<dynamic>) {
//                                       secondpagecontroller.mainRoot.add([]);
//                                       print("mainroot : ${secondpagecontroller.mainRoot}");
//                                     } else {
//                                       var name = await  getName_Dialog(context,Mystrings.name);
//                                       secondpagecontroller.mainRoot["${name}"] = [];
//                                       print("mainroot : ${secondpagecontroller.mainRoot}");
//                                     }
//                                     secondpagecontroller.update();
//                                     Get.back();
//                                   },
//                                   child: ContentText(
//                                     color: Appcolor().maincolor,
//                                     textSize: 2.2.h,
//                                     text: Mystrings.array,
//                                   )))),
//                       Divider(
//                         color: Appcolor().colorGrey,
//                       ),
//                       Expanded(
//                           flex: 1,
//                           child: Container(
//                               width: 70.w,
//                               child: InkWell(
//                                   onTap: () async{
//                                     if (secondpagecontroller.mainRoot.runtimeType == List<dynamic>) {
//                                       secondpagecontroller.mainRoot.add({});
//                                       print("mainroot : ${secondpagecontroller.mainRoot}");
//                                     } else {
//                                       var name = await  getName_Dialog(context,Mystrings.name);
//                                       secondpagecontroller.mainRoot["${name}"] = {};
//                                       print("mainroot : ${secondpagecontroller.mainRoot}");
//                                     }
//                                     secondpagecontroller.update();
//                                     Get.back();
//                                   },
//                                   child: ContentText(
//                                     color: Appcolor().maincolor,
//                                     textSize: 2.2.h,
//                                     text: Mystrings.object,
//                                   )))),
//                       Divider(
//                         color: Appcolor().colorGrey,
//                       ),
//                       Expanded(
//                           flex: 1,
//                           child: Container(
//                               width: 70.w,
//                               child: InkWell(
//                                   onTap: () async {
//
//                                     TextEditingController valueTController = TextEditingController();
//                                     TextEditingController nameTController = TextEditingController();
//
//                                     All selectedVal = All.Text;
//                                     TF selectedTF = TF.True;
//                                     bool visibility_of_textF1 = true;
//                                     bool visibility_of_textF2 = true;
//                                     bool visibility_of_radioB = false;
//
//                                        if(secondpagecontroller.mainRoot.runtimeType == List<dynamic>){
//                                           visibility_of_textF2 = false;
//                                        }
//
//                                         return await Get.dialog( StatefulBuilder(
//                                             builder: (context, setState) => AlertDialog(
//                                               contentPadding: EdgeInsets.only(top: 0.5.w,left: 2.w,right: 2.w),
//                                               content: Container(
//                                                 width: 72.w,
//                                                 padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
//                                                 height: (secondpagecontroller.mainRoot.runtimeType == List<dynamic>) ? 13.h : 21.h,
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
//                                                 ContentText(
//                                                   text: "True",
//                                                   textSize: 2.h ,
//                                                   color: Appcolor().colorBlack,
//                                                 ),
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
//                                                     text: Mystrings.ok,
//                                                     color: Appcolor().maincolor,
//                                                     textSize: 2.h,
//                                                   ),
//                                                   color: Appcolor().colorWhite,
//                                                   onPressed: () {
//                                                     if(secondpagecontroller.mainRoot.runtimeType == List<dynamic>){
//                                                       if(selectedVal == All.Boolean){
//                                                         print("bool is selected");
//                                                         if(selectedTF == TF.True){
//                                                           print("its true");
//                                                           secondpagecontroller.mainRoot.add("true");
//                                                         } else {
//                                                           print("its false");
//                                                           secondpagecontroller.mainRoot.add("false");
//                                                         }
//                                                       } else {
//                                                       secondpagecontroller.mainRoot.add("${valueTController.text}");
//                                                       print("mainRoot ${secondpagecontroller.mainRoot}");
//                                                       }
//                                                     } else {
//                                                       if(selectedVal == All.Boolean){
//                                                         if(selectedTF ==TF.True){
//                                                           secondpagecontroller.mainRoot["${nameTController.text}"] = "true";
//                                                         } else {
//                                                           secondpagecontroller.mainRoot["${nameTController.text}"] = "false";
//                                                         }
//                                                       } else {
//                                                         secondpagecontroller.mainRoot["${nameTController.text}"] = "${valueTController.text}";
//                                                       }
//                                                     }
//                                                     secondpagecontroller.update();
//                                                     Get.back();
//                                                     Get.back();
//                                                   },
//                                                 ),
//                                                 MaterialButton(
//                                                   child: ContentText(
//                                                     text: Mystrings.cancel,
//                                                     color: Appcolor().maincolor,
//                                                     textSize: 2.h,
//                                                   ),
//                                                   color: Appcolor().colorWhite,
//                                                   onPressed: () {
//                                                     secondpagecontroller.update();
//                                                     Get.back();
//                                                     Get.back();
//                                                   },
//                                                 ),
//                                               ],
//                                             )));
//                                        } ,
//                                   child: ContentText(
//                                     color: Appcolor().maincolor,
//                                     textSize: 2.2.h,
//                                     text: Mystrings.value,
//                                   )))),
//                     ],
//                   ),
//                 ),
//               ));
//
//       },
//       child: Icon(
//         Icons.add,
//         color: Appcolor().colorWhite,)
//
//   );
// }
//
// showFloatingButton_ontapPage(BuildContext context , SecondpageController secondpagecontroller, int index, List allkeys){
//  return
//    FloatingActionButton(
//    heroTag: "parentbuttom",
//       backgroundColor: Appcolor().colorOrange,
//       onPressed: () async{
//
//               return await Get.dialog( AlertDialog(
//                 contentPadding: EdgeInsets.zero,
//                 content: Container(
//                   padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
//                   decoration: BoxDecoration(border: Border.all(color: Appcolor().colorGrey)),
//                   height: 18.h,
//                   child: Column(
//                     children: [
//                       Expanded(
//                           flex: 1,
//                           child: Container(
//                               width: 70.w,
//                               child: InkWell(
//                                   onTap: () async{
//                                     print("press Array");
//                                   //  print("thirdpagecontroller.rootType ${secondpagecontroller.mainRoot[[index]].runtimeType}");
//                                    // print("thirdpagecontroller.rootType ${secondpagecontroller.mainRoot["${allkeys[index]}"].runtimeType}");
//                                     if (secondpagecontroller.mainRoot["${allkeys[index]}"].runtimeType == List<dynamic>) {
//                                       secondpagecontroller.mainRoot["${allkeys[index]}"].add([]);
//                                       print("mainroot : ${secondpagecontroller.mainRoot}");
//                                     } else {
//                                       var name = await  getName_Dialog(context,Mystrings.name);
//                                       secondpagecontroller.mainRoot["${allkeys[index]}"]["${name}"] = [];
//                                       print("mainroot : ${secondpagecontroller.mainRoot}");
//                                     }
//                                     secondpagecontroller.update();
//                                     Get.back();
//                                   },
//                                   child: ContentText(
//                                     color: Appcolor().maincolor,
//                                     textSize: 2.2.h,
//                                     text: Mystrings.array,
//                                   )))),
//                       Divider(
//                         color: Appcolor().colorGrey,
//                       ),
//                       Expanded(
//                           flex: 1,
//                           child: Container(
//                               width: 70.w,
//                               child: InkWell(
//                                   onTap: () async{
//                                     if (secondpagecontroller.mainRoot["${allkeys[index]}"].runtimeType == List<dynamic>) {
//                                       secondpagecontroller.mainRoot["${allkeys[index]}"].add({});
//                                       print("mainroot : ${secondpagecontroller.mainRoot}");
//                                     } else {
//                                       var name = await  getName_Dialog(context,Mystrings.name);
//                                       secondpagecontroller.mainRoot["${allkeys[index]}"]["${name}"] = {};
//                                       print("mainroot : ${secondpagecontroller.mainRoot}");
//                                     }
//                                     secondpagecontroller.update();
//                                     Get.back();
//                                   },
//                                   child: ContentText(
//                                     color: Appcolor().maincolor,
//                                     textSize: 2.2.h,
//                                     text: Mystrings.object,
//                                   )))),
//                       Divider(
//                         color: Appcolor().colorGrey,
//                       ),
//                       Expanded(
//                           flex: 1,
//                           child: Container(
//                               width: 70.w,
//                               child: InkWell(
//                                   onTap: () async {
//
//                                     TextEditingController valueTController = TextEditingController();
//                                     TextEditingController nameTController = TextEditingController();
//
//                                     All selectedVal = All.Text;
//                                     TF selectedTF = TF.True;
//                                     bool visibility_of_textF1 = true;
//                                     bool visibility_of_textF2 = true;
//                                     bool visibility_of_radioB = false;
//
//                                        if(secondpagecontroller.mainRoot["${allkeys[index]}"].runtimeType == List<dynamic>){
//                                           visibility_of_textF2 = false;
//                                        }
//
//                                         return await Get.dialog( StatefulBuilder(
//                                             builder: (context, setState) => AlertDialog(
//                                               contentPadding: EdgeInsets.only(top: 0.5.w,left: 2.w,right: 2.w),
//                                               content: Container(
//                                                 width: 72.w,
//                                                 padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
//                                                 height: (secondpagecontroller.mainRoot[index].runtimeType == List<dynamic>) ? 13.h : 21.h,
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
//                                                 ContentText(
//                                                   text: "True",
//                                                   textSize: 2.h ,
//                                                   color: Appcolor().colorBlack,
//                                                 ),
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
//
//                                                 ]),
//                                               ),
//                                               actions: [
//                                                 MaterialButton(
//                                                   child: ContentText(
//                                                     text: Mystrings.ok,
//                                                     color: Appcolor().maincolor,
//                                                     textSize: 2.h,
//                                                   ),
//                                                   color: Appcolor().colorWhite,
//                                                   onPressed: () {
//                                                     if(secondpagecontroller.mainRoot["${allkeys[index]}"].runtimeType == List<dynamic>){
//                                                       if(selectedVal == All.Boolean){
//                                                         print("bool is selected");
//                                                         if(selectedTF == TF.True){
//                                                           print("its true");
//                                                           secondpagecontroller.mainRoot["${allkeys[index]}"].add("true");
//                                                         } else {
//                                                           print("its false");
//                                                           secondpagecontroller.mainRoot["${allkeys[index]}"].add("false");
//                                                         }
//                                                       } else {
//                                                       secondpagecontroller.mainRoot["${allkeys[index]}"].add("${valueTController.text}");
//                                                       print("mainRoot ${secondpagecontroller.mainRoot}");
//                                                       }
//                                                     } else {
//                                                       if(selectedVal == All.Boolean){
//                                                         if(selectedTF ==TF.True){
//                                                           secondpagecontroller.mainRoot["${allkeys[index]}"]["${nameTController.text}"] = "true";
//                                                         } else {
//                                                           secondpagecontroller.mainRoot["${allkeys[index]}"]["${nameTController.text}"] = "false";
//                                                         }
//                                                       } else {
//                                                         secondpagecontroller.mainRoot["${allkeys[index]}"]["${nameTController.text}"] = "${valueTController.text}";
//                                                       }
//                                                     }
//                                                     secondpagecontroller.update();
//                                                     Get.back();
//                                                     Get.back();
//                                                   },
//                                                 ),
//                                                 MaterialButton(
//                                                   child: ContentText(
//                                                     text: Mystrings.cancel,
//                                                     color: Appcolor().maincolor,
//                                                     textSize: 2.h,
//                                                   ),
//                                                   color: Appcolor().colorWhite,
//                                                   onPressed: () {
//                                                     secondpagecontroller.update();
//                                                     Get.back();
//                                                     Get.back();
//                                                   },
//                                                 ),
//                                               ],
//                                             )));
//                                        } ,
//                                   child: ContentText(
//                                     color: Appcolor().maincolor,
//                                     textSize: 2.2.h,
//                                     text: Mystrings.value,
//                                   )))),
//                     ],
//                   ),
//                 ),
//               ));
//
//       },
//       child: Icon(
//         Icons.add,
//         color: Appcolor().colorWhite,)
//
//   );
// }
//
// showFloatingButton_ontapPage_forList(BuildContext context , SecondpageController secondpagecontroller, int index, List allkeys){
//   return FloatingActionButton(
//       backgroundColor: Appcolor().colorOrange,
//       onPressed: () async{
//
//         return await Get.dialog( AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           content: Container(
//             padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
//             decoration: BoxDecoration(border: Border.all(color: Appcolor().colorGrey)),
//             height: 18.h,
//             child: Column(
//               children: [
//                 Expanded(
//                     flex: 1,
//                     child: Container(
//                         width: 70.w,
//                         child: InkWell(
//                             onTap: () async{
//                               print("press Array");
//                               //  print("thirdpagecontroller.rootType ${secondpagecontroller.mainRoot[[index]].runtimeType}");
//                               // print("thirdpagecontroller.rootType ${secondpagecontroller.mainRoot["${allkeys[index]}"].runtimeType}");
//                               if (secondpagecontroller.mainRoot[index].runtimeType == List<dynamic>) {
//                                 secondpagecontroller.mainRoot[index].add([]);
//                                 print("mainroot : ${secondpagecontroller.mainRoot}");
//                               } else {
//                                 var name = await  getName_Dialog(context,Mystrings.name);
//                                 secondpagecontroller.mainRoot[index]["${name}"] = [];
//                                 print("mainroot : ${secondpagecontroller.mainRoot}");
//                               }
//                               secondpagecontroller.update();
//                               Get.back();
//                             },
//                             child: ContentText(
//                               color: Appcolor().maincolor,
//                               textSize: 2.2.h,
//                               text: Mystrings.array,
//                             )))),
//                 Divider(
//                   color: Appcolor().colorGrey,
//                 ),
//                 Expanded(
//                     flex: 1,
//                     child: Container(
//                         width: 70.w,
//                         child: InkWell(
//                             onTap: () async{
//                               if (secondpagecontroller.mainRoot[index].runtimeType == List<dynamic>) {
//                                 secondpagecontroller.mainRoot[index].add({});
//                                 print("mainroot : ${secondpagecontroller.mainRoot}");
//                               } else {
//                                 var name = await  getName_Dialog(context,Mystrings.name);
//                                 secondpagecontroller.mainRoot[index]["${name}"] = {};
//                                 print("mainroot : ${secondpagecontroller.mainRoot}");
//                               }
//                               secondpagecontroller.update();
//                               Get.back();
//                             },
//                             child: ContentText(
//                               color: Appcolor().maincolor,
//                               textSize: 2.2.h,
//                               text: Mystrings.object,
//                             )))),
//                 Divider(
//                   color: Appcolor().colorGrey,
//                 ),
//                 Expanded(
//                     flex: 1,
//                     child: Container(
//                         width: 70.w,
//                         child: InkWell(
//                             onTap: () async {
//
//                               TextEditingController valueTController = TextEditingController();
//                               TextEditingController nameTController = TextEditingController();
//
//                               All selectedVal = All.Text;
//                               TF selectedTF = TF.True;
//                               bool visibility_of_textF1 = true;
//                               bool visibility_of_textF2 = true;
//                               bool visibility_of_radioB = false;
//
//                               if(secondpagecontroller.mainRoot[index].runtimeType == List<dynamic>){
//                                 visibility_of_textF2 = false;
//                               }
//
//                               return await Get.dialog( StatefulBuilder(
//                                   builder: (context, setState) => AlertDialog(
//                                     contentPadding: EdgeInsets.only(top: 0.5.w,left: 2.w,right: 2.w),
//                                     content: Container(
//                                       width: 72.w,
//                                       padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
//                                       height: (secondpagecontroller.mainRoot[index].runtimeType == List<dynamic>) ? 13.h : 21.h,
//                                       child: Column(children: [
//                                         Visibility(
//                                           visible: visibility_of_textF2,
//                                           child: TextField(
//                                             controller: nameTController,
//                                             decoration: InputDecoration(
//                                               hintText: "Name",
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(height: 1.w,),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Radio(
//                                                 visualDensity: const VisualDensity(
//                                                     horizontal: VisualDensity.minimumDensity,
//                                                     vertical: VisualDensity.minimumDensity),
//                                                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                 value: All.Text,
//                                                 groupValue: selectedVal,
//                                                 onChanged: (All? val) {
//                                                   setState(() {
//                                                     selectedVal = val!;
//                                                     visibility_of_radioB = false;
//                                                     visibility_of_textF1 = true;
//                                                   });
//                                                 }),
//                                             ContentText(
//                                               text: "Text",
//                                               textSize: 2.h ,
//                                               color: Appcolor().colorBlack,
//                                             ),
//                                             Radio(
//                                                 visualDensity: const VisualDensity(
//                                                     horizontal: VisualDensity.minimumDensity,
//                                                     vertical: VisualDensity.minimumDensity),
//                                                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                 value: All.Number,
//                                                 groupValue: selectedVal,
//                                                 onChanged: (All? val) {
//                                                   setState(() {
//                                                     selectedVal = val!;
//                                                     visibility_of_radioB = false;
//                                                     visibility_of_textF1 = true;
//                                                   });
//                                                 }),
//                                             ContentText(
//                                               text: "Number",
//                                               textSize: 2.h ,
//                                               color: Appcolor().colorBlack,
//                                             ),
//                                             Radio(
//                                                 visualDensity: const VisualDensity(
//                                                     horizontal: VisualDensity.minimumDensity,
//                                                     vertical: VisualDensity.minimumDensity),
//                                                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                 value: All.Boolean,
//                                                 groupValue: selectedVal,
//                                                 onChanged: (All? val) {
//                                                   setState(() {
//                                                     selectedVal = val!;
//                                                     visibility_of_radioB = true;
//                                                     visibility_of_textF1 = false;
//                                                   });
//                                                 }),
//                                             ContentText(
//                                               text: "Bool",
//                                               textSize: 2.h ,
//                                               color: Appcolor().colorBlack,
//                                             ),
//                                           ],
//                                         ),
//                                         Visibility(
//                                           visible: visibility_of_textF1,
//                                           child: TextField(
//                                             controller: valueTController,
//                                             keyboardType: selectedVal.toString().contains("Text")
//                                                 ? TextInputType.text
//                                                 : selectedVal.toString().contains("Number")
//                                                 ? TextInputType.number
//                                                 : null,
//                                             decoration: InputDecoration(
//                                               hintText: "${selectedVal.toString().split('.').last}",
//                                             ),
//                                           ),
//                                         ),
//                                         Visibility(
//
//                                           visible: visibility_of_radioB,
//                                           child: Container(
//                                             padding: EdgeInsets.only(top: 1.5.h),
//                                             child: Row(
//                                               children: [
//                                                 Radio(
//                                                     visualDensity: const VisualDensity(
//                                                         horizontal: VisualDensity.minimumDensity,
//                                                         vertical: VisualDensity.minimumDensity),
//                                                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                     value: TF.True,
//                                                     groupValue: selectedTF,
//                                                     onChanged: (TF? val) {
//                                                       setState(() {
//                                                         selectedTF = val!;
//                                                       });
//                                                     }),
//                                                 ContentText(
//                                                   text: "True",
//                                                   textSize: 2.h ,
//                                                   color: Appcolor().colorBlack,
//                                                 ),
//                                                 SizedBox(
//                                                   width: 8.w,
//                                                 ),
//                                                 Radio(
//                                                     visualDensity: const VisualDensity(
//                                                         horizontal: VisualDensity.minimumDensity,
//                                                         vertical: VisualDensity.minimumDensity),
//                                                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                     value: TF.False,
//                                                     groupValue: selectedTF,
//                                                     onChanged: (TF? val) {
//                                                       setState(() {
//                                                         selectedTF = val!;
//                                                       });
//                                                     }),
//                                                 ContentText(
//                                                   text: "False",
//                                                   textSize: 2.h ,
//                                                   color: Appcolor().colorBlack,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//
//
//                                       ]),
//                                     ),
//                                     actions: [
//                                       MaterialButton(
//                                         child: ContentText(
//                                           text: Mystrings.ok,
//                                           color: Appcolor().maincolor,
//                                           textSize: 2.h,
//                                         ),
//                                         color: Appcolor().colorWhite,
//                                         onPressed: () {
//                                           if(secondpagecontroller.mainRoot[index].runtimeType == List<dynamic>){
//                                             if(selectedVal == All.Boolean){
//                                               print("bool is selected");
//                                               if(selectedTF == TF.True){
//                                                 print("its true");
//                                                 secondpagecontroller.mainRoot[index].add("true");
//                                               } else {
//                                                 print("its false");
//                                                 secondpagecontroller.mainRoot[index].add("false");
//                                               }
//                                             } else {
//                                               secondpagecontroller.mainRoot[index].add("${valueTController.text}");
//                                               print("mainRoot ${secondpagecontroller.mainRoot}");
//                                             }
//                                           } else {
//                                             if(selectedVal == All.Boolean){
//                                               if(selectedTF ==TF.True){
//                                                 secondpagecontroller.mainRoot[index]["${nameTController.text}"] = "true";
//                                               } else {
//                                                 secondpagecontroller.mainRoot[index]["${nameTController.text}"] = "false";
//                                               }
//                                             } else {
//                                               secondpagecontroller.mainRoot[index]["${nameTController.text}"] = "${valueTController.text}";
//                                             }
//                                           }
//                                           secondpagecontroller.update();
//                                           Get.back();
//                                           Get.back();
//                                         },
//                                       ),
//                                       MaterialButton(
//                                         child: ContentText(
//                                           text: Mystrings.cancel,
//                                           color: Appcolor().maincolor,
//                                           textSize: 2.h,
//                                         ),
//                                         color: Appcolor().colorWhite,
//                                         onPressed: () {
//                                           secondpagecontroller.update();
//                                           Get.back();
//                                           Get.back();
//                                         },
//                                       ),
//                                     ],
//                                   )));
//                             } ,
//                             child: ContentText(
//                               color: Appcolor().maincolor,
//                               textSize: 2.2.h,
//                               text: Mystrings.value,
//                             )))),
//               ],
//             ),
//           ),
//         ));
//
//       },
//       child: Icon(
//         Icons.add,
//         color: Appcolor().colorWhite,)
//
//   );
// }
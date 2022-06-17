import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:get/get.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:test_fragment/Controller/SecondPage_Controller.dart';
import 'package:test_fragment/Routes/Routes.dart';
import 'package:test_fragment/Screens/MainScreens/SecondPage.dart';
import 'package:test_fragment/Screens/ViewText.dart';
import 'package:test_fragment/config/Const.dart';
import 'package:test_fragment/config/Mystrings.dart';
import 'package:test_fragment/config/colors.dart';
import 'package:test_fragment/elements/ContentText.dart';
import 'package:http/http.dart' as http;

showToastSnack(String text) {
  try {
    Fluttertoast.showToast(
        msg: text,
        toastLength: (text.length > 50) ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: (text.length > 50) ? 3 : 1,
        backgroundColor: Appcolor().maincolor,
        textColor: Appcolor().colorWhite,
        fontSize: 16.0);
  } catch (e) {
    print(e.toString());
  }
}

showDialogtoAdd_MainPage({Function(int)? ontap}) async {
  return await Get.dialog(AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      decoration: BoxDecoration(border: Border.all(color: Appcolor().colorGrey)),
      height: 11.h,
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  width: 70.w,
                  child: InkWell(
                      onTap: () {
                        ontap!(1);
                        // Get.toNamed(Routes.SecondPage, arguments: {"val_mainpage": 1});
                      },
                      child: ContentText(
                        color: Appcolor().maincolor,
                        textSize: 2.h,
                        text: Mystrings.array,
                      )))),
          Divider(
            color: Appcolor().colorGrey,
          ),
          Expanded(
              flex: 1,
              child: Container(
                  width: 70.w,
                  child: InkWell(
                      onTap: () {
                        ontap!(2);
                        // Get.toNamed(Routes.SecondPage, arguments: {"val_mainpage": 2});
                      },
                      child: ContentText(
                        color: Appcolor().maincolor,
                        textSize: 2.h,
                        text: Mystrings.object,
                      )))),
        ],
      ),
    ),
  ));
}

showMyDialog_for_Value(BuildContext context, {key, value, isbool}) async {
  print("valueBool ${value}");



  All selectedVal = isbool ? All.Boolean : All.Text;
  All check = isbool ? All.Boolean : All.Text;
  TF selectedTF = isbool
      ? value.toString().contains("true")
          ? TF.True
          : TF.False
      : TF.True;
  bool visibility_of_textF = isbool ? false : true;
  bool visibility_of_radioB = isbool ? true : false;

  if(double.tryParse(value) == null){
    print('The input is not a numeric string');
  } else {
    print('Yes, it is a numeric string');
    selectedVal = All.Number;
    check = All.Number;
  }

  TextEditingController nameTController = TextEditingController(text: key);
  TextEditingController valueTController = TextEditingController(text: value);

  return await Get.dialog(StatefulBuilder(
      builder: (context, setState) => AlertDialog(
            contentPadding: EdgeInsets.only(top: 0.5.w, left: 2.w, right: 2.w),
            content: Container(
              padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
              height: 23.h,
              child: Column(children: [
                TextField(
                  cursorColor: Appcolor().colorOrange,
                  controller: nameTController,
                  decoration: InputDecoration(hintText: "Name",focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Appcolor().colorOrange),
                  ),),
                ),
                SizedBox(
                  height: 1.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        focusColor: Appcolor().colorOrange,
                        activeColor: Appcolor().colorOrange,
                        visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        value: All.Text,
                        groupValue: selectedVal,
                        onChanged: (All? val) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            print("1 ${selectedVal.name}");
                            print("2 ${All.Text.name}");
                            if(check.name != All.Text.name){
                              valueTController.clear();
                            } else {
                              valueTController.text = value.toString();
                            }
                            selectedVal = val!;
                            visibility_of_radioB = false;
                            visibility_of_textF = true;
                          });
                        }),
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
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        value: All.Number,
                        groupValue: selectedVal,
                        onChanged: (All? val) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            print("1 ${selectedVal.name}");
                            print("2 ${All.Number.name}");
                            if(check.name != All.Number.name){
                              valueTController.clear();
                            } else {
                              valueTController.text = value.toString();
                            }
                            selectedVal = val!;
                            visibility_of_radioB = false;
                            visibility_of_textF = true;
                          });
                        }),
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
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        value: All.Boolean,
                        groupValue: selectedVal,
                        onChanged: (All? val) {
                          setState(() {
                            selectedVal = val!;
                            visibility_of_radioB = true;
                            visibility_of_textF = false;
                          });
                        }),
                    ContentText(
                      text: "Boolean",
                      textSize: 2.h,
                      color: Appcolor().colorBlack,
                    ),
                  ],
                ),
                Visibility(
                  visible: visibility_of_textF,
                  child: TextField(
                    cursorColor: Appcolor().colorOrange,
                    controller: valueTController,
                    keyboardType: selectedVal.toString().contains("Text")
                        ? TextInputType.text
                        : selectedVal.toString().contains("Number")
                            ? TextInputType.number
                            : null,
                    decoration: InputDecoration(
                      hintText: "${selectedVal.toString().split('.').last}",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Appcolor().colorOrange),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: visibility_of_radioB,
                  child: Row(
                    children: [
                      Radio(
                          focusColor: Appcolor().colorOrange,
                          activeColor: Appcolor().colorOrange,
                          value: TF.True,
                          groupValue: selectedTF,
                          onChanged: (TF? val) {
                            setState(() {
                              selectedTF = val!;
                            });
                          }),
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
                          value: TF.False,
                          groupValue: selectedTF,
                          onChanged: (TF? val) {
                            setState(() {
                              selectedTF = val!;
                            });
                          }),
                      ContentText(
                        text: "False",
                        textSize: 2.h,
                        color: Appcolor().colorBlack,
                      ),
                    ],
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

                  if( (!selectedTF.name.toLowerCase().contains("true")) && (selectedVal.name == All.Boolean.name) ){
                    print("timetochange T: ${selectedTF.name}");

                    valueTController.text = "false";

                  } else if ((!selectedTF.name.toLowerCase().contains("false")) && (selectedVal.name == All.Boolean.name)){
                    print("timetochange F: ${selectedTF.name}");
                    valueTController.text = "true";
                  }
                  print("Boolcheck: ${(value.toString().contains("false") && (selectedTF.name.toLowerCase() != false))}");

                  Get.back(result: (key != nameTController.text || value != valueTController.text) ? [nameTController.text, valueTController.text] : null);
                },
              ),
            ],
          )));
}

showMyDialog_for_Value_ForList(BuildContext context, {key, value, isbool}) async {
  print("valueBool ${value}");

  All_forList selectedVal = isbool ? All_forList.Boolean : All_forList.Text;
  TF_forList selectedTF = isbool
      ? value.toString().contains("true")
      ? TF_forList.True
      : TF_forList.False
      : TF_forList.True;
  bool visibility_of_textF = isbool ? false : true;
  bool visibility_of_radioB = isbool ? true : false;
  TextEditingController valueTController = TextEditingController(text: value);

  return await Get.dialog(StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        contentPadding: EdgeInsets.only(top: 0.5.w, left: 2.w, right: 2.w),
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
          height: 14.h,
          child: Column(children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                    focusColor: Appcolor().colorOrange,
                    activeColor: Appcolor().colorOrange,
                    visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity),
                    value: All_forList.Text,
                    groupValue: selectedVal,
                    onChanged: (All_forList? val) {
                      setState(() {
                        selectedVal = val!;
                        visibility_of_radioB = false;
                        visibility_of_textF = true;
                      });
                    }),
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
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity),
                    value: All_forList.Number,
                    groupValue: selectedVal,
                    onChanged: (All_forList? val) {
                      setState(() {
                        selectedVal = val!;
                        visibility_of_radioB = false;
                        visibility_of_textF = true;
                      });
                    }),
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
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity),
                    value: All_forList.Boolean,
                    groupValue: selectedVal,
                    onChanged: (All_forList? val) {
                      setState(() {
                        selectedVal = val!;
                        visibility_of_radioB = true;
                        visibility_of_textF = false;
                      });
                    }),
                ContentText(
                  text: "Boolean",
                  textSize: 2.h,
                  color: Appcolor().colorBlack,
                ),
              ],
            ),
            Visibility(
              visible: visibility_of_textF,
              child: TextField(
                cursorColor: Appcolor().colorOrange,
                controller: valueTController,
                keyboardType: selectedVal.toString().contains("Text")
                    ? TextInputType.text
                    : selectedVal.toString().contains("Number")
                    ? TextInputType.number
                    : null,
                decoration: InputDecoration(
                  hintText: "${selectedVal.toString().split('.').last}",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Appcolor().colorOrange),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: visibility_of_radioB,
              child: Row(
                children: [
                  Radio(
                      focusColor: Appcolor().colorOrange,
                      activeColor: Appcolor().colorOrange,
                      value: TF_forList.True,
                      groupValue: selectedTF,
                      onChanged: (TF_forList? val) {
                        setState(() {
                          selectedTF = val!;
                        });
                      }),
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
                      value: TF_forList.False,
                      groupValue: selectedTF,
                      onChanged: (TF_forList? val) {
                        setState(() {
                          selectedTF = val!;
                        });
                      }),
                  ContentText(
                    text: "False",
                    textSize: 2.h,
                    color: Appcolor().colorBlack,
                  ),
                ],
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
              if( value.toString().toLowerCase().contains("true") && !(selectedTF.name.toLowerCase().contains("true"))){
                print("timetochange T: ${selectedTF.name}");

                valueTController.text = "false";
              } else if(value.toString().toLowerCase().contains("false") && !(selectedTF.name.toLowerCase().contains("false"))){
                print("timetochange F: ${selectedTF.name}");
                valueTController.text = "true";
              }
              print("Boolcheck: ${(value.toString().contains("false") && (selectedTF.name.toLowerCase() != false))}");

              Get.back(result: ( value != valueTController.text) ? [valueTController.text] : null);
            },
          ),
        ],
      )));
}

showDialogtoOpenUrl(BuildContext context, FragNavigate fragNav) async {
  TextEditingController urlcontroller = TextEditingController();

  return await Get.dialog(AlertDialog(
    titlePadding: EdgeInsets.all(0.0),
    insetPadding: EdgeInsets.all(0.0),
    contentPadding: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
    content: Container(
      width: 80.w,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(

          cursorColor: Appcolor().colorOrange,
          controller: urlcontroller,
          style: TextStyle(
              fontSize: 2.h
          ),
          decoration: InputDecoration(
              hintText: Mystrings.enter_url,
            hintStyle: TextStyle(
              fontSize: 2.h
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Appcolor().colorOrange),
            ),
          ),
        ),
      ),
    ),
    actions: [
      MaterialButton(
        child: ContentText(
          text: Mystrings.cancel,
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
          text: Mystrings.save,
          color: Appcolor().maincolor,
          textSize: 2.h,
        ),
        color: Appcolor().colorWhite,
        onPressed: () async {
          Get.back();
          try {
            var res = await http.get(Uri.parse("${urlcontroller.text}"));
            var Data = await jsonDecode(res.body);
            if (mainRoot != null) {
              mainRoot.clear();
            }
            isFirstPage.value = false;
            mainRoot = Data;
            path_forsave.value = "";
            print("check1: ${currentIndex.value}");
            fragNav.screenList[pageKeys[currentIndex.value]] =  Posit(
                key: pageKeys[currentIndex.value],
                title: "Properties ${currentIndex.value}",
                fragment: SecondScreen(
                  fragNav: fragNav,
                  values: mainRoot,
                ));
            fragNav
                .putPosit(
                  key: pageKeys[currentIndex.value],
                )
                .then((value) => storedIndex.value = currentIndex.value);
            print("check2: ${currentIndex.value}");
            queue.clear();
            catchPathAfterSave.value = "";
            if (currentIndex.value == 1) {
              currentIndex.value++;
              count.value =1;
            }
          } catch (e) {
            showToastSnack(Mystrings.invalid_json);
          }
        },
      ),

    ],
  ));
}



getName_Dialog(BuildContext context, String hinttext, {String textvalue = "", bool isforopen = false}) async {
  TextEditingController namecontroller = TextEditingController(text: textvalue);
  return await Get.dialog(AlertDialog(
    titlePadding: EdgeInsets.all(0.0),
    insetPadding: EdgeInsets.all(0.0),
    contentPadding: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        cursorColor: Appcolor().colorOrange,
        controller: namecontroller,
        decoration: InputDecoration(hintText: hinttext,focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Appcolor().colorOrange),
        ),),
      ),
    ),
    actions: [

      MaterialButton(
        child: ContentText(
          text: Mystrings.cancel,
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
          text: Mystrings.save,
          color: Appcolor().maincolor,
          textSize: 2.h,
        ),
        color: Appcolor().colorWhite,
        onPressed: () {
          if (textvalue == namecontroller.text) {
            Get.back();
          } else {
            Get.back(result: namecontroller.text);
          }
        },
      ),
    ],
  ));
}

getName_Dialog_for_GetjsonText(BuildContext context, String hinttext, {String textvalue = "", bool isforopen = false}) async {
  TextEditingController namecontroller = TextEditingController(text: textvalue);
  return await Get.dialog(AlertDialog(
    titlePadding: EdgeInsets.all(0.0),
    insetPadding: EdgeInsets.all(0.0),
    contentPadding: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
    content: Container(
      width: 80.w,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: TextStyle(
            fontSize: 2.h
          ),
          cursorColor: Appcolor().colorOrange,
          controller: namecontroller,
          maxLines: 20,
          minLines: 1,
          onChanged: (strings){
            namecontroller.text = prettyJson(jsonDecode(strings));
          },
          decoration: InputDecoration(hintText: hinttext,focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Appcolor().colorOrange),
          ),),
        ),
      ),
    ),
    actions: [

      MaterialButton(
        child: ContentText(
          text: Mystrings.cancel,
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
          text: Mystrings.save,
          color: Appcolor().maincolor,
          textSize: 2.h,
        ),
        color: Appcolor().colorWhite,
        onPressed: () {
          if (textvalue == namecontroller.text) {
            Get.back();
          } else {
            Get.back(result: namecontroller.text);
          }
        },
      ),
    ],
  ));
}

getName_Dialog_openJsonText(BuildContext context, String hinttext, {String textvalue = "", bool isforopen = false}) async {
  TextEditingController namecontroller = TextEditingController(text: textvalue);
  return await Get.dialog(AlertDialog(
    titlePadding: EdgeInsets.all(0.0),
    insetPadding: EdgeInsets.all(0.0),
    contentPadding: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        cursorColor: Appcolor().colorOrange,
        controller: namecontroller,
        decoration: InputDecoration(hintText: hinttext,focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Appcolor().colorOrange),
        ),),
      ),
    ),
    actions: [
      MaterialButton(
        child: ContentText(
          text: Mystrings.ok,
          color: Appcolor().maincolor,
          textSize: 2.h,
        ),
        color: Appcolor().colorWhite,
        onPressed: () {
          if (textvalue == namecontroller.text) {
            Get.back();
          } else {
            Get.back(result: namecontroller.text);
          }
        },
      ),
      MaterialButton(
        child: ContentText(
          text: Mystrings.cancel,
          color: Appcolor().maincolor,
          textSize: 2.h,
        ),
        color: Appcolor().colorWhite,
        onPressed: () {
          Get.back();
        },
      )
    ],
  ));
}


show_Dialog_forExit() async {
  TextEditingController nameController = TextEditingController();
  return await Get.dialog(AlertDialog(
    titlePadding: EdgeInsets.all(0.0),
    insetPadding: EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    contentPadding: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
    content: Padding(
      padding: const EdgeInsets.fromLTRB(5,8,5,8),
      child: Container(
        width: 75.w,
        height: 10.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentText(textSize: 2.9.h, color: Appcolor().colorBlack, text: Mystrings.exit,fontWeight: FontWeight.w600,),
            SizedBox(height: 2.1.h,),
            ContentText(textSize: 2.2.h, color: Appcolor().colorBlack, text: Mystrings.exit_text)
          ],
        ),
      ),
    ),
    actions: [
      MaterialButton(
        elevation: 0,
        child: ContentText(
          text: Mystrings.no,
          color: Appcolor().colorOrange,
          textSize: 2.h,
          fontWeight: FontWeight.w600,
        ),
        color: Appcolor().colorWhite,
        onPressed: () {
            Get.back();
        },
      ),
      MaterialButton(
        elevation: 0,
        child: ContentText(
          text: Mystrings.yes,
          color: Appcolor().colorOrange,
          textSize: 2.h,
          fontWeight: FontWeight.w600,
        ),
        color: Appcolor().colorWhite,
        onPressed: () {
          if (Platform.isAndroid)
            SystemNavigator.pop();
          else
            exit(0);
        },
      )
    ],
  buttonPadding: EdgeInsets.zero,

  ));
}

show_Dialog_forDelete({Function(bool)? ontap , String kname = ""}) async {
  return await Get.dialog(AlertDialog(

    titlePadding: EdgeInsets.all(0.0),
    insetPadding: EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    contentPadding: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
    content: Padding(
      padding: const EdgeInsets.fromLTRB(5,8,5,8),
      child: Container(
        width: 75.w,
        height: 14.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentText(textSize: 2.9.h, color: Appcolor().colorBlack, text: Mystrings.remove,fontWeight: FontWeight.w600,),
            SizedBox(height: 2.1.h,),
            ContentText(textSize: 2.2.h, color: Appcolor().colorBlack, text: "Are you sure you want to remove $kname?")
          ],
        ),
      ),
    ),
    actions: [
      MaterialButton(
        elevation: 0,
        child: ContentText(
          text: Mystrings.no,
          color: Appcolor().colorOrange,
          textSize: 2.h,
          fontWeight: FontWeight.w600,
        ),
        color: Appcolor().colorWhite,
        onPressed: () {
          Get.back();
        },
      ),
      MaterialButton(
        elevation: 0,
        child: ContentText(
          text: Mystrings.yes,
          color: Appcolor().colorOrange,
          textSize: 2.h,
          fontWeight: FontWeight.w600,
        ),
        color: Appcolor().colorWhite,
        onPressed: () {
         ontap!(true);
        },
      )
    ],
    buttonPadding: EdgeInsets.zero,
    actionsOverflowButtonSpacing: 0.0,

  ));
}


showDialog_for_save(SecondpageController secondpagecontroller) async {
  print("path_forsave ${path_forsave.value}");
  List paths = path_forsave.value.toString().split("/");
  print("name of file: ${paths.last}");
  print("catchPathAfterSave: ${catchPathAfterSave.value}");
  TextEditingController savenamecontroller = TextEditingController(text: catchPathAfterSave.value.isNotEmpty ? catchPathAfterSave.value : path_forsave.value.isNotEmpty ? paths.last.toString().replaceAll(".json", "") :  DateTime.now().toString().trim().removeAllWhitespace.replaceAll(".", "").replaceAll("-", "").replaceAll(":", ""));
  TextEditingController indentController = TextEditingController(text: "3");

  return await Get.dialog(AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      height: 35.h,
      width: 90.w,
      child: Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ContentText(
              textSize: 2.2.h,
              color: Appcolor().colorBlack,
              text: Mystrings.saveas,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 1.h,
            ),
            ContentText(textSize: 1.5.h, color: Appcolor().colorGrey, text:secondpagecontroller.directorypath),
            SizedBox(
              height: 2.h,
            ),
            ContentText(textSize: 2.h, color: Appcolor().colorBlack, text: Mystrings.filename),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                    onChanged: (p0) {
                      if(p0.isNotEmpty){
                        if(p0[0] == " "){
                          savenamecontroller.clear();
                        }
                      }
                    },
                    cursorColor: Appcolor().colorOrange,
                    controller: savenamecontroller,
                    decoration: InputDecoration(hintText: Mystrings.name, contentPadding: EdgeInsets.zero,isDense: true,focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Appcolor().colorOrange,)
                    ),),
                    style: TextStyle(color: Appcolor().colorGrey, fontSize: 1.8.h),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(".json"),
                    ))
              ],
            ),
            SizedBox(height: 0.5.h,),
            Container(
              child: CheckboxListTile(
                visualDensity: VisualDensity( horizontal: -4,vertical: -2) ,
                contentPadding: EdgeInsets.symmetric(horizontal: 0 ,vertical: -4),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Appcolor().colorOrange,
                checkColor: Appcolor().colorWhite,
                title: Row(
                  children: [
                    ContentText(
                      text: Mystrings.indent,
                      color: Appcolor().colorBlack,
                      textSize: 1.8.h,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Visibility(
                        visible: secondpagecontroller.save_intend.value,
                        child: Row(
                          children: [
                            ContentText(
                              text: Mystrings.numberodspace,
                              color: Appcolor().colorGrey,
                              textSize: 1.6.h,
                            ),
                            SizedBox(width: 2.w),
                            Container(
                              width: 10.w,
                              child: TextField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                ],
                                onChanged: (p0) {
                                  if(p0.isNotEmpty){
                                    if(p0[0] == " "){
                                      indentController.clear();
                                    }
                                  }
                                },
                                cursorColor: Appcolor().colorOrange,
                                controller: indentController,
                                style: TextStyle(
                                  fontSize: 2.h
                                ),
                                decoration:
                                    InputDecoration(focusColor: Appcolor().colorOrange, focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Appcolor().colorOrange),
                                    ), contentPadding: EdgeInsets.zero,isDense: true),
                                keyboardType: TextInputType.number,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                value: secondpagecontroller.save_intend.value,
                onChanged: (bool? value) {
                  secondpagecontroller.save_intend.value = !secondpagecontroller.save_intend.value;
                },
              ),
            ),
          ])),
    ),
    actions: [

      InkWell(
          onTap: () {
            print("${secondpagecontroller.savefile_path}");
            Get.back();
          },
          child: ContentText(
            text: Mystrings.cancel,
            color: Appcolor().maincolor,
            textSize: 2.3.h,
            fontWeight: FontWeight.w600,
          )),
      SizedBox(
        width: 5.w,
      ),
      InkWell(
          onTap: () async {
            await secondpagecontroller.savefile(savenamecontroller.text, indentController.text.isNotEmpty ? int.parse(indentController.text) : 12);
            Get.back();
          },
          child: ContentText(
            text: Mystrings.save,
            color: Appcolor().maincolor,
            textSize: 2.3.h,
            fontWeight: FontWeight.w600,
          )),
    ],
  ));
}

showDialog_for_Share(SecondpageController secondpagecontroller) async {
  TextEditingController indentController = TextEditingController();

  return await Get.dialog(AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      height: 20.h,
      width: 80.w,
      child: Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ContentText(
              textSize: 2.2.h,
              color: Appcolor().colorBlack,
              text: Mystrings.share,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 2.h,
            ),
            CheckboxListTile(
              dense: true,contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Appcolor().colorOrange,
              checkColor: Appcolor().colorWhite,
              title: Row(
                children: [
                  ContentText(
                    text: Mystrings.indent,
                    color: Appcolor().colorBlack,
                    textSize: 1.8.h,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Visibility(
                      visible: secondpagecontroller.share_intend.value,
                      child: Row(
                        children: [
                          ContentText(
                            text: Mystrings.numberodspace,
                            color: Appcolor().colorGrey,
                            textSize: 1.6.h,
                          ),
                          SizedBox(width: 1.w),
                          Container(
                            width: 10.w,
                            child: TextField(
                              onChanged: (p0) {
                                if(p0.isNotEmpty){
                                  if(p0[0] == " "){
                                    indentController.clear();
                                  }
                                }
                              },
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                              ],
                              cursorColor: Appcolor().colorOrange,
                              controller: indentController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(

                                    isDense: true,
                                      focusColor: Appcolor().colorOrange, focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Appcolor().colorOrange),
                                  ), contentPadding: EdgeInsets.zero),
                            ),
                          )
                        ],
                      ))
                ],
              ),
              value: secondpagecontroller.share_intend.value,
              onChanged: (bool? value) {
                secondpagecontroller.share_intend.value = !secondpagecontroller.share_intend.value;
              },
            ),
        SizedBox(height: 1.h,),

          ])),
    ),
    actions: [
      InkWell(
          onTap: () async {
            Get.back();
          },
          child: ContentText(
            text: Mystrings.cancel.toUpperCase(),
            color: Appcolor().maincolor,
            fontWeight: FontWeight.w600,
            textSize: 2.h,
          )),
      SizedBox(
        width: 5.w,
      ),
      InkWell(
          onTap: () async {
            await secondpagecontroller.sharefile(indent: indentController.text.isNotEmpty ? int.parse(indentController.text) : 3);
            Get.back();
          },
          child: ContentText(
            text: Mystrings.share.toUpperCase(),
            color: Appcolor().maincolor,
            fontWeight: FontWeight.w600,
            textSize: 2.h,
          )),
    ],
  ));
}

updatekey() {
  Map<String, dynamic> bd = {"nm": 5, "ss": 97};
  if (bd.containsKey('nm')) {
    final value = bd['nm'];
    final index = bd.keys.toList().indexWhere((k) => k == 'nm');

    final mapEntriesList = bd.entries.toList();
    mapEntriesList.removeAt(index);
    mapEntriesList.insert(index, MapEntry('nedm', "newvalue"));
    bd = Map.fromEntries(mapEntriesList);
    print("updated map: ${bd}");
  }
}

void swap(int index1, int index2) {
  RangeError.checkValidIndex(index1, 'index1');
  RangeError.checkValidIndex(index2, 'index2');
  var tmp = index1;
  index1 = index2;
  index2 = tmp;
}

returnRuntimetype(var data) {
  Type type = data.runtimeType;
  if (type == List<dynamic>) {
    return 1;
  } else if (type.toString().contains("_InternalLinkedHashMap<dynamic, dynamic>")) {
    return 2;
  } else {
    return 3;
  }
}

DateTime? currentBackPressTime;

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
    currentBackPressTime = now;

    showToastSnack(
      Mystrings.exit_msg,
    );
    return Future.value(false);
  }
  return Future.value(true);
}

void backPressed() async {
  bool back = await onWillPop();
  if (back) {
    if (Platform.isAndroid)
      SystemNavigator.pop();
    else
      exit(0);
  }
}

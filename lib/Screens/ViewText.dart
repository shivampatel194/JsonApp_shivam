import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pretty_json/pretty_json.dart';
import 'package:test_fragment/Controller/SecondPage_Controller.dart';
import 'package:test_fragment/Screens/test_.dart';
import 'package:test_fragment/config/Const.dart';
import 'package:test_fragment/config/Mystrings.dart';
import 'package:test_fragment/config/colors.dart';
import 'package:test_fragment/elements/ContentText.dart';

class ViewText extends StatefulWidget {
  final json;

  const ViewText({Key? key, this.json}) : super(key: key);

  @override
  _ViewTextState createState() => _ViewTextState();
}

class _ViewTextState extends State<ViewText> {
  SecondpageController controller = Get.put(SecondpageController());

  @override
  void initState() {
    if (widget.json != null) {
      mainRoot = widget.json;
      print(prettyJson(mainRoot));
    } else {
      print("here is list for show ${mainRoot}");
      print(prettyJson(mainRoot));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor().colorWhite,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Stack(children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SelectableText("${prettyJson(mainRoot, indent: 12)}",style: TextStyle(color:Appcolor().colorBlack,fontSize:1.8.h),)
                      // ContentText(
                      //   color: Appcolor().colorBlack,
                      //   textSize: 1.8.h,
                      //   text: "${prettyJson(mainRoot, indent: 12)}",
                      // )
                  )),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                    onTap: () {
                      Get.back();
                    },//
                    child: ContentText(textSize: 2.8.h, color: Appcolor().colorRed, text: Mystrings.close,fontWeight: FontWeight.w600,)))
          ]),
        ),
      ),
    );
  }
}

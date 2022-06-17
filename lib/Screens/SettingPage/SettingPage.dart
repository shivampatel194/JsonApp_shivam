import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fragment/config/Const.dart';
import 'package:test_fragment/config/Mystrings.dart';
import 'package:test_fragment/config/colors.dart';
import 'package:test_fragment/elements/ContentText.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
 bool check_askToExit = true;
 bool send_CrashReport = false;
 bool hide_Fab = false;

 setdata() async{

  check_askToExit = await getPrefBool_forexit("isAskToExit");
  print("check_askToExit: $check_askToExit");
  await getPrefBool("isSendCrashReport").then((value) => send_CrashReport = value);
  await getPrefBool("isHideFab").then((value) => hide_Fab = value);
  setState(() { });
 }

 @override
  void initState() {
   setdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.h),

            CheckboxListTile(
              activeColor: Appcolor().colorOrange,
              checkColor: Appcolor().colorWhite,
              subtitle: ContentText(
                text: Mystrings.testSet_2,
                color: Appcolor().colorGrey,
                textSize: 1.9.h,
              ),
              title: ContentText(
                text: Mystrings.hide_fabonscl,
                color: Appcolor().colorBlack,
                textSize: 2.h,
              ),
              value: hide_Fab,
              onChanged: (bool? val) {
                setState(() {
                  hide_Fab = !hide_Fab;
                  setPrefBool("isHideFab", hide_Fab);
                  getPrefBool("isHideFab").then((value) {
                    print("isHideFab: ${value}");
                    isHideFab.value = value;
                  });
                });
              },
            ),
            Divider(
              color: Appcolor().colorGrey400,
            ),
            CheckboxListTile(
              activeColor: Appcolor().colorOrange,
              checkColor: Appcolor().colorWhite,
              subtitle: ContentText(
                text: Mystrings.testSet_3,
                color: Appcolor().colorGrey,
                textSize: 1.9.h,
              ),
              title: ContentText(
                text: Mystrings.asktoexit,
                color: Appcolor().colorBlack,
                textSize: 2.h,
              ),
              value: check_askToExit,
              onChanged: (bool? v) async {

                setState(() {
                  check_askToExit = !check_askToExit;
                  setPrefBool("isAskToExit", check_askToExit);
                  getPrefBool_forexit("isAskToExit").then((value) => print("isexit: ${value}"));
                });

              },
            ),
            SizedBox(
              height: 3.h,
            ),

          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:test_fragment/Controller/SecondPage_Controller.dart';
import 'package:test_fragment/Screens/MainScreens/SecondPage.dart';
import 'package:test_fragment/config/Const.dart';
import 'package:test_fragment/config/Mystrings.dart';
import 'package:test_fragment/config/Utils.dart';
import 'package:test_fragment/config/colors.dart';
import 'package:test_fragment/elements/ContentText.dart';
import 'package:test_fragment/elements/Drawer.dart';


class SecondPage extends StatefulWidget {
  final int? index;

  const SecondPage({Key? key, this.index}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  static const platformm = const MethodChannel('tinyappsteam.flutter.dev/open_file');
  String openFileUrl = "";
  SecondpageController secondpagecontroller = Get.put(SecondpageController());
   FragNavigate? fragNav;
  bool showFab = true;

  void getOpenFileUrl() async {
    dynamic url = await platformm.invokeMethod("getOpenFileUrl");
    print("getOpenFileUrl");
    if (url != null && url != openFileUrl) {
      setState(() {
        openFileUrl = url;
        print("PPPPPAAAATHHHHHHTTT $openFileUrl");
        pathFromFileManager.value = openFileUrl;
      });
      if (openFileUrl.isNotEmpty) {
        String newstr = pathFromFileManager.value.replaceAll("/external_files", "/storage/emulated/0").replaceAll("file:///", "").replaceAll("/1/", "/");
        File file = File(newstr);
        print("check1: ${file.path}");


        String data = await file.readAsString();

        var json = jsonDecode(data);
        print("check2: ${json}");

        // print("json ${json}");
        // print(prettyJson(json));
        if (mainRoot != null) {
          mainRoot.clear();
        }
        if (queue.isNotEmpty) {
          queue.clear();
        }
        mainRoot = json;

        isFirstPage.value = false;
        isFileIntent.value = true;
      }
    }
    print("check1111 ${pathFromFileManager.value}");
    print("check2_Condition: ${isFileIntent.value == true}");
    if (isFileIntent.value == true) {
      secondpagecontroller.goToPath(fragNav!, showFab);
    }
  }
  getFrag() async{
    fragNav =  FragNavigate(
      firstKey: pageKeys.first,
      screens: <Posit>[
        Posit(
          key: pageKeys.first,
          title: "joirf9ej",
          fragment: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      color: Appcolor().maincolor,
                      height: 5.h,
                      width: 100.w,
                      child: Center(
                          child: ContentText(
                            text: Mystrings.text_of_appbar,
                            color: Appcolor().maincolor_light,
                            textSize: textSize_appbar,
                          ))),
                  Container(
                    padding: EdgeInsets.all(5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContentText(text: Mystrings.text_1, color: Appcolor().black_light, textSize: textSize, fontWeight: FontWeight.w100),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        ContentText(text: Mystrings.text_2, color: Appcolor().black_light, textSize: textSize, fontWeight: FontWeight.w100),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        ContentText(text: Mystrings.text_3, color: Appcolor().black_light, textSize: textSize, fontWeight: FontWeight.w100),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        ContentText(text: Mystrings.text_4, color: Appcolor().black_light, textSize: textSize, fontWeight: FontWeight.w100),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        ContentText(text: Mystrings.text_5, color: Appcolor().black_light, textSize: textSize, fontWeight: FontWeight.w100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

  }
  @override
  void initState()  {
    getFrag();

    getOpenFileUrl();

    super.initState();
  }

  @override
  void dispose() {
    fragNav?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fragNav?.setDrawerContext = context;

    return StreamBuilder<FullPosit>(
        stream: fragNav?.outStreamFragment,
        builder: (context, s) {
          if (s.data != null) {
            return DefaultTabController(
                length: s.data!.bottom?.length ?? 1,
                child: Scaffold(
                  drawer: ShowDrawer(fragNav!),
                  appBar: isFirstPage.value == true
                      ? AppBar(
                    backgroundColor: Appcolor().maincolor,
                    elevation: 0,
                    title: Text(Mystrings.json_reader),
                  )
                      : null,
                  key: fragNav?.drawerKey,
                  floatingActionButton: ValueListenableBuilder(
                    builder: (context, value, child) {
                      return isFirstPage.value == true
                          ? FloatingActionButton(
                        backgroundColor: Appcolor().colorOrange,
                        heroTag: "mainpage",
                        onPressed: () {
                          print("valueee ${value}");
                          print("press");

                          showDialogtoAdd_MainPage(ontap: (val) {
                            Get.back();
                            if (val == 1) {
                              isFirstPage.value = false;
                              mainRoot = [];
                              fragNav?.screenList[pageKeys[currentIndex.value]] = Posit(
                                  key: pageKeys[currentIndex.value],
                                  title: "Properties ${currentIndex.value}",
                                  fragment: SecondScreen(
                                    fragNav: fragNav,
                                    values: mainRoot,
                                  ));
                              fragNav?.putPosit(
                                key: pageKeys[currentIndex.value],
                              );
                              currentIndex.value++;
                              print(mainRoot);
                            } else {
                              isFirstPage.value = false;
                              mainRoot = {};
                              fragNav?.screenList[pageKeys[currentIndex.value]] = Posit(
                                  key: pageKeys[currentIndex.value],
                                  title: "Properties ${currentIndex.value}",
                                  fragment: SecondScreen(
                                    fragNav: fragNav,
                                    values: mainRoot,
                                  ));
                              fragNav?.putPosit(
                                key: pageKeys[currentIndex.value],
                              );
                              print(mainRoot);
                              currentIndex.value++;
                            }
                          });
                        },
                        child: Icon(
                          Icons.add,
                          color: Appcolor().colorWhite,
                        ),
                      )
                          : Container();
                    },
                    valueListenable: currentIndex,
                  ),
                  body: ScreenNavigate(
                    child: s.data!.fragment,
                    control: fragNav!,
                  ),
                ));
          }
          return Container();
        });
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test_fragment/Routes/Routes.dart';
import 'package:test_fragment/Screens/MainScreens/SecondPage.dart';
import 'package:test_fragment/config/Const.dart';
import 'package:test_fragment/config/Mystrings.dart';
import 'package:test_fragment/config/Utils.dart';
import 'package:test_fragment/config/colors.dart';
import 'package:test_fragment/elements/CustomiseListTile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ShowDrawer extends StatefulWidget {
  final FragNavigate fragNav;

  ShowDrawer(this.fragNav, {Key? key}) : super(key: key);

  @override
  State<ShowDrawer> createState() => _ShowDrawerState();
}

class _ShowDrawerState extends State<ShowDrawer> {

  String BaseURL = "https://play.google.com/store/apps/details?id=";
  String packageName = "";


  getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      packageName = packageInfo.packageName;
      print("getPackageName: $packageName");
    });

  }

  @override
  void initState() {
    showFab.value = true;
    getPackageName();
    super.initState();
  }
  // void initState() {
  //   setState(() {
  //     widget.showFab = true;
  //     currentIndex.value = 0;
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: true,
      child: Container(
        width: 80.w,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 20.h,
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Appcolor().maincolor,
                    // image: DecorationImage(
                    //     image: AssetImage("assets/json.png"),
                    //     fit: BoxFit.fill
                    // ),
                  ),
                  child: Container(
                    width: 100.w,
                    child: Image.asset("assets/drawer_image2.png",fit: BoxFit.cover,)
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              InkWell(
                onTap: () {
                  // currentIndex.value = 0;
                  // print("before: ${currentIndex.value}");
                  // widget.fragNav.screenList[pageKeys[currentIndex.value]] = Posit(
                  //     key: pageKeys[currentIndex.value],
                  //     title: "Properties ${currentIndex.value}",
                  //     fragment: SecondScreen(
                  //       fragNav: widget.fragNav,
                  //       values: mainRoot,
                  //       showFab: widget.showFab,
                  //     ));
                  // widget.fragNav
                  //     .putPosit(
                  //       key: pageKeys[currentIndex.value],
                  //     )
                  //     .then((value) => currentIndex.value = 1);
                  Get.back();
                  showDialogtoAdd_MainPage(ontap: (val) async {
                    Get.back();
                    Get.back();
                    path_forsave.value = "";
                    if (val == 1) {
                      isFirstPage.value = false;
                      print("1: ${currentIndex.value}");

                      queue.clear();
                      if (mainRoot != null) {
                        mainRoot.clear();
                      }
                      mainRoot = [];
                      widget.fragNav.screenList[pageKeys[currentIndex.value]] = await Posit(
                          key: pageKeys[currentIndex.value],
                          title: "Properties ${currentIndex.value}",
                          fragment: SecondScreen(
                            fragNav: widget.fragNav,
                            values: mainRoot,

                          ));
                      widget.fragNav
                          .putPosit(
                            key: pageKeys[currentIndex.value],
                          )
                          .then((value) => storedIndex.value = currentIndex.value);
                      if (currentIndex.value == 1) {
                        currentIndex.value++;
                        count.value =1;
                      }
                      catchPathAfterSave.value = "";
                      print("after: ${currentIndex.value}");
                    } else {
                      isFirstPage.value = false;
                      queue.clear();
                      if (mainRoot != null) {
                        mainRoot.clear();
                      }
                      mainRoot = {};
                      print("before: ${currentIndex.value}");
                      widget.fragNav.screenList[pageKeys[currentIndex.value]] = await Posit(
                          key: pageKeys[currentIndex.value],
                          title: "Properties ${currentIndex.value}",
                          fragment: SecondScreen(
                            fragNav: widget.fragNav,
                            values: mainRoot,
                          ));
                      widget.fragNav
                          .putPosit(
                            key: pageKeys[currentIndex.value],
                          )
                          .then((value) => storedIndex.value = currentIndex.value);
                      if (currentIndex.value == 1) {
                        currentIndex.value++;
                        count.value =1;

                      }
                      catchPathAfterSave.value = "";
                      print("after: ${currentIndex.value}");
                    }
                  });
                },
                child: CustomListtile(
                  title: Mystrings.new_jsonfile,
                  image: "assets/openjson.png",
                  isdense: true,
                  visualDense: true,
                ),
              ),
              InkWell(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path!);

                    print("file1 : ${result.files.single.path!}");
                    print("result: ${result}");
                    path_forsave.value = file.path;
                    String data = await file.readAsString();

                    var json = jsonDecode(data);
                    // print("json ${json}");
                    // print(prettyJson(json));
                    if (mainRoot != null) {
                      mainRoot = null;
                    }
                    if (queue.isNotEmpty) {
                      queue.clear();
                    }
                    mainRoot = json;
                    Get.back();
                    // print(mainRoot);
                    print("check1: ${currentIndex.value}");
                    isFirstPage.value = false;

                    print("check after condition: ${currentIndex.value}");
                    // print("check2: ${currentIndex.value}");
                    widget.fragNav.screenList[pageKeys[currentIndex.value]] = Posit(
                        key: pageKeys[currentIndex.value],
                        title: "Properties ${currentIndex.value}",
                        fragment: SecondScreen(
                          fragNav: widget.fragNav,
                          values: mainRoot,
                        ));
                    widget.fragNav
                        .putPosit(
                          key: pageKeys[currentIndex.value],
                        )
                        .then((value) => storedIndex.value = currentIndex.value);
                    if (currentIndex.value == 1) {
                      currentIndex.value++;
                      count.value = 1;
                    }
                    print("check2: ${currentIndex.value}");
                    catchPathAfterSave.value = "";
                    // Get.to(()=>ViewText(json: json,));

                  } else {
                    // User canceled the picker
                  }
                },
                child: CustomListtile(
                  title: Mystrings.open_jsonfile,
                  image: "assets/OpenFile.png",
                  isdense: true,
                  visualDense: true,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  showDialogtoOpenUrl(context, widget.fragNav);
                },
                child: CustomListtile(
                  title: Mystrings.open_jsonurl,
                  image: "assets/URL.png",
                  isdense: true,
                  visualDense: true,
                ),
              ),
              GestureDetector(
                onTap: () async {

                  try {
                    String json = await getName_Dialog_for_GetjsonText(context, "Paste you Json");

                    if(!json.substring(0,1).contains("[") && !json.substring(0,1).contains("{")){
                      showToastSnack(Mystrings.invalid_json);
                    } else {


                    var json2 = jsonDecode(json);
                    print("222: ${prettyJson(json2)}");

                    if (mainRoot != null) {
                      mainRoot.clear();
                    }
                    if (queue.isNotEmpty) {
                      queue.clear();
                    }

                    isFirstPage.value = false;
                    Get.back();
                    mainRoot = json2;
                    path_forsave.value = "";

                      widget.fragNav.screenList[pageKeys[currentIndex.value]] = Posit(
                          key: pageKeys[currentIndex.value],
                          title: "Properties ${currentIndex.value}",
                          fragment: SecondScreen(
                            fragNav: widget.fragNav,
                            values: mainRoot,
                          ));
                      widget.fragNav
                          .putPosit(
                        key: pageKeys[currentIndex.value],
                      )
                          .then((value) => storedIndex.value = currentIndex.value);
                    catchPathAfterSave.value = "";
                      if (currentIndex.value == 1) {
                        currentIndex.value++;
                        count.value =1;
                      }
                    }
                  } catch (e) {
                    showToastSnack(Mystrings.invalid_json);
                    print(e);
                  }
                },
                behavior: HitTestBehavior.deferToChild,
                child: CustomListtile(
                  title: Mystrings.open_jsontext,
                  image: "assets/open_jsontext.png",
                  isdense: true,
                  visualDense: true,
                ),
              ),
              Divider(
                color: Appcolor().colorGrey,
              ),
              InkWell(
                onTap: () {
                  print("share: ${BaseURL + packageName}");
                  launch(BaseURL + packageName);
                },
                child: CustomListtile(
                  title: Mystrings.rate,
                  image: "assets/Rate.png",
                  isdense: true,
                  visualDense: true,
                ),
              ),
              InkWell(
                onTap: ()=>Share.share(Mystrings.sharetext + BaseURL + packageName, subject: 'Check out Quick JSON Editor:'),
                child: CustomListtile(
                  title: Mystrings.share,
                  image: "assets/Share.png",
                  isdense: true,
                  visualDense: true,
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.SettingPage),
                child: CustomListtile(
                  title: Mystrings.setting,
                  image: "assets/Settings.png",
                  isdense: true,
                  visualDense: true,
                ),
              ),
              InkWell(
                onTap: () => launch("https://www.w3schools.com/js/js_json_intro.asp"),
                child: CustomListtile(
                  title: Mystrings.what_isjson,
                  image: "assets/whatisjson.png",
                  isdense: true,
                  visualDense: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

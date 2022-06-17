import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fragment/Controller/SecondPage_Controller.dart';
import 'package:test_fragment/Routes/Screens.dart';
import 'package:test_fragment/Screens/MainScreens/HomeScreen.dart';
import 'package:test_fragment/Screens/MainScreens/SecondPage.dart';
import 'package:test_fragment/config/Const.dart';
import 'package:test_fragment/config/colors.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  static const platformm = const MethodChannel('tinyappsteam.flutter.dev/open_file');
  String openFileUrl = "";

  List<SharedMediaFile>? sharedFiles;

  @override
  void initState() {
   // getOpenFileUrl();


    var status =  Permission.storage.status.then((value) async{
    if (value.isDenied) {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
          Permission.camera,
    ].request();
    print(statuses[Permission.storage]); // it should print PermissionStatus.granted
    }});
    WidgetsBinding.instance!.addObserver(this);
    setDatainPref();

    // ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
    //   setState(() {
    //     sharedFiles = value;
    //     // _sharedText = value.first.path;
    //     print("-------PATh!!!!!: ${sharedFiles?.length}");
    //     //  print("PATh!!!!!: ${sharedFiles?.first.path}");
    //   });
    // }, onError: (err) {
    //   print("getLinkStream error: $err");
    // });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  setDatainPref() async {
   setPrefBool("isLoggedIn", true);
   var a;
 await getPrefBool("isLoggedIn").then((value) =>  a = value);
    print("check Preferances: ${a}");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
    //  getOpenFileUrl();
    }
    if (state == AppLifecycleState.detached) {
      if (Platform.isAndroid)
        SystemNavigator.pop();
      else
        exit(0);
    }
    print('Current state = $state');
  }
  //
  // void getOpenFileUrl() async {
  //   dynamic url = await platformm.invokeMethod("getOpenFileUrl");
  //   print("getOpenFileUrl");
  //   if (url != null && url != openFileUrl) {
  //     setState(() {
  //       openFileUrl = url;
  //       print("PPPPPAAAATHHHHHH $openFileUrl");
  //       pathFromFileManager.value = openFileUrl;
  //     });
  //     if (openFileUrl.isNotEmpty) {
  //       String newstr = pathFromFileManager.value.replaceAll("/external_files", "/storage/emulated/0");
  //       File file = File(newstr);
  //       print("check1: ${file.path}");
  //
  //       String data = await file.readAsString();
  //
  //       var json = jsonDecode(data);
  //       print("check2: ${json}");
  //
  //       // print("json ${json}");
  //       // print(prettyJson(json));
  //       if (mainRoot != null) {
  //         mainRoot.clear();
  //       }
  //       if (queue.isNotEmpty) {
  //         queue.clear();
  //       }
  //       mainRoot = json;
  //
  //       isFirstPage.value = false;
  //       isFileIntent.value = true;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick JSON Editor',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: SecondPage(),
      color: Appcolor().colorOrange,
      getPages: AppScreens.screens,
    );
  }
}

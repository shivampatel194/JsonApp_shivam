import 'dart:convert';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test_fragment/Screens/MainScreens/SecondPage.dart';
import 'package:test_fragment/config/Const.dart';
import 'package:test_fragment/config/Utils.dart';
import 'package:test_fragment/config/colors.dart';
import 'package:test_fragment/elements/ContentText.dart';

class SecondpageController extends GetxController {
  var args;
  int DatatoAdd = 0;
  int DatatoAdd_MainPage = 0;
  String savefile_path = "";
  String directorypath = "";
  String? selected_Val;
  RxBool share_intend = false.obs;
  RxBool share_sort = false.obs;
  RxBool save_intend = false.obs;
  RxBool save_sort = false.obs;

  @override
  void onInit() async {
    var pathnew = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);
    directorypath = pathnew;
    print("DatatoAdd_MainPage ${DatatoAdd_MainPage}");

    super.onInit();
  }

  Future<bool> savefile(String savename, int indent) async {


      if(await Permission.manageExternalStorage.status.isDenied || await Permission.accessMediaLocation.status.isDenied){
        await Permission.manageExternalStorage.request();
        await Permission.accessMediaLocation.request();
      }


    Directory directory;
    Directory directory2;
    String newPath = "";
    savefile_path = (await getExternalStorageDirectory())!.path;

   // try {
      if (Platform.isAndroid) {
        if (await requestpermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
         // print(directory);

          List<String> paths = directory.path.split("/");

          // for (int x = 1; x < paths.length; x++) {
          //   String folder = paths[x];
          //   if (folder != "Android") {
          //     newPath += "/" + folder;
          //   } else {
          //     break;
          //   }
          // }

          var pathnew = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);
            //  print(pathnew);


          newPath = pathnew;
          directory2 = Directory(newPath);

          print("INTERNAL PATH: ${directory2.path}");
          if (! await directory2.exists()) {
          //  await directory2.create(recursive: true);
             final File file =  File(directory2.path + "/${savename}.json");
             // your logic for saving the file.
             await file.writeAsString(prettyJson(mainRoot, indent: indent));
             showToastSnack("File saved!");
          }
          if (await directory2.exists()) {
            final File file = File(directory2.path + "/${savename}.json");
            // your logic for saving the file.
           await file.writeAsString(prettyJson(mainRoot, indent: indent));
            showToastSnack("File saved!");
            catchPathAfterSave.value = savename;
          }
        } else {
          return false;
        }
      }
    // } catch (e) {
    //   print(e.toString());
    // }
    return false;
  }

  goToPath(FragNavigate fragNav, bool showFab) async {
    print("x-x-x-x-x-x-x-x-x");
    if (pathFromFileManager.value.isNotEmpty) {
      String newstr = pathFromFileManager.value.replaceAll("/external_files", "/storage/emulated/0").replaceAll("file:///", "").replaceAll("/1/", "/");

      File file = File(newstr);
      print("check1: ${file.path}");
      path_forsave.value = file.path;
      print(path_forsave.value);

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

      fragNav.screenList[pageKeys[currentIndex.value]] = Posit(
          key: pageKeys[currentIndex.value],
          title: "Properties ${currentIndex.value}",
          fragment: SecondScreen(

            fragNav: fragNav,
            values: mainRoot,
          ));
      fragNav.putPosit(
        key: pageKeys[currentIndex.value],
      );
      if (currentIndex.value == 1) {
        currentIndex.value++;
      }
      print("after: ${currentIndex.value}");
    }
  }

  Future<bool> sharefile({int indent = 0}) async {
    savefile_path = (await getExternalStorageDirectory())!.path;

    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await requestpermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          print(directory.path);
          savefile_path = directory.path;
          String filePath = '${directory.path}/${DateTime.now().toString().removeAllWhitespace.replaceAll("-", "").replaceAll(".", "").replaceAll(":", "")}.json';
          File file = File(filePath);
          file.writeAsString(prettyJson(mainRoot, indent: indent));
          await Share.shareFiles([filePath]);
        } else {
          return false;
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<bool> requestpermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  SetData_From_Mainpage() {
    if (DatatoAdd_MainPage == 1) {
      mainRoot = [];
      print("root ${mainRoot.runtimeType}");
    }
    if (DatatoAdd_MainPage == 2) {
      // mainRoot = {};
      print("root ${mainRoot.runtimeType}");
    }
    update();
  }

  void handleClick_forList(var item, SecondpageController secondPageController, int index) {
    switch (item) {
      case 0:
        print(index);
        if (mainRoot.runtimeType == List<dynamic>) {
          mainRoot.removeAt(index);
          print("mainroot after removed: ${mainRoot}");
        } else {
          print("its map Del");
          mainRoot.remove("sss");
          print("root ${mainRoot}");
        }

        break;
      case 2:
    }
    secondPageController.update();
  }
}

import 'dart:collection';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

double textSize =  2.3.h ;
double textSize_appbar =  2.2.h ;

var parentList;

var mainRoot;
var temp_mainRoot = [];
var temp_mainRoot_Map = {};
List pageKeys = List.generate(1000, (index) => "Key${index}");
ValueNotifier<int> currentIndex = ValueNotifier(1);
ValueNotifier<int> count = ValueNotifier(1);
ValueNotifier<int> storedIndex = ValueNotifier(2);
ValueNotifier<bool> isFirstPage = ValueNotifier(true);
ValueNotifier<bool> showFab = ValueNotifier(true);
ValueNotifier<bool> isHideFab = ValueNotifier(false);
ValueNotifier<bool> isFileIntent = ValueNotifier(false);
ValueNotifier<bool> isshowExitBox = ValueNotifier(false);
ValueNotifier<String> pathFromFileManager = ValueNotifier("");
ValueNotifier<String> path_forsave = ValueNotifier("");
ValueNotifier<String> catchPathAfterSave = ValueNotifier("");

 SharedPreferences? prefs;

setPref() async {
  prefs = await SharedPreferences.getInstance();
}

 Future setPrefBool(String key, bool value) async {
if (prefs == null) await setPref();
prefs!.setBool(key, value);
}

 Future<bool> getPrefBool(String key) async {
if (prefs == null) await setPref();
return prefs!.getBool(key) ?? false;
}

Future<bool> getPrefBool_forexit(String key) async {
if (prefs == null) await setPref();
return prefs!.getBool(key) ?? true;
}



enum All { Text, Number, Boolean }
enum All_forList { Text, Number, Boolean }
enum TF { True, False }
enum TF_forList { True, False }
final queue = ListQueue<String>();





extension SizeExt on num {

  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double get h => /*this * Get.width >= 600 ? this * Get.height / 130 :*/ this * Get.height / 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w -> will take 20% of the screen's width
  double get w => /*this * Get.width >= 600 ? this * Get.width / 130 : */this * Get.width / 100;

}
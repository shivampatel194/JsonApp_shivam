import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:test_fragment/Routes/Routes.dart';
import 'package:test_fragment/Screens/MainScreens/HomeScreen.dart';
import 'package:test_fragment/Screens/MainScreens/SecondPage.dart';
import 'package:test_fragment/Screens/SettingPage/SettingPage.dart';

class AppScreens {
  static final screens = [
    // GetPage(name: Routes.HomePage, page: () => HomePage()),
    GetPage(name: Routes.SecondPage, page: () => SecondPage()),
    GetPage(name: Routes.SettingPage, page: () => SettingPage()),
  ];
}
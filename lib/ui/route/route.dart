

import 'package:get/get.dart';

import '../views/auth/sign_in_signup.dart';
import '../views/main_home_page.dart';
import '../views/splash_screen.dart';

const String splash = '/splash-screen';
const String homeScreen = '/home-screen';
const String loginScreen = '/login-screen';

List<GetPage> getPages = [
  GetPage(
      name: splash,
      page: () => SplashScreen()
  ),
  GetPage(
      name: homeScreen,
      page: () => HomePage()
  ),
  GetPage(
      name: loginScreen,
      page: () => LoginSignup()
  ),
];
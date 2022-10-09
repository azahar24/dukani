

import 'package:dukani/ui/route/views/auth/widgets/main_home_page.dart';
import 'package:dukani/ui/route/views/auth/widgets/sign_in_signup.dart';
import 'package:get/get.dart';

import 'views/auth/widgets/splash_screen.dart';

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
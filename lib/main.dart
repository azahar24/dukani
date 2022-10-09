import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'const/app_strings.dart';
import 'ui/route/route.dart';
import 'ui/route/views/auth/widgets/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp( App());
}

class App extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    name: "Dukani",
    options: FirebaseOptions(
        apiKey: "AIzaSyAWnxFPMMS853d1cSc_ubrbIjLktfrNeTo",
        appId: "1:603436519278:android:d70fd4074bf01f2cf53b7f",
        messagingSenderId: "603436519278",
        projectId: "dukani-67391"),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.connectionState == ConnectionState.done){
            return MyApp();
          }
          return CircularProgressIndicator();
        }
    );
  }
}


class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    

    return ScreenUtilInit(
      designSize: Size(428, 926),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppString.appName,
          //translations: AppLanguages(),
          //locale: Locale('en', 'US'),
          //fallbackLocale: Locale('en', 'US'),
          //theme: AppTheme().lightTheme(context),
          //darkTheme: AppTheme().darkTheme(context),
          //themeMode: ThemeMode.light,
          initialRoute: splash,
          getPages: getPages,
          home: SplashScreen(),
        );
      },
    );
  }
}

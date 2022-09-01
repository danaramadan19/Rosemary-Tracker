import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/appPages/diary.dart';
import 'package:untitled/appPages/post.dart';
import 'package:untitled/appPages/recomand.dart';
import 'package:untitled/appPages/tabbar.dart';
import 'package:untitled/appPages/taskpage.dart';
import 'package:untitled/conponantapi/addnote.dart';
import 'package:untitled/conponantapi/edit.dart';
import 'package:untitled/mood/models/moodcard.dart';
import 'package:untitled/mood/screens/chart.dart';
import 'package:untitled/mood/screens/homepage.dart';
import 'package:untitled/mood/screens/start.dart';
import 'package:untitled/pages/intro_page.dart';
import 'package:untitled/pages/loginSignup.dart';
import 'package:untitled/pages/nave.dart';
import 'package:untitled/pages/splash.dart';
import 'package:untitled/services/notification_services.dart';
import 'package:untitled/ui/pages/home_page.dart';
import 'package:untitled/ui/pages/notification_screen.dart';
import 'package:untitled/view/home_page.dart';

import 'dart:async';
import 'db/db_helper.dart';
import 'ui/widgets/colors.dart';

SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
//NotifyHelper().initializationNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is  the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    return ChangeNotifierProvider.value(
        value: MoodCard(),
        child: GetMaterialApp(
            title: 'Rosemary Tracker',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.lightGreen,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.poppinsTextTheme(),
              //backgroundColor: Colors.lightGreen
            ),
          initialRoute: sharedPref.getString("id") == null ? "/" : "splash",
            routes: {
              "/": (context) => SplashScreen(),
              "splash": (context) => Splash(),
              "login": (context) => LoginSignupScreen(),
              "home": (context) => Curved(),
              "addpost": (context) => AddPosts(),
              "editpost": (context) => EditPosts(),
              '/home_screen':(ctx)=>HomeScreen(),
              '/chart':(ctx)=> MoodChart(),
              '/start':(ctx)=> StartPage(),
            }

        //   home: Curved(),
            ));
  }
}

//const HomeToDoPage()
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => IntroPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.asset(
              'img/logo.png',
              height: 500,
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

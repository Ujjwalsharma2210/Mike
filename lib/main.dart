import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mike/login/SignInPage.dart';
import 'package:mike/login/SignUpPage.dart';
import 'package:mike/pages/HomePage.dart';
import 'package:mike/pages/SearchPage.dart';

import 'menuItems/RecordPage.dart';
import 'menuItems/SettingsPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.grey[900],
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
      ),
      routes: {
        "/": (context) => const SignInPage(),
        "SignUpPage": (context) => const SignUpPage(),
        "SignInPage": (context) => const SignInPage(),
        "HomePage": (context) => const HomePage(),
        "RecordPage": (context) => const RecordPage(),
        "SettingsPage": (context) => const SettingsPage(),
        "SearchPage": ((context) => const SearchPage()),
      },
    );
  }
}

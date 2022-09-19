import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mike/pages/MyRecordingsPage.dart';
import 'package:mike/pages/NearbyRecordingsPage.dart';
import 'package:mike/pages/MessagesPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // username IS ACTUALLY EMAIL
  String? username = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FirebaseAuth.instance.signOut();
        Navigator.popUntil(context, ModalRoute.withName("SignInPage"));
        return true;
      },
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  const Text(
                    "Mike",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    username!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),

            actions: [
              // SEARCH ICON IN APPBAR
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 15),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.pushNamed(context, "SearchPage");
                  },
                ),
              ),
              PopupMenuButton(
                padding: const EdgeInsets.only(top: 5),
                iconSize: 28,
                icon: const Icon(Icons.menu),
                elevation: 10,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Say on mike"),
                  ),
                  const PopupMenuItem(
                    value: 2,
                    child: Text("Settings"),
                  ),
                  const PopupMenuItem(
                    value: 3,
                    child: Text("Logout"),
                  ),
                ],
                onSelected: (selected) {
                  if (selected == 1) {
                    Navigator.pushNamed(context, "RecordPage");
                  } else if (selected == 2) {
                    Navigator.pushNamed(context, "SettingsPage");
                  } else if (selected == 3) {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "SignInPage", (route) => false);
                    });
                  }
                },
              ),
            ],

            // title: const Text("Mike"),

            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.mic,
                  ),
                  text: "you",
                ),
                Tab(
                  icon: Icon(Icons.radar_rounded),
                  text: "nearby",
                ),
                Tab(
                  icon: Icon(Icons.message),
                  text: "chats",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              MyRecordingsPage(),
              NearbyRecordingsPage(),
              MessagesPage(),
            ],
          ),
        ),
      ),
    );
  }
}

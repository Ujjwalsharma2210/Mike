import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mike/api/DatabaseController.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchTextEditingController =
      new TextEditingController();

  DatabaseController databaseController = new DatabaseController();
  late QuerySnapshot searchSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if (searchTextEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
    }

    // setState(() {
    //   searchSnapshot = databaseController
    //       .getUserByUsername(searchTextEditingController.text);
    // });
    searchSnapshot =
        await databaseController.searchByName(searchTextEditingController.text);
    print("$searchSnapshot");
    setState(() {
      isLoading = false;
      haveUserSearched = true;
    });
  }

  // createChatRoomAndStartConversation(String username) {
  //   List<String> users = [username, ];

  //   databaseController.addChatRoom(chatRoom, chatRoomId)
  // }

  Widget searchResultList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.docs.length,
            itemBuilder: (context, index) {
              return SearchItem(
                  username: searchSnapshot.docs[index].get("name"),
                  email: searchSnapshot.docs[index].get("email"));
            })
        : Container();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Mike",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade800,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: "search username",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            const Color(0x36FFFFFF),
                            const Color(0x0FFFFFFF)
                          ]),
                          borderRadius: BorderRadius.circular(40)),
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            searchResultList(),
          ],
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  // const SearchItem({Key? key}) : super(key: key);

  final String username;
  final String email;
  SearchItem({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(email),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: (() {}),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber.shade800,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text("Message"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

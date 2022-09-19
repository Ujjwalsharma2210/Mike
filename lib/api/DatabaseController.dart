import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseController {
  // getUserByUsername(String username) async {
  //   return await FirebaseFirestore.instance
  //       .collection("users")
  //       .where("name", isEqualTo: username)
  //       .get();
  // }

  Future<void> uploadUserdata(userInfoMap) async {
    FirebaseFirestore.instance
        .collection("users")
        .add(userInfoMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: searchField)
        .get();
  }

  addChatRoom(chatRoom, chatRoomId) async {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      return e;
    });
  }
}

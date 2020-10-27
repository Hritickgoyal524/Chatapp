import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseAuth{
  getuSerbyUserName(String userName) async {
   return await FirebaseFirestore.instance.collection("user").where("name",isEqualTo: userName).get();
  }
  getuSerbyemaile(String userEmail) async {
   return await FirebaseFirestore.instance.collection("user").where("email",isEqualTo: userEmail).get();
  }
  uploadUserName (usermap){
    FirebaseFirestore.instance.collection("user").add(usermap);
  }
  createChatRoom(String chatroomId ,chatMap)
  {
    FirebaseFirestore.instance.collection("Chatroom").doc(chatroomId).set(chatMap);
  }
  createchatroomapp(String chatroomId,chatroomMap){
    FirebaseFirestore.instance.collection('chatroom').doc(chatroomId).set(chatroomMap);
  }
  addConversationMessage(String chatroomId,messageMap) async {
    await FirebaseFirestore.instance.collection("Chatroom").doc(chatroomId).collection("chats").add(messageMap);
  }
  getConversationMessage(String chatroomId) async{
    return await FirebaseFirestore.instance.collection("Chatroom").doc(chatroomId).collection("chats").orderBy("time").snapshots();
  }
getChatroom(String username)async {
  return  FirebaseFirestore.instance.collection("Chatroom").where("users",arrayContains: username).snapshots();
}
}
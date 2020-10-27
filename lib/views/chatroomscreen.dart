

import 'package:chatapp/helper/Constants.dart';
import 'package:chatapp/helper/authenticate.dart';
import 'package:chatapp/helper/helperfunction.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chatconversationscreen.dart';
import 'package:chatapp/views/search.dart';
import 'package:flutter/material.dart';
class ChatRoom extends StatefulWidget
{
  _ChatRoomState createState()=>_ChatRoomState();
}
class _ChatRoomState extends State<ChatRoom>
{
  AuthMethods authMethods=new AuthMethods();
  DatabaseAuth databaseAuth=new DatabaseAuth();
  Stream chatroomStream;
  Widget chatroomList(){
return StreamBuilder(
  stream:chatroomStream,
  builder:(context,snapshot){
  return snapshot.hasData? ListView.builder(
    itemCount:snapshot.data.documents.length
  ,itemBuilder: (context,index){
    return ChatroomTile(snapshot.data.documents[index].data()['chatroomId']
    .toString().replaceAll("_", "").replaceAll(Constants.mystring,""),snapshot.data.documents[index].data()['chatroomId']);
  }):Container();
},);
  }
  void initState(){
    getusername();
    
    super.initState();
  }
  getusername() async{
    Constants.mystring=await Helperfunction.getUsernamesharedprefence();
    databaseAuth.getChatroom(Constants.mystring).then((value){
      setState(() {
        chatroomStream=value;
      });
    });
  }
  Widget build(BuildContext context)
  {
    return Scaffold(appBar: AppBar(
      title:Image.asset("assets/images/logo.png",
   height:50 ),actions: <Widget>[
    GestureDetector(
      onTap:(){
        authMethods.signOut();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate(),));
      },
      child: Container(padding:EdgeInsets.symmetric(horizontal:16),
       child:Icon(Icons.exit_to_app)))
   ],),
   body:chatroomList(),

   
   floatingActionButton: FloatingActionButton(
     child:Icon(Icons.search),
     onPressed:(){Navigator.push(context,MaterialPageRoute(
       builder:(context)=>Search()));
     }),);
}
}
class ChatroomTile extends StatelessWidget{
  final String  username;
  final String chatroomId;
ChatroomTile(this.username,this.chatroomId);
Widget build(BuildContext context){
  return GestureDetector(
    onTap:(){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Conversation(chatroomId:chatroomId)))
;    },
    child: Container(
      color:Colors.black26,
    padding: EdgeInsets.symmetric(vertical:24,horizontal:16),
    child:Row(children: <Widget>[
      Container(
        height: 40,
        alignment: Alignment.center,
        width: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),
        color:Colors.blue,),
        child:Text("${username.substring(0,1).toUpperCase()}",
        style: TextStyle(
          color:Colors.white,
          fontSize:17,
        fontWeight:FontWeight.w500
        ),)
      ),
      SizedBox(width:8),
      Text(username,  style: TextStyle(color:Colors.amber,  fontSize:17,
        fontWeight:FontWeight.w500
        ),)
    ],)
  ));
}
}
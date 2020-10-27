import 'package:chatapp/helper/Constants.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chatconversationscreen.dart';
//import 'package:chatapp/views/chatroomscreen.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Search extends StatefulWidget{
  _SearchState createState()=> _SearchState();

}
class _SearchState extends State<Search>{
TextEditingController searchTextEditingController=new TextEditingController();
DatabaseAuth databaseAuth=new DatabaseAuth();
QuerySnapshot snap;
initSearch(){
   databaseAuth.getuSerbyUserName(searchTextEditingController.text).then((val){
    
    setState(() {
      snap=val;
    }); 
   });
}
creatchatroomandstartconversation(String username){
  if(username!=Constants.mystring){
  String chatRoomId =getChatRoomId(username,Constants.mystring);
  List<String> user=[username,Constants.mystring];
  Map<String,dynamic> chatroomMap={
    "users":user,
    "chatroomId":chatRoomId
  };
  databaseAuth.createChatRoom(chatRoomId, chatroomMap);
  Navigator.push(context,MaterialPageRoute(builder:(context)=>Conversation(chatroomId: chatRoomId,) )
  );
}
else{
  print("Cant Show Yurself");
}

}
Widget searchtile({String userName, String userEmail}){
  return Container(
        padding: EdgeInsets.symmetric(horizontal:24,vertical:16),
        child:Row(children: <Widget>[
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
  Text(userName,style:TextStyle(fontSize: 19,color: Colors.white)),
  Text(userEmail,style:TextStyle(fontSize: 19,color: Colors.white)),
  ],

  ),  Spacer(),
  GestureDetector(
    onTap: () => creatchatroomandstartconversation(userName),
    child:Container(
     decoration:BoxDecoration(
       color:Colors.blue,
       borderRadius:BorderRadius.circular(30)
     ),
     padding:EdgeInsets.symmetric(horizontal:16,vertical:18),
     child:Text("Message",style: simpletextstyle(),)
   )
  )
        ],)
      );
    }

Widget searchList(){
  return snap !=null?ListView.builder(
    shrinkWrap: true,
    itemCount:snap.docs.length,
    itemBuilder: (context,index){
    return searchtile(
      userName:snap.docs[index].data()["name"],
      userEmail:snap.docs[index].data()["email"],
    );
  }):Container();
}
Widget build (BuildContext context){
return Scaffold(
appBar:AppBarMain(context),
body:Container(
  child:Column(
    children:[
      Container(
        padding: EdgeInsets.symmetric(horizontal:24,vertical:16),
        color:Color(0x54FFFFFF),
        child: Row(children: <Widget>[
        Expanded
        (child:TextField(
          controller: searchTextEditingController,
          style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText:"Username",
          hintStyle:TextStyle(color: Colors.white54)
          ,border: InputBorder.none
        ),)),
        GestureDetector(
          onTap: (){
          initSearch();
          },
          child:
       Container(
         height:40,
         width:40,
         padding: EdgeInsets.all(10),
         decoration: BoxDecoration(
           gradient:LinearGradient(
             colors:[
               Color(0x36FFFFFF),
               Color(0xBFFFFFFF)
             ],
            
           ),
            borderRadius:BorderRadius.circular(40)
            ),
         child:Image.asset('assets/images/search_white.png')))
      ],)),
      searchList()
    ]
  )
)

);
} 
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
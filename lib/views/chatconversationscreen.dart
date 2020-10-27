import 'package:chatapp/helper/Constants.dart';
import 'package:chatapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Conversation extends StatefulWidget{
  final String chatroomId;
  Conversation({this.chatroomId});
  _ConversationState createState ()=>_ConversationState();

}
class _ConversationState extends State<Conversation>{
  TextEditingController messageTextEditingController=new TextEditingController();
  DatabaseAuth databaseAuth=new DatabaseAuth();
 Stream <QuerySnapshot> chatmessageStream;
 Widget chatMessageList(){
 return StreamBuilder(stream:chatmessageStream,
   builder: (context,snapshot){
  return snapshot.hasData?ListView.builder(itemCount:snapshot.data.documents.length
  ,itemBuilder:(context,index){
    return MessageTile(snapshot.data.documents[index].data()["message"], snapshot.data.documents[index].data()["sendby"]==Constants.mystring,);
  }):Container(child:Text("wjfcbkwjfbckv"));
   }
 );
 }
 
  sendMessage(){
    if(messageTextEditingController.text.isNotEmpty){
     Map<String,dynamic> message={
    "message":messageTextEditingController.text,
    "sendby":Constants.mystring,
    'time':DateTime.now().millisecondsSinceEpoch
  };
     
      databaseAuth.addConversationMessage(widget.chatroomId,message);
      messageTextEditingController.text="";
  }}
  
  void initState(){
   databaseAuth.getConversationMessage(widget.chatroomId).then((value){
     setState(() {
chatmessageStream=value;
print(chatmessageStream);
      });
      
    });
   super.initState();
  }
    Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(),
    body:Container(child:
      Stack(
        children: <Widget>[
        chatMessageList(),
       // SizedBox(height:8),
       Container(),
        Container(
        alignment: Alignment.bottomCenter,
        child:
      Container(
        padding: EdgeInsets.symmetric(horizontal:24,vertical:16),
        color:Color(0x54FFFFFF),
        child: Row(children: <Widget>[
        Expanded
        (child:TextField(
          controller:messageTextEditingController,
          style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText:"Message",
          hintStyle:TextStyle(color: Colors.white54)
          ,border: InputBorder.none
        ),)),
        GestureDetector(
          onTap: (){
         sendMessage();
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
         child:Image.asset('assets/images/send.png')
         )
         )
      ],
      )
      ),
      )
    ]
        
      )));
   
}}
class MessageTile extends StatelessWidget{
final String message;
final bool isSendbyme;
MessageTile(this.message,this.isSendbyme);
Widget build (BuildContext context){
  return Container(
    margin: EdgeInsets.symmetric(vertical:7),
    padding:EdgeInsets.only(left:isSendbyme?0:24,right:isSendbyme?24:0),
    width:MediaQuery.of(context).size.width,
    alignment: isSendbyme?Alignment.centerRight:Alignment.centerLeft,
    
    child:Container(
      padding: EdgeInsets.symmetric(horizontal:24,vertical:16),
      decoration: BoxDecoration(
        gradient:LinearGradient(
          colors:isSendbyme ?[
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
        ]:[
           const Color(0x1AFFFFFF),
          const Color(0x1AFFFFFF)
        ]
        ) ,
        borderRadius:isSendbyme ?BorderRadius.only(
          topLeft:Radius.circular(23),
          topRight:Radius.circular(23),
          bottomLeft:Radius.circular(23)
           ):BorderRadius.only(
               topLeft:Radius.circular(23),
               topRight:Radius.circular(23),
               bottomRight:Radius.circular(23)
           )),
    child:Text(message,style:TextStyle(color:Colors.white,fontSize: 17,fontWeight: FontWeight.w600)),
  ));
}
}



//import 'package:chatapp/helper/authenticate.dart';
//import 'package:chatapp/views/SignUp.dart';
//import 'package:chatapp/views/SignUp.dart';
import 'package:chatapp/helper/helperfunction.dart';
import 'package:chatapp/views/chatconversationscreen.dart';
import 'package:chatapp/views/chatroomscreen.dart';
import 'package:firebase_core/firebase_core.dart';



import 'package:flutter/material.dart';

import 'helper/authenticate.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  _MyAppState createState()=>_MyAppState();
}
class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
 bool isuserloggedin;
  void initState(){
    getLoggedInfo();
    super.initState();
  }
  getLoggedInfo() async{
    await Helperfunction.getuserLoggingsharedprefence().then((value){
      setState(() {
      isuserloggedin=value;
      });
    }
     );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C93),
        scaffoldBackgroundColor: Color(0xff1F1F1f),
              primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:isuserloggedin != null ?  isuserloggedin ? ChatRoom() : Conversation()//Authenticate()
          : Container(
        child: Center(
          child: Authenticate(),
        ),
        ),
    );
}
}


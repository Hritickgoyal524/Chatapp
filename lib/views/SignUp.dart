import 'package:chatapp/helper/helperfunction.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chatroomscreen.dart';
//import 'package:chatapp/services/database.dart';
//import 'package:chatapp/views/chatroomscreen.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget
{  final Function toggle;
  SignUp({this.toggle});
   _SignUpState createState()=>_SignUpState();
   }
   
   class _SignUpState extends State<SignUp> {
     bool isloading=false;
     AuthMethods authMethods=new AuthMethods();
    DatabaseAuth databaseAuth=new DatabaseAuth();
     final formkey=GlobalKey<FormState>();
     TextEditingController usernameTexteditingcontroller=new TextEditingController();
     TextEditingController emailTexteditingcontroller=new TextEditingController();
     TextEditingController passwordTexteditingcontroller=new TextEditingController();
     signMeUp  () {
     if(formkey.currentState.validate())
     {
       Map<String,String> userMap={
         "name":usernameTexteditingcontroller.text,
        "email":emailTexteditingcontroller.text
      };
      Helperfunction.savedUsernamesharedprefence(usernameTexteditingcontroller.text);
      Helperfunction.savedUseremailsharedprefence(emailTexteditingcontroller.text);
  setState(() {
    isloading=true;
  });
   authMethods.signUpWithEmailAndPassword(emailTexteditingcontroller.text, passwordTexteditingcontroller.text).then((value) {
     print("$value");
     databaseAuth.uploadUserName(userMap);
     Helperfunction.saveduserLoggingsharedprefence(true);
     Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>ChatRoom()));
   });
}
   }
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBarMain(context),
         body:isloading?Container(
          child:Center(child:CircularProgressIndicator()))
        : SingleChildScrollView(
        child:Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
        child:Container(
         padding:EdgeInsets.symmetric(horizontal:26),
         child: 
          Column(
            mainAxisSize: MainAxisSize.min,
           children:[
             Form(
               key:formkey,
               child:
             Column(
           children: <Widget>[
             TextFormField(
               validator: (value){
                 return value.length<2||value.isEmpty?"Please probide a valid user name":null;
               },
                controller: usernameTexteditingcontroller,
               style: simpletextstyle(),
               decoration: textfieldinputdecoration("Username")
             ),
             TextFormField(
               validator:(value)
               {
                return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)?null:"Please provide a valid mail";
               },
               controller: emailTexteditingcontroller,
               style: simpletextstyle(),
               decoration: textfieldinputdecoration("email")
             ),
             TextFormField(
               obscureText: true,
               validator:(value) {
                 return value.length>6?null:"Please provide password 6+ character";
               },
               controller: passwordTexteditingcontroller,
               style: simpletextstyle(),
               decoration: textfieldinputdecoration("password")
             )])),
             SizedBox(height:17),
             Container(
               alignment: Alignment.centerRight,
               child:Container(
               padding: EdgeInsets.symmetric(horizontal:10,vertical:6),
               child: Text("Forgot Password",style:simpletextstyle(),),
             )),
          
             SizedBox(height: 17,),
             GestureDetector(
               onTap: (){
                 signMeUp();
               },
            child: Container(
               alignment: Alignment.center,
               width:MediaQuery.of(context).size.width,
               padding: EdgeInsets.symmetric(vertical:15,horizontal:30),
               decoration: BoxDecoration(
                 gradient: LinearGradient(colors: [
                    const Color(0xff007EF4),
                    const Color(0xff2A75BC)
                 ]
                 ),
                 borderRadius: BorderRadius.circular(30)
               ),
               child: Text("Sign Up",style:TextStyle(
               color:Colors.white,
               fontSize: 17

             ),)))
             
            , SizedBox(height:13,)
            ,Container(
               alignment: Alignment.center,
               width:MediaQuery.of(context).size.width,
               padding: EdgeInsets.symmetric(vertical:15,horizontal:30),
               decoration: BoxDecoration(
                 color: Colors.white,
                 
                 
                 borderRadius: BorderRadius.circular(30)
               ),
               child: Text("Sign Up with Google",style:TextStyle(
               color:Colors.black,
               fontSize: 17

             ),)),
             SizedBox(height: 12,),
             Row(mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Text("Already have account?",
                    style:TextStyle(
                   color:Colors.white,
                   fontSize: 17
                    )
                 ),
                 GestureDetector(onTap:(){
                  widget.toggle();
                 },
                   child :Container(
                   padding:EdgeInsets.symmetric(vertical:8),
                   child:Text("Sign In Now",style: TextStyle(
                   color:Colors.white,
                  fontSize: 17
                  ) )),)
               ],
             )
             ,SizedBox(height: 95,)],
          ),

          )

    )));
  }
         
       
     }
 
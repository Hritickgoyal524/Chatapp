import 'package:flutter/material.dart';
// ignore: non_constant_identifier_names
Widget AppBarMain(BuildContext context)
{
return AppBar(
  title:Image.asset("assets/images/logo.png",height: 60),
  
);
}
InputDecoration textfieldinputdecoration(String hinttext)
{
  return InputDecoration(
                 hintText: hinttext ,
                 hintStyle: TextStyle(
                   color:Colors.white54,
                 ),
                 focusedBorder: UnderlineInputBorder(
                      borderSide:BorderSide(color:Colors.white)
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:BorderSide(color: Colors.white)
                ) );
}
TextStyle simpletextstyle()
{
  return TextStyle(
    color:Colors.white,
    fontSize: 16
  );
}
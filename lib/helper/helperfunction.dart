import 'package:shared_preferences/shared_preferences.dart';
class Helperfunction{
  static String sharedpreferenceuserloggedinkey="ISLOGGEDIN";
  static String  sharedpreferenceusernamedkey="USERNAMEDKEY";
  static String  sharedpreferenceuseremailkey="USEREMAILKEY";

  static Future<void> saveduserLoggingsharedprefence(bool isuserlogin) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   return await _prefs.setBool(sharedpreferenceuserloggedinkey, isuserlogin);

  }
 static Future<void> savedUsernamesharedprefence(String username) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   return await _prefs.setString(sharedpreferenceusernamedkey, username);

  }
   static Future<void> savedUseremailsharedprefence(String useremail) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   return await _prefs.setString(sharedpreferenceuseremailkey, useremail);
 }

 static Future<bool> getuserLoggingsharedprefence() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   return  _prefs.getBool(sharedpreferenceuserloggedinkey);

}
 static Future<String> getUsernamesharedprefence() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   return  _prefs.getString(sharedpreferenceusernamedkey);

  }
  static Future<String>tUseremailsharedprefence(String useremail) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   return  _prefs.getString(sharedpreferenceuseremailkey);
 }

}
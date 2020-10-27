import 'package:chatapp/modal/myuser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
   final FirebaseAuth _auth=FirebaseAuth.instance;
     Myuser _userfirebaseuser(var user){
     return  user!=null ? Myuser(userId:user.uid):null;
   }
     Future signInWithEmailAndPassword(String email,String password) async {
        try{
            var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
            var  firebaseUser=result.user;
            return _userfirebaseuser(firebaseUser);
        }
        catch(e)
        {
        print(e.toString());
        }
  }
   Future signUpWithEmailAndPassword(String email,String password) async {
        try{
            var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
            var  firebaseUser=result.user;
            return _userfirebaseuser(firebaseUser);
        }
        catch(e)
        {
        print(e.toString());
        }
}
Future resetPass(String email )async
{
  try{
    return await _auth.sendPasswordResetEmail(email: email);

  }
  catch(e)
  {
    print(e.toString());
  }
}
Future signOut() async
{
  try{
   return await _auth.signOut();
  }catch(e){
 print(e.toString());
  }

}
}
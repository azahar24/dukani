import 'package:dukani/ui/route/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final box = GetStorage();

  Future signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential _userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    User? user = _userCredential.user;

    if (user!.uid.isNotEmpty) {
      Fluttertoast.showToast(msg: 'registration Successfull');
      box.write('uid', user.uid);
      Get.toNamed(homeScreen);
    } else {
      Fluttertoast.showToast(msg: 'somting rong');
    }
  }
}

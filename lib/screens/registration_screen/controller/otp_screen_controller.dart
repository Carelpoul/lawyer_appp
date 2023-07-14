import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/screens/Registration_screen/view/login_page_view.dart';
import 'package:untitled10/screens/Registration_screen/view/otp_screen_view.dart';
import 'package:untitled10/screens/Registration_screen/view/registration_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled10/utils/utils.dart';
import 'package:untitled10/widgets/loaderoverlay.dart';
FirebaseAuth _auth = FirebaseAuth.instance;

class OtpScreenController extends ChangeNotifier{
  TextEditingController mobileController = TextEditingController();
  String verificationID = "";
  String otpCode = "";
void onLoginClicked(context)async{
  LoadingOverlay.of(context).show();
  await _auth.verifyPhoneNumber(
      phoneNumber: "+91${mobileController.text}",
      verificationCompleted: (phoneAuthCredential) async {},
      verificationFailed: (verificationFailed) {
        },
      codeSent: (verificationID, resendingToken) async {

        LoginScreen.SHOW_OTP_FORM_WIDGET;
        this.verificationID = verificationID;
        print("okkkkkk code send");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPFieldView()));
        LoadingOverlay.of(context).hide();
      },
      codeAutoRetrievalTimeout: (verificationID) async {
        LoadingOverlay.of(context).hide();
      });

}

  void onOtpSubmitPressed(context) {
    onCodeVerification(context);
  }
  void onOtpEntered(value) {
    otpCode = value;
    notifyListeners();
  }

  Future<void> onCodeVerification(context) async {
    AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpCode);
    signInWithPhoneAuthCred(phoneAuthCredential, context);
  }

  void signInWithPhoneAuthCred(
      AuthCredential phoneAuthCredential, context) async {
    try {
      LoadingOverlay.of(context).show();
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);
      if (authCred.user != null) {
        SharedPreferences pref =await SharedPreferences.getInstance();
        pref.setString("status","otpVerified");
        pref.setString("phone",mobileController.text);
        LoadingOverlay.of(context).hide();

        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>RegistrationFormView()));
      } else {
        LoadingOverlay.of(context).hide();
     Utils.showPrimarySnackbar(context,"Invalid Otp",type: SnackType.error);
      }
    } on FirebaseAuthException catch (e) {
      LoadingOverlay.of(context).hide();
      Utils.showPrimarySnackbar(context,"The verification code from SMS/TOTP is invalid. Please check and enter the correct verification code again.",type: SnackType.error);
      // print("888");
      // showOtpErrorMsg();
      // print("888");
      // Utils.showPrimarySnackbar(context, "e.message", type: SnackType.error);
    }
  }

}
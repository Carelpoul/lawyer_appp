import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:untitled10/screens/Registration_screen/controller/otp_screen_controller.dart';
import 'package:untitled10/screens/Registration_screen/view/registration_page_view.dart';
import 'package:untitled10/screens/home_screen/view/home_screen_view.dart';
import 'package:provider/provider.dart';
class OTPFieldView extends StatelessWidget {
  const OTPFieldView({super.key});

  @override
  Widget build(BuildContext context) {
    final watch=context.watch<OtpScreenController>();
    final read=context.watch<OtpScreenController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF8A2387),
        elevation: 0,
        leading: IconButton(
          onPressed: (){
           Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white),
        ),
      ),
      backgroundColor:  Color(0xFF8A2387),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 100,
            ),
            Text("Verify Your OTP",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26),),
            SizedBox(
              height: 100,
            ),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 60,
              style: TextStyle(
                  fontSize: 17,
                color: Colors.white
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
                read.onOtpEntered(pin);
              },
            ),
            SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: (){
               read.onCodeVerification(context);
              },
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFE94057),
                            Color(0xFFF27121)
                          ]
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Verify",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}

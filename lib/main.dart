import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled10/screens/case_detail/controller/case_detail_controller.dart';
import 'package:untitled10/screens/quotation_list/controller/quotation_dtls_controller.dart';
import 'package:untitled10/screens/quotation_list/controller/quotation_list_controller.dart';
import 'package:untitled10/screens/Registration_screen/controller/otp_screen_controller.dart';
import 'package:untitled10/screens/Registration_screen/controller/registration_form_controller.dart';
import 'package:untitled10/screens/Registration_screen/view/login_page_view.dart';
import 'package:untitled10/screens/Registration_screen/view/registration_page_view.dart';
import 'package:untitled10/screens/create_quotation/view/create_quotation_view.dart';
import 'package:untitled10/screens/Registration_screen/view/registration_face_detection_camera.dart';
import 'package:untitled10/screens/home_screen/controller/home_screen_controller.dart';
import 'package:untitled10/screens/profile/controller/profile_controller.dart';
import 'package:untitled10/screens/request_case_detail/controller/case_request_details_controller.dart';
import 'package:untitled10/screens/splash_screen/splash_screen_view.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled10/widgets/loaderoverlay.dart';
List<CameraDescription> cameras = [];
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  cameras = await availableCameras();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => OtpScreenController()),
      ChangeNotifierProvider(create: (_) => RegistrationFormController()),
      ChangeNotifierProvider(create: (_) => HomeScreenController()),
      ChangeNotifierProvider(create: (_) => QuotationDetailsController()),
      ChangeNotifierProvider(create: (_) => QuotationListController()),
      ChangeNotifierProvider(create: (_) => MyProfileController()),
      ChangeNotifierProvider(create: (_) => RequestCaseDetailController()),
      ChangeNotifierProvider(create: (_) => CaseDetailController()),
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
   return Container(
       alignment: Alignment.center,
       child: Directionality(
       textDirection: TextDirection.ltr,
     child: LoadingOverlay(
       child: MaterialApp(
         theme: ThemeData(
           fontFamily:"dm_sans_regular"
         ),
        home: SplashScreenView(),
        debugShowCheckedModeBanner: false,// Set SplashScreen as the initial route
        ),
     ),
       ),
   );
    });
  }

}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/screens/Registration_screen/view/registration_face_detection_camera.dart';
import 'package:untitled10/screens/profile/controller/profile_controller.dart';
import 'package:untitled10/screens/profile/view/edit_profile_face_detection_camera.dart';
import 'package:untitled10/screens/profile/view/my_profile_view.dart';
import 'package:untitled10/widgets/textfield.dart';

class EditProfileView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final watch=context.watch<MyProfileController>();
    final read=context.read<MyProfileController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8A2387),
        elevation: 0,

        title: Text("Profile"),
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body:watch.isLoading?Center(
        child: CircularProgressIndicator(),
      ):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>EditProfileFaceDetectionCameraView(initialDirection: CameraLensDirection.front)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF8A2387),width: 2),
                      shape: BoxShape.circle
                  ),
                  child: ClipOval(
                    child:watch.profileImage.path==""? 
                    CachedNetworkImage(imageUrl: "http://117.200.73.2:7075/lawyer/public/${watch.lawyerData["lawyer_mastr_profile_pic"]}",
                      fit: BoxFit.contain,
                      width: 150.0,
                      height: 150.0,
                    ):Image.file(watch.profileImage, fit: BoxFit.contain,
                      width: 150.0,
                      height: 150.0,),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: PrimaryCTextFormField(
                controller: watch.nameController,
                onTap: (){},
                hintText: "Name",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: PrimaryCTextFormField(
                controller: watch.emailController,
                onTap: (){},
                hintText: "Email",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child:    TextFormField(
                controller: watch.addressController,
                decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:  Color(0xFF8A2387),
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:  Color(0xFF8A2387),
                        )
                    )
                ),
                maxLines: 5,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(),
              child: PrimaryCTextFormField(
                controller: watch.mobController,
                hintText: "Mobile No",
              )
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(),
              child:  PrimaryCTextFormField(
                controller: watch.dateOfBirthController,
                  hintText: "Date Of Birth",
                  readOnly: true,
                  onTap: () async {
                    var pickedDate = await showDatePicker(
                      builder: (BuildContext, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Color(0xff1767B1),
                              // <-- SEE HERE
                              onPrimary: Colors.white,
                              // <-- SEE HERE
                              onSurface: Colors.black, // <-- SEE HERE
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary: Color(
                                    0xff1767B1), // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1910),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      String date = DateFormat('dd-MM-yyy')
                          .format(pickedDate);
                      read.onDobSelected(date);
                    }
                  },
                  // controller: watch.dobController,
                  suffix: Container(
                    width: 15.h,
                    height: 17.w,
                    child: Center(
                        child: Icon(Icons.calendar_month,color:Color(0xFF8A2387),)
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: watch.aboutMeController,
              decoration: InputDecoration(
                  labelText: 'About Me',
                  border: OutlineInputBorder(
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  Color(0xFF8A2387),
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  Color(0xFF8A2387),
                      )
                  )
              ),
              maxLines: 5,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary:  Color(0xFF8A2387),),
              onPressed: () {
             read.uploadProfile(context);
              },
              child: Text('Save'),
            ),
            SizedBox(
              height: 30,
            )



          ],
        ),
      ),
    );
  }
}
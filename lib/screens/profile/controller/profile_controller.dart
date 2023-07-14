import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled10/network/endpoint.dart';
import 'package:untitled10/screens/profile/view/my_profile_view.dart';
import 'package:untitled10/utils/utils.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:untitled10/widgets/loaderoverlay.dart';
class MyProfileController extends ChangeNotifier {
  bool isLoading=true;
  File profileImage=File("");
  var lawyerData;
  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController addressController =TextEditingController();
  TextEditingController mobController =TextEditingController();
  TextEditingController dateOfBirthController =TextEditingController();
  TextEditingController aboutMeController =TextEditingController();
  showLoader(value){
    isLoading=value;
    notifyListeners();
  }
  Future<void> getProfileDetails(context)async{
    showLoader(true);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var response= await http.post(
      Uri.parse("${Endpoint.getLawyerDtls}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'token': '${pref.getString("token")}',
      }),
    );
    log(response.body);
    final result=jsonDecode(response.body);
    if(response.statusCode==200){
      lawyerData=result["DATA"];
      nameController.text=lawyerData["lawyer_mastr_name"];
      emailController.text=lawyerData["lawyer_mastr_email"];
      addressController.text=lawyerData["lawyer_mastr_address"];
      mobController.text=lawyerData["lawyer_mastr_phone1"];
      dateOfBirthController.text=lawyerData["lawyer_mastr_dob"];
      aboutMeController.text=lawyerData["lawyer_mastr_about_me"]??"";
      showLoader(false);
    }
    else{
      Utils.showPrimarySnackbar(context, "Something went wrong",type: SnackType.error);
    }
  }
  void onDobSelected(value){
    dateOfBirthController.text=value;
    notifyListeners();
  }


  Future<void >uploadProfile(context)async{

    print("hello");
    if(nameController.text==""){
      Utils.showPrimarySnackbar(context, "Enter name",
          type: SnackType.error);
      return;
    }

    if(emailController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Email Id",
          type: SnackType.error);
      return;
    }

    if(addressController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Address",
          type: SnackType.error);
      return;
    }
    if(dateOfBirthController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Date Of Birth",
          type: SnackType.error);
      return;
    }
    LoadingOverlay.of(context).show();
    SharedPreferences pref=await SharedPreferences.getInstance();
    print("0000");
    var response= await http.post(
      Uri.parse("${Endpoint.uploadLawyerProfile}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'token': '${pref.getString("token")}',
        'name':nameController.text,
        'email':emailController.text,
        'address':addressController.text,
        'phone':mobController.text,
        'dob':dateOfBirthController.text,
        'about_me':aboutMeController.text,
      }),
    );
    print(response.body);
    if(response.statusCode==200){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>MyProfileView()));
      Utils.showPrimarySnackbar(context, "Profile Updated Succesfully",
          type: SnackType.success);
      LoadingOverlay.of(context).hide();
    }
    else{
      LoadingOverlay.of(context).hide();
      Utils.showPrimarySnackbar(context, "Unable to update profile",
          type: SnackType.error);
    }
  }

  Future uploadImage(context,image) async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    var uri = Uri.parse("${Endpoint.uploadLawyerProfilePic}");
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.fields['token'] = '${pref.getString("token")}';
      List<http.MultipartFile> newList = <http.MultipartFile>[];
      File imageFile = image;
      print("image_path");
      print(imageFile.path);
      var stream = new http.ByteStream(
          DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = new http.MultipartFile(
          "profile", stream, length,
          filename: basename(imageFile.path));
      newList.add(multipartFile);
    request.files.addAll(newList);
      print("request_field");
    print(request.fields);
    print(request.files);
    print("request_files");
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    print("hhhhhhhhh");
    print(respStr);
    if (response.statusCode == 200) {
      profileImage=image;
      notifyListeners();
      Utils.showPrimarySnackbar(context, "Image Updated Sucessfully",
          type: SnackType.success);
    } else {
      Utils.showPrimarySnackbar(context, "Error on uploading",
          type: SnackType.error);
      return;
    }

  }

}
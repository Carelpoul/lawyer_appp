import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled10/network/endpoint.dart';
import 'package:untitled10/screens/Registration_screen/model/country_model.dart';
import 'package:untitled10/screens/Registration_screen/model/state_model.dart';
import 'package:untitled10/screens/Registration_screen/repository/registration_data_repo.dart';
import 'package:untitled10/screens/home_screen/view/home_screen_view.dart';
import 'package:untitled10/utils/utils.dart';
import 'package:untitled10/widgets/loaderoverlay.dart';

class RegistrationFormController extends ChangeNotifier{
  File profileImage=File("");
  File passportImage=File("");
  TextEditingController fullNameController=TextEditingController();
  TextEditingController emailIdController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController stateController=TextEditingController();
  TextEditingController zipCodeController=TextEditingController();
  TextEditingController countryController=TextEditingController();
  TextEditingController lawFirmController=TextEditingController();
  TextEditingController lawFirmAddressController=TextEditingController();
  TextEditingController barAssociationController=TextEditingController();
  TextEditingController yearsOfExperienceController=TextEditingController();
  TextEditingController educationController=TextEditingController();
  TextEditingController languageSpokenController=TextEditingController();
  TextEditingController aboutMeController=TextEditingController();
  TextEditingController streetController=TextEditingController();
  TextEditingController dobController=TextEditingController();

  List<CountryData>? countryList;
  List<StateData>? stateList;
  bool isLoading=true;
  String countryId="";
  String stateId="";
  String specialization="";
  bool isVerified=false;
  List selectedSpecializations = [];
  RegistrationDataRepo registrationDataRepo=RegistrationDataRepo();
  List<File> attachedFiles = [];
  List documentTitle=[];
  TextEditingController documentController=TextEditingController();
  String type="";



  Future<void> initState(context,image,imageFor)async{
    await getCountryList(context);
  notifyListeners();
  }

  Future<void> pickAndAttachFile(context) async {

    documentTitle.add(documentController.text);
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      attachedFiles.add(File(pickedFile.path));

    }
    notifyListeners();
    Navigator.pop(context);
  }

  void onDelete(index){
    attachedFiles.removeAt(index);
    documentTitle.removeAt(index);
    notifyListeners();
  }

  void beforeShowDialog(){
    documentController.clear();
    notifyListeners();
  }

  showLoader(value){
    isLoading=value;
    notifyListeners();
  }

  void onVerified(value){
    isVerified=value;
    notifyListeners();
  }

  void onSpecializationSelected(value){
    selectedSpecializations=value;
    print(selectedSpecializations);
    notifyListeners();
  }

  Future<void> getCountryList(context) async {
    showLoader(true);
    registrationDataRepo.getCountryList().then((response) {
      print(response.statusCode);
      print(response.body);
      final result = GetCountryListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");
        countryList = result.countryData;
        getStateList(context);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context,"No Country code",
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
          (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );

  }
  Future<void> getStateList(context) async {
    registrationDataRepo.getStateList().then((response) {
      print(response.statusCode);
      print(response.body);
      final result = GetStateListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");
        stateList = result.stateData;
        showLoader(false);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context,"No State Found",
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
          (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );

  }

  void onCountryselected(value){
    countryId=value;
    notifyListeners();
  }
  void openCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: double.infinity,
      preferredCameraDevice: CameraDevice.rear,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      passportImage = File(pickedFile.path);
    }

    notifyListeners();
  }

  void onDobSelected(value){
    dobController.text=value;
    notifyListeners();
  }


  void onStateselected(value){
stateId=value;
notifyListeners();
  }

  void onImageSelected(image,imageFor){
    print(image);
    if(imageFor=="profileImage"){
      profileImage=image;
    }
    if(imageFor=="passportImage"){
      passportImage=image;
    }
    notifyListeners();
  }

  void onTypeSelected(value){
    type=value;
    notifyListeners();
  }

  Future uploadImage(context) async {

    if(profileImage.path==""){
      Utils.showPrimarySnackbar(context, "Select Profile Image",
          type: SnackType.error);
      return;
    }
    if(passportImage.path==""){
      Utils.showPrimarySnackbar(context, "Select Passport Image",
          type: SnackType.error);
      return;
    }
    if(fullNameController.text==""){
      Utils.showPrimarySnackbar(context, "Enter name",
          type: SnackType.error);
      return;
    }
    if(addressController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Address",
          type: SnackType.error);
      return;
    }
    if(countryId==""){
      Utils.showPrimarySnackbar(context, "Select Country",
          type: SnackType.error);
      return;
    }if(stateId==""){
      Utils.showPrimarySnackbar(context, "Select State",
          type: SnackType.error);
      return;
    }if(cityController.text==""){
      Utils.showPrimarySnackbar(context, "Enter City",
          type: SnackType.error);
      return;
    }if(streetController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Street",
          type: SnackType.error);
      return;
    }
    if(zipCodeController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Zip Code",
          type: SnackType.error);
      return;
    } if(dobController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Date Of Birth",
          type: SnackType.error);
      return;
    }
    if(type==""){
      Utils.showPrimarySnackbar(context, "Select Type",
          type: SnackType.error);
      return;
    }

    if(lawFirmController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Law Firm Name",
          type: SnackType.error);
      return;
    } if(lawFirmAddressController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Law Firm Address",
          type: SnackType.error);
      return;
    } if(selectedSpecializations.isEmpty){
      Utils.showPrimarySnackbar(context, "Select Specialization",
          type: SnackType.error);
      return;
    } if(barAssociationController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Bar Association Membership Number",
          type: SnackType.error);
      return;
    } if(yearsOfExperienceController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Years Of Experience",
          type: SnackType.error);
      return;
    }
    if(educationController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Education",
          type: SnackType.error);
      return;
    }
    if(languageSpokenController.text==""){
      Utils.showPrimarySnackbar(context, "Enter Language Spoken",
          type: SnackType.error);
      return;
    }
    if(aboutMeController.text==""){
      Utils.showPrimarySnackbar(context, "Enter About Me",
          type: SnackType.error);
      return;
    }
    if(attachedFiles.isEmpty){
      Utils.showPrimarySnackbar(context, "No Documents Uploaded",
          type: SnackType.error);
      return;
    }
    if(!isVerified){
      Utils.showPrimarySnackbar(context, "Terms and Condition Not Agreed",
          type: SnackType.error);
      return;
    }

 LoadingOverlay.of(context).show();
    SharedPreferences pref=await SharedPreferences.getInstance();
     for(int i=0;i<selectedSpecializations.length;i++){
       specialization+=selectedSpecializations[i].toString()+",";
     }
    specialization=specialization.substring(0,specialization.length-1);
     print(specialization);
    var uri = Uri.parse("${Endpoint.registerUser}");
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.fields['name'] = fullNameController.text;
    request.fields['email'] = emailIdController.text;
    request.fields['address'] = addressController.text;
    request.fields['city'] = cityController.text;
    request.fields['state'] = stateId;
    request.fields['country'] = countryId;
    request.fields['phone'] = pref.getString("phone").toString();
    request.fields['street'] = streetController.text;
    request.fields['dob'] =dobController.text;
    request.fields['type'] =type;
    request.fields['postal'] = zipCodeController.text;
    request.fields['law_firm_name'] = lawFirmController.text;
    request.fields['law_firm_address'] = lawFirmAddressController.text;
    request.fields['specialization'] = specialization;
    request.fields['association_membership'] = barAssociationController.text;
    request.fields['experience'] = yearsOfExperienceController.text;
    request.fields['education'] = educationController.text;
    request.fields['languages_known'] = languageSpokenController.text;
    request.fields['about_me'] = aboutMeController.text;
    List<http.MultipartFile> newList = <http.MultipartFile>[];
    File imageFile1 = profileImage;
    var stream1 = new http.ByteStream(DelegatingStream.typed(imageFile1.openRead()));
    var length1 = await imageFile1.length();
    var multipartFile1 = new http.MultipartFile(
        "profile", stream1, length1,
        filename: basename(imageFile1.path));
    newList.add(multipartFile1);

    File imageFile2 = profileImage;
    var stream2 = new http.ByteStream(DelegatingStream.typed(imageFile2.openRead()));
    var length2 = await imageFile2.length();
    var multipartFile2 = new http.MultipartFile(
        "passport", stream2, length2,
        filename: basename(imageFile2.path));
    newList.add(multipartFile2);
    request.files.addAll(newList);
    print("9999999");
    print(request.fields);
    print(request.files);
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
      print(respStr);
      var a=jsonDecode(respStr);
      print(a);
      if (response.statusCode == 200) {
        pref.setString("token",a["TOKEN"]);
        print(pref.getString("token"));
        pref.setString("status", "registerCompleted");
        LoadingOverlay.of(context).hide();
  Navigator.push(context,MaterialPageRoute(builder: (context)=>Home_page()));
      } else {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, "Error on uploading",
            type: SnackType.error);
        return;
      }

  }

}
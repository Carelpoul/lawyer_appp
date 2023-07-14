import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled10/network/endpoint.dart';
import 'package:untitled10/utils/utils.dart';
class HomeScreenController extends ChangeNotifier{
  var lawyerData;
List caseRequestList=[];
List caseList=[];
List clientList=[];
bool isLoading=true;
  Future<void> initState(context)async{
    showLoader(true);
    await getCaseReqList(context);
    await getProfileDetails(context);
    await getCaseList(context);
   await getClientList(context);
    showLoader(false);
  }
  showLoader(value){
    isLoading=value;
    notifyListeners();
  }
Future<void> getProfileDetails(context)async{
  // showLoader(true);
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

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      lawyerData = result["DATA"];
      // showLoader(false);
    }
    else {
      Utils.showPrimarySnackbar(
          context, "Something went wrong", type: SnackType.error);
    }

}

  Future<void> getCaseReqList(context)async{
    // showLoader(true);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("token"));
    var response= await http.post(
      Uri.parse("${Endpoint.getCaseRequestList}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        // 'token': '${pref.getString("token")}',
        'token': '${pref.getString("token")}',
      }),
    );
    print(response.body);
    log(response.body);
    if(response.body.isNotEmpty) {
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        caseRequestList = result;
        // showLoader(false);
      }

      else {
        Utils.showPrimarySnackbar(
            context, "Something went wrong", type: SnackType.error);
      }
    }
    else{
      // showLoader(false);
    }
  }


  Future<void> getCaseList(context)async{
    // showLoader(true);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("token"));
    var response= await http.post(
      Uri.parse("${Endpoint.getCaseList}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'token': '${pref.getString("token")}',
        // 'token': '${pref.getString("token")}',
      }),
    );
    print("case list");
    print(response.body);
    log(response.body);
    if(response.body.isNotEmpty) {
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        caseList = result["DATA"];
        // showLoader(false);
      }

      else {
        Utils.showPrimarySnackbar(
            context, "Something went wrong", type: SnackType.error);
      }
    }
    else{
      // showLoader(false);
    }
  }


  Future<void> getClientList(context)async{
    // showLoader(true);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("token"));
    var response= await http.post(
      Uri.parse("${Endpoint.getClientList}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'token': '${pref.getString("token")}',
        // 'token': '${pref.getString("token")}',
      }),
    );
    print("client_list");
    log(response.body);
    final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        clientList = result["DATA"];
        // showLoader(false);
      }

      else {
        Utils.showPrimarySnackbar(
            context, "Something went wrong", type: SnackType.error);
      }

  }

}
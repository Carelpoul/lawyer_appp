

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled10/network/endpoint.dart';
import 'package:untitled10/utils/utils.dart';
import 'package:http/http.dart' as http;


class CaseDetailController extends ChangeNotifier{
  bool isLoading=true;
  var caseDetails;
  showLoader(value){
    isLoading=value;
    notifyListeners();
  }

  Future<void> getCaseDetails(context,id)async{
    showLoader(true);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var response= await http.post(
      Uri.parse("${Endpoint.getCaseDtlsForLawyer}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'request_id':id,
      }),
    );
    print("heloooooo");

    log(response.body);
    final result=jsonDecode(response.body);
    if(response.statusCode==200){
      caseDetails=result["DATA"];
      print(caseDetails);
      notifyListeners();
      // print("result");
      // print(requestDetails["quotes_comment"]);
      showLoader(false);
    }
    else{
      Utils.showPrimarySnackbar(context, "Something went wrong",type: SnackType.error);
    }
  }
}
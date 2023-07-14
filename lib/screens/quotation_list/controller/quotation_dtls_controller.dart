import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled10/network/endpoint.dart';
import 'package:untitled10/utils/utils.dart';

class QuotationDetailsController extends ChangeNotifier{
  var quaotationDetails;
  bool isLoading=true;
  showLoader(value){
    isLoading=value;
    notifyListeners();
  }

  Future getQuotationDetails(context,id)async{
    showLoader(true);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var response= await http.post(
      Uri.parse("${Endpoint.getQuotationDtlsForLawyer}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'quote_id':'${id}'
      }),
    );
    log(response.body);
    final result=jsonDecode(response.body);
    if(response.statusCode==200){
      quaotationDetails=result;
      print("result");
      print(quaotationDetails["quotes_comment"]);
      showLoader(false);
    }
    else{
      Utils.showPrimarySnackbar(context, "Something went wrong",type: SnackType.error);
    }
  }
}
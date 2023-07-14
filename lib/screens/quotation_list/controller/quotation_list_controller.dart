import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled10/network/endpoint.dart';
import 'package:untitled10/utils/utils.dart';

class QuotationListController extends ChangeNotifier{
  List quaotationList=[];
  bool isLoading=true;
  showLoader(value){
    isLoading=value;
    notifyListeners();
  }

  Future getQuotationList(context)async{
    showLoader(true);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var response= await http.post(
      Uri.parse("${Endpoint.getQuotationListForLawyer}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'lawyer_token':'${pref.getString("token")}',
      }),
    );
    print(response.body);
    final result=jsonDecode(response.body);
    if(response.statusCode==200){
      quaotationList=result["DATA"];
      print(quaotationList);
      showLoader(false);
    }
    else{
      Utils.showPrimarySnackbar(context, "Something went wrong",type: SnackType.error);
    }
  }
}
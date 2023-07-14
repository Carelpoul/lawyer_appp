import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:untitled10/screens/home_screen/controller/home_screen_controller.dart';
import 'package:untitled10/screens/request_case_detail/view/request_case_detail_view.dart';


class RequestCaseListView extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final watch=context.watch<HomeScreenController>();
    final read=context.read<HomeScreenController>();
    return  ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: watch.caseRequestList.length,
      itemBuilder: (context, index) {
        final element=watch.caseRequestList[index];
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0.sp,vertical: 8.w),
          child: Card(
            child: InkWell(
              onTap: (){},
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(element["request_title"]??"No Title"),
                    element["request_stats_flg"]=="P"?Chip(
                      backgroundColor: Colors.red,
                      label: Text(
                        "Pending",
                        style: TextStyle(color: Colors.white),
                      ),
                    ):element["request_stats_flg"]=="Q"?Chip(
                      backgroundColor: Colors.blue,
                      label: Text(
                        "Quoted",
                        style: TextStyle(color: Colors.white),
                      ),
                    ):Chip(
                      backgroundColor: Colors.green,
                      label: Text(
                        "Open",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // Text(element["request_stats_flg"]=="P"?"Pending":element["request_stats_flg"]=="Q"?"Quoted":"Open",style: TextStyle(color:element["request_stats_flg"]=="P"?Colors.red:element["request_stats_flg"]=="Q"?Colors.blue:Colors.green),),
                  ],
                ),
                subtitle: Padding(
                  padding:  EdgeInsets.only(bottom: 5.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(element["request_description"]??"No Descrption")),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(element["request_creatn_date"].toString().substring(0,element["request_creatn_date"].toString().indexOf('T')))
                    ],
                  ),
                ),
                onTap: () {
                  // Handle tile tap here
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>RequestCaseDetailView(quoteToken: element["request_public_id"],)));
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

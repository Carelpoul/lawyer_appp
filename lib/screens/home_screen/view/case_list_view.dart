import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/screens/case_detail/view/case_detail_view.dart';
import 'package:untitled10/screens/home_screen/controller/home_screen_controller.dart';

class Case {
  final String caseNumber;
  final String clientName;
  final String caseStatus;
  final String clientProfilePicUrl;

  Case({required this.caseNumber, required this.clientName, required this.caseStatus , required this.clientProfilePicUrl
  });
}
class CaseListView extends StatelessWidget {

  final List<Case> cases = [
    Case(
      clientName: 'John Smith',
      caseNumber: 'C001',
      caseStatus: 'Open',
      clientProfilePicUrl: 'https://example.com/client1_profile.jpg',
    ),
    Case(
      clientName: 'Emily Johnson',
      caseNumber: 'C002',
      caseStatus: 'Closed',
      clientProfilePicUrl: 'https://example.com/client2_profile.jpg',
    ),
    Case(
      clientName: 'Michael Brown',
      caseNumber: 'C003',
      caseStatus: 'Open',
      clientProfilePicUrl: 'https://example.com/client3_profile.jpg',
    ),
    // Add more cases here
  ];

  @override
  Widget build(BuildContext context) {
    final watch=context.watch<HomeScreenController>();
    final read=context.read<HomeScreenController>();
    return
      ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount:watch.caseList.length,
        itemBuilder: (context, index) {
          final element= watch.caseList[index];
          // final Case currentCase = cases[index];
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 7.w),
            child: Card(
              child: ListTile(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>CaseDetailView(requestId:element["pk_user_request_id"].toString())));
                },
                // leading:  Container(
                //   width: 50.0,
                //   height: 50.0,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(7.0),
                //     border: Border.all(
                //       color:  Color(0xFF8A2387),
                //       width: 2.0,
                //     ),
                //   ),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(5),
                //     child: Image.network(
                //       'https://dailypost.ng/wp-content/uploads/2023/03/Erik-ten-Hag-Man-Utd.jpg',
                //       fit: BoxFit.cover,
                //     ),
                //   ),),


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

                // trailing: Chip(
                //
                //   backgroundColor: currentCase.caseStatus == 'Open'
                //       ? Colors.green
                //       : Colors.red,
                //   label: Text(
                //     currentCase.caseStatus,
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                // onTap: () {
                //   // Handle case item tap
                //   print('Case tapped: ${currentCase.caseNumber}');
                // },
              ),
            ),
          );
        },
      );
    //   //ListView.builder(
    //   itemCount: cases.length,
    //   itemBuilder: (context, index) {
    //     return
    //       Card(
    //       child: InkWell(
    //         onTap: (){},
    //         child: ListTile(
    //           leading: Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(7.0),
    //               border: Border.all(
    //                 color:  Color(0xFF8A2387),
    //                 width: 2.0,
    //               ),
    //             ),
    //             child: Image.network(
    //               cases[index].imagePath,fit: BoxFit.cover,
    //               width: 50,
    //               height: 50,
    //             ),
    //           ),
    //           title: Text(cases[index].caseTitle),
    //           subtitle: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(cases[index].caseDetails),
    //               Text("11/11/2011")
    //             ],
    //           ),
    //           onTap: () {
    //             // Handle tile tap here
    //             print('Tapped on ${cases[index].caseTitle}');
    //           },
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

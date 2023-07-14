import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled10/screens/quotation_list/controller/quotation_list_controller.dart';
import 'package:untitled10/screens/quotation_list/view/quotation_details_view.dart';
import 'package:provider/provider.dart';

class CaseQuotationListView extends StatefulWidget {
  const CaseQuotationListView({super.key});

  @override
  State<CaseQuotationListView> createState() => _CaseQuotationListViewState();
}

class _CaseQuotationListViewState extends State<CaseQuotationListView> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<QuotationListController>().getQuotationList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch=context.watch<QuotationListController>();
    final read=context.read<QuotationListController>();
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Color(0xFF8A2387),
        elevation: 0,
        centerTitle: true,
        title: const Text("Case Quotation", style: TextStyle(color: Colors.white)),
      ),
      body:watch.isLoading?Center(child: CircularProgressIndicator(),):
      ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: watch.quaotationList.length, // Replace with the actual number of quotations
        itemBuilder: (context, index) {
          final res=watch.quaotationList[index];
final element=watch.quaotationList[index]["quote_user"];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Name of user',style: TextStyle(fontWeight: FontWeight.w500,fontSize:16.sp),),
                  const SizedBox(height: 8.0),
                   Text(element["user_mastr_name"]??"Name Not Found"),
                  const SizedBox(height: 16.0),
                   Text('Quotation Details',style: TextStyle(fontWeight: FontWeight.w500,fontSize:16.sp),),
                  const SizedBox(height: 0.0),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Status:'),
                          SizedBox(
                            width: 7.w,
                          ),
                          res["quote_stats_flg"]=="P"?Chip(
                            backgroundColor: Colors.red,
                            label: Text(
                              "Pending",
                              style: TextStyle(color: Colors.white),
                            ),
                          ):res["quote_stats_flg"]=="Q"?Chip(
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
                        ],
                      ),

                      Text('Amount: Rs ${res["quotes_advance_amount"]}',style: TextStyle(fontWeight: FontWeight.w500),), // Replace with actual quotation amount
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>QuotationDetailView(quotationId: res["pk_quotes_id"].toString(),)));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
                      child: const Text(
                        'View Quotation',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget _buildQuotationCard(BuildContext context, int index) {
  //   return Card(
  //     margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  //     elevation: 4.0,
  //     child: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('Case ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
  //           SizedBox(height: 8.0),
  //           Text('Lawyer Name'),
  //           Text('Quotation Details'),
  //           SizedBox(height: 8.0),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text('Status: Pending'),
  //               Text('Amount: \$1000'), // Replace with actual quotation amount
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/screens/Registration_screen/controller/registration_form_controller.dart';
import 'package:untitled10/screens/case_detail/controller/case_detail_controller.dart';

import 'package:untitled10/screens/create_quotation/view/create_quotation_view.dart';
import 'package:untitled10/screens/request_case_detail/controller/case_request_details_controller.dart';

class CaseDetailView extends StatefulWidget {
  final String ? requestId;
  const CaseDetailView({super.key,required this.requestId});

  @override
  State<CaseDetailView> createState() => _CaseDetailViewState();
}

class _CaseDetailViewState extends State<CaseDetailView> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<CaseDetailController>().getCaseDetails(context,widget.requestId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read=context.read<CaseDetailController>();
    final watch=context.watch<CaseDetailController>();
    return Scaffold(
      appBar: AppBar(
          backgroundColor:  Color(0xFF8A2387),
          title: const Text('Case Detail',style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,color: Colors.white),
            onPressed: (){
              Navigator.pop(context);
            },
          )
      ),
      body:watch.isLoading?Center(
        child: CircularProgressIndicator(),
      ):
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Case Details',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Case Title', watch.caseDetails["request_title"]??"No Title"),
                      const SizedBox(height: 16.0),
                      _buildDetailRow(
                          'Case Description',
                          watch.caseDetails["request_description"]??"No Descritpion"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'User Details',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _buildDetailRow('Case Title', 'John Doe vs. ABC Corp'),
                      // const SizedBox(height: 16.0),
                      _buildDetailRow(
                          'Name',
                          watch.caseDetails["user"]["user_mastr_name"]??"Name not found"),
                      const SizedBox(height: 16.0),
                      _buildDetailRow('Email', watch.caseDetails["user"]["user_mastr_email"]??"Email not found"),
                      const SizedBox(height: 16.0),
                      _buildDetailRow('Phone No', watch.caseDetails["user"]["user_mastr_phone"]??"Phone No not found"),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Attachments',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAttachmentItem('Attachment 1',watch.caseDetails["request_attachment"]),
                      // const SizedBox(height: 8.0),
                      // _buildAttachmentItem('Attachment 2'),
                      // const SizedBox(height: 8.0),
                      // _buildAttachmentItem('Attachment 3'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              watch.caseDetails["request_stats_flg"]=="P"? Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateQuotationView(clientName:watch.caseDetails["user"]["user_mastr_name"],quoteRequestId:watch.caseDetails["pk_user_request_id"].toString(),token:watch.caseDetails["user"]["user_mastr_access_key"],)));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),

                  child: const Text('Create Quotation',style: TextStyle(color: Colors.white)),
                ),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }

  Widget _buildAttachmentItem(String attachmentName,attachedFile) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.attachment),
            const SizedBox(width: 8.0),
            Text(
              attachmentName,
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
        attachedFile==""?Container(): SizedBox(
          height: 10.w,
        ),
        attachedFile==""?Container():
        CachedNetworkImage(imageUrl:"http://117.200.73.2:7075/lawyer/public/${attachedFile}"),
      ],
    );
  }
}
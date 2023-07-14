import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/screens/quotation_list/controller/quotation_dtls_controller.dart';
import 'package:untitled10/screens/request_screen.dart';

class QuotationDetailView extends StatefulWidget {
  final String ? quotationId;
  const QuotationDetailView({super.key,required this.quotationId});

  @override
  State<QuotationDetailView> createState() => _QuotationDetailViewState();
}

class _QuotationDetailViewState extends State<QuotationDetailView> {


  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<QuotationDetailsController>().getQuotationDetails(context,widget.quotationId);
    });
  }
  @override
  Widget build(BuildContext context) {
final watch=context.watch<QuotationDetailsController>();
final read=context.read<QuotationDetailsController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF8A2387),
          title: const Text('Case Request Detail',style: TextStyle(color: Colors.white)),
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _buildDetailRow('Case Title', 'John Doe vs. ABC Corp'),
                      // const SizedBox(height: 16.0),
                      _buildDetailRow(
                          'Case Description',
                          watch.quaotationDetails["quotes_comment"]??""),
                      const SizedBox(height: 16.0),
                      _buildDetailRow('Amount',  "Rs ${watch.quaotationDetails["quotes_advance_amount"].toString()}"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Requested By',
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
                      // _buildDetailRow('Case Title', 'John Doe vs. ABC Corp'),
                      // const SizedBox(height: 16.0),
                      _buildDetailRow(
                          'Name',
                          watch.quaotationDetails["quote_user"]["user_mastr_name"]??"Name not found"),
                      const SizedBox(height: 16.0),
                      _buildDetailRow('Email', watch.quaotationDetails["quote_user"]["user_mastr_email"]??"Email not found"),
                      const SizedBox(height: 16.0),
                      _buildDetailRow('Phone No', watch.quaotationDetails["quote_user"]["user_mastr_phone"]??"Phone No not found"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Quote Details',
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
                      // _buildDetailRow('Case Title', 'John Doe vs. ABC Corp'),
                      // const SizedBox(height: 16.0),
                      _buildDetailRow(
                          'Description',
                          watch.quaotationDetails["quote_request"]["request_description"]??"Description not found"),
                      const SizedBox(height: 16.0),
                      _buildDetailRow('Date', watch.quaotationDetails["quote_request"]["request_creatn_date"].toString().substring(0,watch.quaotationDetails["quote_request"]["request_creatn_date"].toString().indexOf('T'))),
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
                      _buildAttachmentItem('Attachment 1'),
                      const SizedBox(height: 8.0),
                      _buildAttachmentItem('Attachment 2'),
                      const SizedBox(height: 8.0),
                      _buildAttachmentItem('Attachment 3'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Perform cancel action
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),

                  child: const Text('Cancel Case',style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
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
      ),
    );
  }

  Widget _buildAttachmentItem(String attachmentName) {
    return Row(
      children: [
        const Icon(Icons.attachment),
        const SizedBox(width: 8.0),
        Text(
          attachmentName,
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }
}
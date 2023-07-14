import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled10/network/endpoint.dart';
import 'package:untitled10/screens/home_screen/view/home_screen_view.dart';
import 'package:untitled10/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:untitled10/widgets/loaderoverlay.dart';
class CreateQuotationView extends StatefulWidget {
  final String clientName;
  final String token;
  final String quoteRequestId;

  CreateQuotationView({ required this.clientName,required this.token,required this.quoteRequestId});

  @override
  _CreateQuotationViewState createState() => _CreateQuotationViewState();
}

class _CreateQuotationViewState extends State<CreateQuotationView> {
  double advanceAmount = 0.0;
  List<Milestone> milestones = [];
  List descriptionList=[];
  List amountList=[];
  List durationList=[];

  TextEditingController advanceAmountController=TextEditingController();
  TextEditingController commentController=TextEditingController();

  Future<void> saveQuotation()async{
    print(widget.quoteRequestId);
    LoadingOverlay.of(context).show();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("token"));
    var response= await http.post(
      Uri.parse("${Endpoint.saveQuotation}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        // 'token': '${pref.getString("token")}',
        'token': widget.token,
        'quote_request_id': widget.quoteRequestId,
        'advance': advanceAmountController.text,
        'lawyer_token': pref.getString("token"),
        'comment': commentController.text,
        'desc': descriptionList,
        'duration':  durationList,
        'amount':  amountList,
      }),
    );
    print("hello");
    log(response.body);
    print("hello");
    if(response.statusCode==200){
        Navigator.push(context,MaterialPageRoute(builder:(context)=>Home_page()));
        Utils.showPrimarySnackbar(context,"Quotation Created Successfully",type: SnackType.success);
        LoadingOverlay.of(context).hide();
    }
    else{
      LoadingOverlay.of(context).hide();
      Utils.showPrimarySnackbar(context,"Something went wrong",type: SnackType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF8A2387),
        title: Text('Quotation Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Case Request Details',
              //   style: TextStyle(
              //     fontSize: 18.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    'Date: ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                      DateFormat('yyy-MM-dd')
                          .format(DateTime.now()),
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),

              SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    'Client: ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    widget.clientName,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),

              SizedBox(height: 16.0),
              Text(
                'Advance Amount:',
                style: TextStyle(fontSize: 16.0),
              ),
              TextFormField(
                controller: advanceAmountController,
                onChanged: (value) {
                  setState(() {
                    advanceAmount = double.tryParse(value) ?? 0.0;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter advance amount',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Total Amount:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '${calculateTotalAmount()}',
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Milestones:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: milestones.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                milestones[index].description,
                                style: TextStyle(fontSize: 14.0),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Duration: ${milestones[index].duration}',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '${milestones[index].amount}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String description = '';
                  String duration = '';
                  double amount = 0.0;

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Add Milestone'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                description = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Description',
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                duration = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Duration',
                              ),
                            ),
                            TextFormField(
                              onChanged: (value) {
                                amount = double.tryParse(value) ?? 0.0;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Amount',
                              ),
                            ),


                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(primary:  Color(0xFF8A2387),),
                            onPressed: () {
                              // if(description==""){
                              //   Utils.showPrimarySnackbar(context, "Enter Discription",type: SnackType.error);
                              //   return;
                              // }
                              // if(duration==""){
                              //   Utils.showPrimarySnackbar(context, "Enter Duration",type: SnackType.error);
                              //   return;
                              // }
                              // if(amount==""){
                              //   Utils.showPrimarySnackbar(context, "Enter Amount",type: SnackType.error);
                              //   return;
                              // }

                              setState(() {
                                milestones.add(
                                  Milestone(description: description, duration: duration, amount: amount),
                                );
                              });
                                setState(() {
                                  descriptionList.add(milestones[milestones.length-1].description);
                                  durationList.add(milestones[milestones.length-1].duration);
                                  amountList.add(milestones[milestones.length-1].amount.toString());
                                  print(descriptionList);
                                });
                              Navigator.pop(context);
                            },
                            child: Text('Add'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );
                },

                  style: ElevatedButton.styleFrom(primary:  Color(0xFF8A2387),),

                child: Text('Add Milestone'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: SizedBox(
                  height: 100,
                  child: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                        labelText: 'Comment',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:  Color(0xFF8A2387),
                          ),
                        )
                    ),
                    maxLines: 5,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(child: ElevatedButton( style: ElevatedButton.styleFrom(primary:  Color(0xFF8A2387),),onPressed: (){
                saveQuotation();
              }, child: Text("Submit")))
            ],
          ),
        ),
      ),
    );
  }

  double calculateTotalAmount() {
    double total = advanceAmount;
    for (var milestone in milestones) {
      total += milestone.amount;
    }
    return total;
  }

  void _showAddMilestoneDialog(BuildContext context) {
    String description = '';
    String duration = '';
    double amount = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Milestone'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  description = value;
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  duration = value;
                },
                decoration: InputDecoration(
                  labelText: 'Duration',
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  amount = double.tryParse(value) ?? 0.0;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),


            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary:  Color(0xFF8A2387),),
              onPressed: () {
                if(description==""){
                  Utils.showPrimarySnackbar(context, "Enter Discription",type: SnackType.error);
                  return;
                }
                if(duration==""){
                  Utils.showPrimarySnackbar(context, "Enter Duration",type: SnackType.error);
                  return;
                }
                if(amount==""){
                  Utils.showPrimarySnackbar(context, "Enter Amount",type: SnackType.error);
                  return;
                }
                setState(() {
                  milestones.add(
                    Milestone(description: description, duration: duration, amount: amount),
                  );
                });
                for(int i=0;i<milestones.length;i++){
                  setState(() {
                    descriptionList.add(milestones[i].description);
                    durationList.add(milestones[i].duration);
                    amountList.add(milestones[i].amount.toString());
                    print(descriptionList);
                  });
                }

                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class Milestone {
  String description;
  String duration;
  double amount;

  Milestone({
    required this.description,
    required this.duration,
    required this.amount,
  });
}
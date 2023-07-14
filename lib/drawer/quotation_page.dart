import 'package:flutter/material.dart';

class QuotationPage extends StatefulWidget {
  final String caseRequest;
  final String clientName;
  final String caseDescription;

  QuotationPage({required this.caseRequest, required this.clientName, required this.caseDescription});

  @override
  _QuotationPageState createState() => _QuotationPageState();
}

class _QuotationPageState extends State<QuotationPage> {
  double advanceAmount = 0.0;
  List<Milestone> milestones = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    widget.caseRequest,
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
                  _showAddMilestoneDialog(context);
                },
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
              Center(child: ElevatedButton(onPressed: (){}, child: Text("Submit")))
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
              onPressed: () {
                setState(() {
                  milestones.add(
                    Milestone(description: description, duration: duration, amount: amount),
                  );
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
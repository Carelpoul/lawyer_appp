import 'package:flutter/material.dart';
import 'package:untitled10/drawer/quotation_page.dart';
class CaseRequestsSentPage extends StatelessWidget {
  const CaseRequestsSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[800],
        title: const Text('Case Requests', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Card(
            elevation: 4.0,
            child: ListTile(
              title: const Text("Case 1"),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jane Smith vs. XYZ Inc"),
                  SizedBox(height: 4.0),
                  Text("Request Date: May 1, 2023"),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent[400],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Text(
                  "Pending",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>QuotationPage(
                      caseRequest: '', clientName: '', caseDescription: '',))
                );
              },
              onLongPress: () {
                // Show confirmation dialog to cancel the request
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Cancel Case Request"),
                      content: const Text("Are you sure you want to cancel this case request?"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("Confirm"),
                          onPressed: () {
                            // Perform cancellation logic here
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 4.0,
            child: ListTile(
              title: const Text("Case 1"),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jane Smith vs. XYZ Inc"),
                  SizedBox(height: 4.0),
                  Text("Request Date: May 1, 2023"),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {

              },
              onLongPress: () {
                // Show confirmation dialog to cancel the request
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Cancel Case Request"),
                      content: const Text("Are you sure you want to cancel this case request?"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("Confirm"),
                          onPressed: () {
                            // Perform cancellation logic here
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 4.0,
            child: ListTile(
              title: const Text("Case 1"),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jane Smith vs. XYZ Inc"),
                  SizedBox(height: 4.0),
                  Text("Request Date: May 1, 2023"),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Text(
                  "Rejected",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                // Navigate to case view page
              },

            ),
          ),

          // Add more Card widgets for other case requests
        ],
      ),
    );
  }
}
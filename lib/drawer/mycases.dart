import 'package:flutter/material.dart';



class MyCauses extends StatelessWidget {
  const MyCauses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          elevation: 0,
          title: const Text("My Cases", style: TextStyle(color: Colors.white)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: 5, // Replace with the actual number of cases
          itemBuilder: (context, index) {
            return _buildCaseCard(context, index);
          },
        ));
  }

  Widget _buildCaseCard(BuildContext context, int index) {
    final caseTitle = 'Case ${index + 1}';
    const caseDetails =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          title: Text(
            caseTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            caseDetails,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => CaseViewPage()));
            // Handle case item tap
          },
        ),
      ),
    );
  }
}

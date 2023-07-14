import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled10/screens/Registration_screen/view/login_page_view.dart';
import 'package:untitled10/screens/home_screen/controller/home_screen_controller.dart';

import '../screens/quotation_list/view/case_quotation_list_view.dart';
import 'case_request.dart';
import 'causequatation.dart';
import 'mycases.dart';
import 'package:provider/provider.dart';
class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final watch=context.watch<HomeScreenController>();
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Drawer(
            backgroundColor: Colors.white,
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
               UserAccountsDrawerHeader(
                decoration:BoxDecoration(
                  color:  Color(0xFF8A2387),
                ) ,
                accountName: Text((watch.lawyerData["lawyer_mastr_name"])),
                accountEmail: Text(watch.lawyerData["lawyer_mastr_email"]),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("http://117.200.73.2:7075/lawyer/public/${watch.lawyerData["lawyer_mastr_profile_pic"]}"),
                  backgroundColor:  Color(0xFF8A2387),

                ),
              ),
              // ListTile(
              //   leading: const Icon(Icons.request_page),
              //   title: const Text('Case Request'),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const CaseRequestsSentPage()));
              //     // Navigate to the profile screen
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.question_answer_outlined),
                title: const Text("Case Quotation"),
                onTap: () {
                  // Navigate to the home screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CaseQuotationListView()));
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.library_books),
              //   title: const Text('My Cases'),
              //   onTap: () {
              //     // Navigate to the my cases screen
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const MyCauses()));
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const RequestSendingPage()));
                  // Navigate to the messages screen
                },
              ),
               ListTile(
                onTap: ()async{
                  SharedPreferences pref=await SharedPreferences.getInstance();
                  pref.clear();
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginView()));
                },
                leading: Icon(Icons.login_outlined),
                title: Text("LogOut"),
              )
            ])));
  }
}

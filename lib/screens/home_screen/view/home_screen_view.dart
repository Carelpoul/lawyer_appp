import 'package:cached_network_image/cached_network_image.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:untitled10/screens/home_screen/view/request_cases_view.dart';
import 'package:untitled10/screens/home_screen/controller/home_screen_controller.dart';
import 'package:untitled10/screens/profile/controller/profile_controller.dart';
import 'package:untitled10/screens/profile/view/my_profile_view.dart';
import 'package:untitled10/screens/home_screen/view/case_list_view.dart';

import '../../../drawer/drawer.dart';
import 'package:provider/provider.dart';

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {

    if(i==0){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Home_page()));
    }
    if(i==3){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>MyProfileView()));
    }
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenController>().initState(context);
      // context.read<ProfileController>().getProfileDetails(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    final watch=context.watch<HomeScreenController>();
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF8A2387),
              elevation: 0,
             // title: Text("Lawyer"),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: InkWell(
                    child:Icon(Icons.notifications_active,color: Colors.white,)
                  ),
                )
              ],
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: DotNavigationBar(
                margin: EdgeInsets.only(left: 10, right: 10),
                currentIndex: _SelectedTab.values.indexOf(_selectedTab),
                dotIndicatorColor: Colors.white,
                unselectedItemColor: Colors.grey[300],
                 enableFloatingNavBar: false,
                onTap: _handleIndexChanged,
                items: [

                  DotNavigationBarItem(
                    icon: Icon(Icons.home),
                    selectedColor:  Color(0xFF8A2387),
                  ),


                  DotNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    selectedColor: Color(0xFF8A2387),
                  ),


                  DotNavigationBarItem(
                    icon: Icon(Icons.search),
                    selectedColor: Color(0xFF8A2387),
                  ),


                  DotNavigationBarItem(
                    icon: Icon(Icons.person),
                    selectedColor:  Color(0xFF8A2387),
                  ),
                ],
              ),
            ),

            drawer: NavDrawer(),
            body:watch.isLoading?Center(child: CircularProgressIndicator(),):
            WillPopScope(
              onWillPop: ()async{
                return false;
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lawyer Details Section
                  // Lawyer Details Section
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile Picture
                            Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:  Color(0xFF8A2387),
                                  width: 3.0,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                   "http://117.200.73.2:7075/lawyer/public/${watch.lawyerData["lawyer_mastr_profile_pic"]}"),
                                ),
                              ),
                            SizedBox(width: 16.0),
                            // Lawyer Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(watch.lawyerData["lawyer_mastr_name"],style: TextStyle(fontWeight: FontWeight.bold)),
                                      Container(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Image.network(
                                          'https://m.media-amazon.com/images/I/71sn0XPSTOL._AC_UF1000,1000_QL80_.jpg',
                                          fit: BoxFit.cover,
                                        ),),
                                    ],
                                  ),
                                  Text(watch.lawyerData["lawyer_mastr_type"] + " Law"),
                                  Text(watch.lawyerData["lawyer_mastr_education"])
                                  // Add more lawyer details here
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // My Clients Section
                  Padding(
                    padding: EdgeInsets.only(bottom: 10,top: 10,right: 10,left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Clients',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < watch.clientList.length; i++)
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 70.0,
                                          height: 70.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7.0),
                                            border: Border.all(
                                              color:  Color(0xFF8A2387),
                                              width: 2.0,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child:watch.clientList[i]["user"]["user_mastr_profile_pic"]==null?
                                            CachedNetworkImage(
                                              imageUrl:
                                              'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=2000',
                                              fit: BoxFit.cover,
                                            ): CachedNetworkImage(
                                              imageUrl: 'http://117.200.73.2:7075/lawyer/public/${watch.clientList[i]["user"]["user_mastr_profile_pic"]}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),),


                                      SizedBox(height: 3.0),
                                      Card(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 100,
                                          height: 30,
                                          child: Text(
                                           watch.clientList[i]["user"]["user_mastr_name"],
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // TabBar
                  TabBar(
                    tabs: [
                      Tab(child: Text("Cases",style: TextStyle(color:Color(0xFF8A2387),),)),
                      Tab(child: Text("Requests",style: TextStyle(color: Color(0xFF8A2387),),)),
                    ],
                  ),

                  // TabBarView
                  Expanded(
                    child: TabBarView(
                      children: [
                        CaseListView(),
                        RequestCaseListView()

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
enum _SelectedTab { home, favorite, search, Profile}
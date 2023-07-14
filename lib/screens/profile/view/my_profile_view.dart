import 'package:cached_network_image/cached_network_image.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/screens/home_screen/controller/home_screen_controller.dart';
import 'package:untitled10/screens/home_screen/view/home_screen_view.dart';
import 'package:untitled10/screens/profile/controller/profile_controller.dart';
import 'package:untitled10/screens/profile/view/edit_profile_view.dart';



class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  var _selectedTab = _SelectedTab.MyProfileView;
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
      context.read<MyProfileController>().getProfileDetails(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final watch=context.watch<MyProfileController>();
    final read=context.read<MyProfileController>();
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF8A2387),
        elevation: 0,

        title: Text("My Profile"),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>EditProfileView()));
            },
            child: Padding(padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.edit,color: Colors.white),),
          )
        ],
        leading: Container()
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
      body:watch.isLoading?Center(
        child: CircularProgressIndicator(),
      ):
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
border: Border.all(color: Color(0xFF8A2387),width: 2),
                  shape: BoxShape.circle
                ),
                child: ClipOval(
                  child: CachedNetworkImage(imageUrl: "http://117.200.73.2:7075/lawyer/public/${watch.lawyerData["lawyer_mastr_profile_pic"]}",
                    fit: BoxFit.contain,
                    width: 150.0,
                    height: 150.0,
                  ),
                ),
              ),
            ),
            // Center(
            //   child: CircleAvatar(
            //     radius: 60,
            //     backgroundImage: NetworkImage("http://117.200.73.2:7075/lawyer/public/${watch.lawyerData["lawyer_mastr_MyProfileView_pic"]}"),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Text("Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            SizedBox(
              height: 1,
            ),
            Text(watch.lawyerData,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.email,color: Colors.purple),
              title: Text("Email Id",style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(watch.lawyerData["lawyer_mastr_email"]),
            ),
            ListTile(
              leading: Icon(Icons.location_city_outlined,color: Colors.purple),
              title: Text("Address",style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(watch.lawyerData["lawyer_mastr_address"]),
            ),

            ListTile(
              leading: Icon(Icons.phone,color: Colors.purple),
              title: Text("Contact",style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(watch.lawyerData["lawyer_mastr_phone1"]),
            ),
            ListTile(
              leading: Icon(Icons.calendar_month,color: Colors.purple),
              title: Text("Date of birth",style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(watch.lawyerData["lawyer_mastr_dob"]),
            ),

            ListTile(
              leading: Icon(Icons.location_on,color: Colors.purple),
              title: Text("Country",style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(watch.lawyerData["country"]["cmn_country_name"]),
            ),
            ListTile(
              leading: Icon(Icons.info_outline,color: Colors.purple),
              title: Text("About us",style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(watch.lawyerData["lawyer_mastr_about_me"]),
            ),

          ],
        ),
      ),
    );
  }
}
enum _SelectedTab { home, favorite, search, MyProfileView}
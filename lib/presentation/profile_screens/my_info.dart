import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'editprofile_sceen.dart';

class MyInfo extends StatefulWidget {
  final Map<String, dynamic> userData;

  const MyInfo({super.key, required this.userData});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  TextEditingController _passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/profile_img.jpg'),
                      ),
                      SizedBox(height: 15),
                      Text(
                        '${widget.userData['name1']}${widget.userData['name2']}' ?? 'No Name',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.userData['email'] ?? 'example@email.com',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 20),
                      Divider(thickness: 1),
                      SizedBox(height: 10),
                     _buildInfoRow(Icons.mail_outline, 'Email', widget.userData['email'] ?? 'Not Set'),
                      _buildInfoRow(Icons.phone, 'Phone', widget.userData['phone'] ?? 'Not Provided'),
                      _buildInfoRow(Icons.location_on, 'Location', 'Square ${widget.userData['square']}        home ${widget.userData['home']}' ?? 'Not Set'),
                      _buildInfoRow(Icons.access_time_outlined, 'Sign up date', widget.userData['signUpDate'] ?? 'Not Set'),
                      _buildInfoRow(Icons.password, 'Password', '********' ?? 'Not Set'),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          showDialog(context: context, builder: (_)=> CupertinoAlertDialog(
                            title: Text("Enter Password"),
                            content: Column(
                              children: [
                                CupertinoTextField(
                                    controller: _passwordController
                                ),
                                ElevatedButton(onPressed: (){
                                  if (_passwordController.text == widget.userData['password']) {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=> EditProfile(userData: widget.userData,)));
                                  }else{
                                    Text("Wrong Password");
                                  }
                                }, child: Text("Submit"))
                              ],
                            ),
                          ));
                        },
                        icon: Icon(Icons.edit),
                        label: Text("Edit Data"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey),
          SizedBox(width: 10),
          Text('$title:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Expanded(child: Text(value, style: TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }
}

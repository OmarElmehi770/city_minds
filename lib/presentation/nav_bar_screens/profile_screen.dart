import 'dart:io';
import 'package:animations/animations.dart';
import 'package:city_minds/presentation/nav_bar_screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../login_screan.dart';
import '../profile_screens/my_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? file;
  getImage(bool val) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: val ?ImageSource.gallery:ImageSource.camera);


    file =File(photo!.path);

    setState(() {

    });
  }

  Future<Map<String, dynamic>> getCurrentUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return userDoc.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Icon(Icons.settings, size: 28, color: Colors.black),
          SizedBox(width: 15),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentUserData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return Center(child: Text("No user data found."));
          }

          var data = snapshot.data!;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(radius: 63, backgroundColor: Colors.grey),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: file != null ? FileImage(file!) : null,
                      ),
                      Positioned(
                        bottom: 2, right: 2,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(radius: 15, backgroundColor: Colors.grey),
                            PopupMenuButton<bool>(
                              onSelected: (value) {
                                getImage(value);
                              },
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<bool>>[
                                PopupMenuItem<bool>(
                                  value: true,
                                  child: Text('Gallery'),
                                ),
                                PopupMenuItem<bool>(
                                  value: false,
                                  child: Text('Camera'),
                                ),
                              ],
                              icon: Icon(Icons.edit),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(
                    "${data['name1']}${data['name2']}",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text("${data['email']}", style: TextStyle(fontSize: 15)),
                  SizedBox(height: 40),
                  OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: Duration(milliseconds: 700),
                    openBuilder: (context, _) => MyInfo(userData: data),
                    closedBuilder: (context, openContainer) {
                      return ListTile(
                        onTap: () {
                          openContainer();
                        },
                        title: Text('My Info', style: TextStyle(fontSize: 20)),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 26,
                          color: Colors.black,
                        ),
                        leading: Icon(
                          Icons.person,
                          size: 28,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: Duration(milliseconds: 700),
                    openBuilder: (context, _) => HomeScreen(),
                    closedBuilder: (context, openContainer) {
                      return ListTile(
                        onTap: () {
                          openContainer();
                        },
                        title: Text('Location', style: TextStyle(fontSize: 20)),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 26,
                          color: Colors.black,
                        ),
                        leading: Icon(
                          Icons.location_on,
                          size: 28,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: Duration(milliseconds: 700),
                    openBuilder: (context, _) => HomeScreen(),
                    closedBuilder: (context, openContainer) {
                      return ListTile(
                        onTap: () {
                          openContainer();
                        },
                        title: Text(
                          "Help & Support",
                          style: TextStyle(fontSize: 20),
                        ),
                        leading: Icon(
                          Icons.help,
                          size: 26,
                          color: Colors.black,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 26,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: Duration(milliseconds: 700),
                    openBuilder: (context, _) => HomeScreen(),
                    closedBuilder: (context, openContainer) {
                      return ListTile(
                        onTap: () {
                          openContainer();
                        },
                        title: Text("About Us", style: TextStyle(fontSize: 20)),
                        leading: Icon(
                          Icons.info,
                          size: 26,
                          color: Colors.black,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 26,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 70),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      minimumSize: Size(200, 50),
                    ),
                    child: SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.logout), Text(" Logout")],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

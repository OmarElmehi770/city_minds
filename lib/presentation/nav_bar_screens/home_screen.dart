import 'package:animated_button/animated_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  bool led_val_1 = false;
  bool led_val_2 = false;
  bool gas_alert = false;
  bool flame_alert = false;
  String password = '1245';

  final databaseRef = FirebaseDatabase.instance.ref(); // root reference

  void writeData(Map<String, dynamic> data, String clas) {
    databaseRef.child("${clas}/").update(data);
  }

  void readData() {
    databaseRef.child("Security_system/").once().then((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF404F68),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/images/living_room_img.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          //Colors.blue.withOpacity(0.2), // شفاف من فوق
                          Color(0xFF404F68).withOpacity(0.2),
                          Color(0xFF5483B3).withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 8,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 166,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade500,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 72,
                                          width: 72,
                                          child: Image.asset(
                                            led_val_1
                                                ? 'assets/images/furniture_imgs/idea-bulb.png'
                                                : 'assets/images/furniture_imgs/light-bulb.png',
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          children: [
                                            SizedBox(height: 25),
                                            GestureDetector(
                                              onTap: () {
                                                led_val_1 = !led_val_1;
                                                setState(() {
                                                  writeData({
                                                    'led1': led_val_1,
                                                  }, 'Security_system');
                                                });
                                              },
                                              child: AnimatedContainer(
                                                duration: Duration(
                                                  milliseconds: 300,
                                                ),
                                                width: 60,
                                                height: 30,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color:
                                                      led_val_1
                                                          ? Colors.green[300]
                                                          : Colors.grey[700],
                                                ),
                                                child: Align(
                                                  alignment:
                                                      led_val_1
                                                          ? Alignment
                                                              .centerRight
                                                          : Alignment
                                                              .centerLeft,
                                                  child: Container(
                                                    width: 22,
                                                    height: 22,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8,
                                              ),
                                              child: Text(
                                                "${led_val_1 ? "on" : "off"}",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Room 1 Lights',
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 166,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade500,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 72,
                                          width: 72,
                                          child: Image.asset(
                                            led_val_2
                                                ? 'assets/images/furniture_imgs/idea-bulb.png'
                                                : 'assets/images/furniture_imgs/light-bulb.png',
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          children: [
                                            SizedBox(height: 25),
                                            GestureDetector(
                                              onTap: () {
                                                led_val_2 = !led_val_2;
                                                setState(() {
                                                  writeData({
                                                    'led2': led_val_2,
                                                  }, 'Security_system');
                                                });
                                              },
                                              child: AnimatedContainer(
                                                duration: Duration(
                                                  milliseconds: 300,
                                                ),
                                                width: 60,
                                                height: 30,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color:
                                                      led_val_2
                                                          ? Colors.green[300]
                                                          : Colors.grey[700],
                                                ),
                                                child: Align(
                                                  alignment:
                                                      led_val_2
                                                          ? Alignment
                                                              .centerRight
                                                          : Alignment
                                                              .centerLeft,
                                                  child: Container(
                                                    width: 22,
                                                    height: 22,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8,
                                              ),
                                              child: Text(
                                                "${led_val_2 ? "on" : "off"}",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Room 2 Lights',
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade500,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                'Main Alert',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                gas_alert = !gas_alert;
                                setState(() {
                                  writeData({
                                    'alarm_status': gas_alert,
                                  }, 'Security_system');
                                });
                              },
                              child: Row(
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 60,
                                    height: 30,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:
                                          gas_alert
                                              ? Colors.green[300]
                                              : Colors.grey[700],
                                    ),
                                    child: Align(
                                      alignment:
                                          gas_alert
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                      child: Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    gas_alert ? "ON" : "OFF",
                                    style: TextStyle(
                                      color:
                                          gas_alert
                                              ? Colors.red[300]
                                              : Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade500,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                'Flame Alert',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                flame_alert = !flame_alert;
                                setState(() {
                                  writeData({
                                    'flame_alert': flame_alert,
                                  }, 'Home_alert');
                                });
                              },
                              child: Row(
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 60,
                                    height: 30,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:
                                          flame_alert
                                              ? Colors.green[300]
                                              : Colors.grey[700],
                                    ),
                                    child: Align(
                                      alignment:
                                          flame_alert
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                      child: Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    flame_alert ? "ON" : "OFF",
                                    style: TextStyle(
                                      color:
                                          flame_alert
                                              ? Colors.red[300]
                                              : Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => StatefulBuilder(
                                  builder:
                                      (
                                        BuildContext context,
                                        void Function(void Function()) setState,
                                      ) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        backgroundColor: Colors.grey,
                                        content: Container(
                                          height: 370,
                                          width: double.infinity,
                                          child: Column(
                                            spacing: 12,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                height: 60,
                                                width: double.infinity,
                                                child: Center(
                                                  child: Text(
                                                    password,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  btn(
                                                    text: '<-',
                                                    onTap: () {
                                                      setState(() {
                                                        password = password
                                                          .substring(
                                                            0,
                                                            password.length -
                                                                1,
                                                          );
                                                      });
                                                    },
                                                    btnColor: Colors.red,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: 'Reset',
                                                    onTap: () {

                                                    },
                                                    btnColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    btnWidth: 100,
                                                  ),
                                                  btn(
                                                    text: '✔️',
                                                    onTap: () {
                                                      setState((){
                                                        writeData({'password':password}, 'Security_system');
                                                      });
                                                    },
                                                    btnColor: Colors.red,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  btn(
                                                    text: '1',
                                                    onTap: () {
                                                      password.length<6?
                                                      password += '1':null;
                                                      setState(() {});
                                                    },
                                                    btnColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: '2',
                                                    onTap: () {
                                                      password.length<6?
                                                      password += '2':null;
                                                      setState(() {});
                                                    },
                                                    btnColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: '3',
                                                    onTap: () {
                                                      password.length<6?
                                                      password += '3':null;
                                                      setState(() {});
                                                    },
                                                    btnColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: 'A',
                                                    onTap: () {},
                                                    btnColor: Colors.red,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  btn(
                                                    text: '4',
                                                    onTap: () {
                                                      password.length<6?
                                                      password += '4':null;
                                                      setState(() {});
                                                    },
                                                    btnColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: '5',
                                                    onTap: () {
                                                      password.length<6?
                                                      password += '5':null;
                                                      setState(() {});
                                                    },
                                                    btnColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: '6',
                                                    onTap: () {
                                                      password.length<6?
                                                      password += '6':null;
                                                      setState(() {});
                                                    },
                                                    btnColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: 'B',
                                                    onTap: () {},
                                                    btnColor: Colors.red,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  btn(
                                                    text: '7',
                                                    onTap: () {
                                                      password.length<6?
                                                      password += '7':null;
                                                      setState(() {});
                                                    },
                                                    btnColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: '8',
                                                    onTap: () {
                                                      password.length<6?
                                                      password += '8':null;
                                                      setState(() {});
                                                    },
                                                    btnColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: '9',
                                                    onTap: () {
                                                      password.length<6?
                                                      password += '9':null;
                                                      setState(() {});
                                                    },
                                                    btnColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: 'C',
                                                    onTap: () {},
                                                    btnColor: Colors.red,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  btn(
                                                    text: '*',
                                                    onTap: () {},
                                                    btnColor: Colors.red,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: '0',
                                                    onTap: () {},
                                                    btnColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: '#',
                                                    onTap: () {},
                                                    btnColor: Colors.red,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                  btn(
                                                    text: 'D',
                                                    onTap: () {},
                                                    btnColor: Colors.red,
                                                    textColor: Colors.white,
                                                    btnWidth: 50,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade500,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  'Enter Home Password',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Icon(Icons.arrow_forward, size: 40),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget btn({
  required String text,
  required Function() onTap,
  required Color btnColor,
  required Color textColor,
  required double btnWidth,
}) {
  return AnimatedButton(
    onPressed: onTap,
    color: btnColor,
    width: btnWidth,
    height: 50,
    shadowDegree: ShadowDegree.dark,
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

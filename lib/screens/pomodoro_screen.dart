import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_app/models/boxes.dart';
import 'package:pomodoro_app/models/pomodoro.dart';
import 'package:pomodoro_app/shared/constants.dart';

class PomodoroScreen extends StatefulWidget {
  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  var nameController = TextEditingController();
  var dateController = TextEditingController();

  int index = 0;
  bool pomodoroOff = true;
  int _seconds = 00;
  int _minutes = 1;
  Timer? _timer;
  var time = NumberFormat("00");

  void addPomodoro(String name, String date) {
    Pomodoro pomodoro = Pomodoro()
      ..date = date
      ..name = name;
    final box = Boxes.getPomodoros();
    box.add(pomodoro);
    print(pomodoro.name);
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _seconds = 0;
      _minutes = 25;
    }
  }

  void _toggleTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_seconds > 0) {
            _seconds--;
          } else {
            if (_minutes > 0) {
              _seconds = 59;
              _minutes--;
            } else {
              _timer!.cancel();
              print("Timer Complete");
            }
          }
        });
      });
    }
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 0.0,
        unselectedIconTheme: IconThemeData(
          opacity: 0.6,
        ),
        selectedIconTheme: IconThemeData(
          color: Colors.blueGrey,
          size: 50,
          opacity: 1,
        ),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.black,
        currentIndex: index,
        onTap: (int value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer, color: kHeavyPinkColor),
            label: 'Pomodoro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse_rounded, color: kHeavyPinkColor),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: kHeavyPinkColor),
            label: 'Settings',
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Text(
                  'Focus on your task',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromRGBO(52, 6, 39, 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 50),
                CircularPercentIndicator(
                  radius: 350.0,
                  lineWidth: 15.0,
                  percent: 0.7,
                  progressColor: kHeavyPinkColor,
                  arcType: ArcType.FULL,
                  arcBackgroundColor: kLightPinkColor,
                  backgroundColor: Colors.white,
                  circularStrokeCap: CircularStrokeCap.round,
                  // reverse: true,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${time.format(_minutes)}:${time.format(_seconds)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 60,
                              color: kHeavyPurpleColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Work',
                        style: TextStyle(
                          fontSize: 30,
                          color: kPomodoroColor,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: kHeavyPinkColor,
                        child: pomodoroOff == true
                            ? Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 40,
                              )
                            : Icon(
                                Icons.pause,
                                color: Colors.white,
                                size: 40,
                              ),
                      ),
                      onTap: () {
                        if (pomodoroOff == false) {
                          setState(() {
                            pomodoroOff = true;
                            _toggleTimer();
                          });
                        } else if (pomodoroOff == true) {
                          setState(() {
                            pomodoroOff = false;
                            _toggleTimer();
                          });
                        }
                      },
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: kHeavyPinkColor,
                        child: Icon(
                          Icons.stop,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _stopTimer();
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 400,
                            child: AlertDialog(
                              elevation: 0.5,
                              backgroundColor: Colors.white,
                              title: Text(
                                'Add Pomodoro',
                                style: TextStyle(
                                  color: kHeavyPinkColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kHeavyPinkColor,
                                          ),
                                        ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: kHeavyPinkColor,
                                            ),
                                          ),
                                          labelText: 'Name',
                                        labelStyle: TextStyle(
                                          color: kHeavyPinkColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      controller: nameController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter the name of the Pomodoro';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kHeavyPinkColor,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kHeavyPinkColor,
                                          ),
                                        ),
                                        labelText: 'Date',
                                        labelStyle: TextStyle(
                                          color: kHeavyPinkColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      controller: dateController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter the Date of the Pomodoro';
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        ///stops keyboard from appearing
                                        FocusScope.of(context).requestFocus(new FocusNode());
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2022-05-03'),
                                        ).then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);
                                        },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        dateController.clear();
                                        nameController.clear();
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: kHeavyPinkColor,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        addPomodoro(nameController.text, dateController.text);
                                        Navigator.pop(context);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: kHeavyPinkColor,
                                      ),
                                      child: Text(
                                        'Add',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        });
                  },
                  child: Text(
                    'Start a new Pomodoro',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: kHeavyPinkColor,
                    elevation: 0.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

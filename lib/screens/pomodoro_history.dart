import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro_app/models/boxes.dart';
import 'package:pomodoro_app/models/pomodoro.dart';
import 'package:pomodoro_app/shared/constants.dart';

class PomodoroHistory extends StatefulWidget {
  @override
  _PomodoroHistoryState createState() => _PomodoroHistoryState();
}

class _PomodoroHistoryState extends State<PomodoroHistory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<Pomodoro>>(
        valueListenable: Boxes.getPomodoros().listenable(),
        builder: (context, box, _) {

          final pomodoros = box.values.toList().cast<Pomodoro>();
          print(pomodoros);

          return Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) => Container(
                height: 0.6,
                color: Colors.grey[200],
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
              itemCount: 15,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kHeavyPinkColor,
                        kLightPinkColor,
                      ],
                      stops: [
                        0.5, 1,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Working', style: TextStyle(color: Colors.white, fontSize: 30)),
                      SizedBox(height: 10),
                      Text('Monday, 22 Jan', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

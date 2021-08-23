import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_app/cubit/cubit.dart';
import 'package:pomodoro_app/cubit/states.dart';
import 'package:pomodoro_app/shared/constants.dart';

class PomodoroScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PomodoroCubit, PomodoroStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PomodoroCubit.get(context);

        return SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: formKey,
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
                        color: kHeavyPurpleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 50),
                    CircularPercentIndicator(
                      percent: (cubit.totalSeconds - cubit.currentSeconds) / cubit.totalSeconds,
                      radius: 350.0,
                      lineWidth: 20.0,
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
                              TimerText(sec: cubit.currentSeconds),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Mostafa',
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
                            child: cubit.pomodoroOff == true
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
                            cubit.pauseOrPlay();
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
                            cubit.stopTimer();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TimerText extends StatelessWidget {
  final int sec;

  const TimerText({Key? key, required this.sec}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minutes = sec ~/ 60;
    final min = minutes < 10 ? '0' + minutes.toString() : minutes.toString();
    final seconds = sec % 60 < 10 ? '0' + (sec % 60).toString() : sec % 60;
    return Text(
      "$min:$seconds",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 60,
        color: kHeavyPurpleColor,
      ),
    );
  }
}

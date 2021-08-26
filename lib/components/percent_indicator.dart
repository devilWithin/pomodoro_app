import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_app/cubit/cubit.dart';

import 'timer_text.dart';

class PercentIndicator extends StatelessWidget {
  final Color progressColor;
  final Color arcBackgroundColor;
  final Color backgroundColor;

  const PercentIndicator({
    required this.cubit,
    required this.progressColor,
    required this.arcBackgroundColor,
    required this.backgroundColor,
  });

  final PomodoroCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      percent: (cubit.totalSeconds - cubit.currentSeconds) / cubit.totalSeconds,
      radius: 350.0,
      lineWidth: 20.0,
      progressColor: progressColor,
      arcType: ArcType.FULL,
      arcBackgroundColor: arcBackgroundColor,
      backgroundColor: backgroundColor,
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
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 30,
              letterSpacing: 1.0,
            ),
            // TextStyle(
            //   fontSize: 30,
            //   color: kPomodoroColor,
            //   letterSpacing: 1.0,
            //   fontWeight: FontWeight.w500,
            // ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
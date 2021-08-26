import 'package:flutter/material.dart';

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
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 60,
        fontWeight: FontWeight.w700,
      ),
      // TextStyle(
      //   fontWeight: FontWeight.w700,
      //   fontSize: 60,
      //   color: kHeavyPurpleColor,
      // ),
    );
  }
}
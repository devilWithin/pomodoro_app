import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/cubit/states.dart';
import 'package:pomodoro_app/models/boxes.dart';
import 'package:pomodoro_app/models/pomodoro.dart';
import 'package:pomodoro_app/screens/pomodoro_history.dart';
import 'package:pomodoro_app/screens/pomodoro_screen.dart';
import 'package:pomodoro_app/screens/settings_screen.dart';

class PomodoroCubit extends Cubit<PomodoroStates> {
  PomodoroCubit() : super(PomodoroInitialState());

  static PomodoroCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool pomodoroOff = true;
  late int currentSeconds = totalSeconds;
  int totalSeconds = 1500;
  Timer? timer;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  Widget screens() => [
        PomodoroScreen(),
        PomodoroHistory(),
        SettingsScreen(),
      ][currentIndex];

  void addPomodoro(String name) {
    Pomodoro pomodoro = Pomodoro()
      ..date = DateTime.now()
      ..name = name;
    final box = Boxes.getPomodoros();
    box.add(pomodoro);
  }

  void pauseOrPlay() {
    if (pomodoroOff == false) {
      pomodoroOff = true;
      toggleTimer();
    } else if (pomodoroOff == true) {
      pomodoroOff = false;
      toggleTimer();
    }
  }

  void stopTimer() {
    if (timer == null) {
      return null;
    } else {
      timer!.cancel();
      timer = null;
      pomodoroOff = true;
      currentSeconds = 1500;
      emit(TimerStopped());
      print('Timer stopped');
    }
  }

  void startTimer() {
    print('Timer Started');
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      emit(TimerStarted());
      currentSeconds--;
      if (currentSeconds <= 0) {
        timer.cancel();
        emit(TimerStopped());
      }

      // emit(TimerStarted());
      // print('Timer is working');
      // if (seconds > 0) {
      //   seconds--;
      // } else {
      //   if (minutes > 0) {
      //     seconds = 59;
      //     minutes--;
      //   } else {
      //     timer.cancel();
      //     pomodoroOff = true;
      //     emit(TimerStopped());
      //     print("Timer Complete");
      //   }
      // }
    });
  }

  void toggleTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
      emit(PomodoroIsPaused());
      print('Timer paused');
    } else if (timer == null) {
      startTimer();
      emit(PomodoroIsPlayed());
      print('Timer started');
    }
  }
}

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
  int seconds = 00;
  int minutes = 1;
  Timer? _timer;

  void changeIndex(int index) {
    currentIndex = index;
    print(currentIndex);
      emit(ChangeBottomNavBarState());
  }

  Widget screens() => [
    PomodoroScreen(),
    PomodoroHistory(),
    SettingsScreen(),
  ][currentIndex];

  void pauseOrPlay() {
    if (pomodoroOff == false) {
        pomodoroOff = true;
        toggleTimer();
    } else if (pomodoroOff == true) {
        pomodoroOff = false;
        toggleTimer();
    }
  }

  void addPomodoro(String name) {
    Pomodoro pomodoro = Pomodoro()
      ..date = DateTime.now()
      ..name = name;
    final box = Boxes.getPomodoros();
    box.add(pomodoro);
    print(pomodoro.name);
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      seconds = 0;
      minutes = 25;
    }
  }

  void toggleTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (seconds > 0) {
            seconds--;
          } else {
            if (minutes > 0) {
              seconds = 59;
              minutes--;
            } else {
              _timer!.cancel();
              print("Timer Complete");
            }
          }
      });
    }
  }
}
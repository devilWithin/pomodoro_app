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
  Timer? timer;
  double percent = 0.0;

  ///make it in a separate cubit
  void percentProgressIndicator() {
    timer = Timer.periodic(Duration(seconds: 15), (timer) {
      percent += 15;
      if(percent >= 100) {
        timer.cancel();
        emit(TimerStopped());
        print("Pomodoro Complete");
      }
    });
  }

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
    if(state is TimerReset) {
      return null;
    } else {
      emit(TimerReset());
      percent = 0.0;
      pomodoroOff = true;
      timer!.cancel();
      timer = null;
      seconds = 0;
      minutes = 25;
      print('Timer reset');
    }
  }

  void startTimer() {
    print('Timer Started');
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      emit(TimerStarted());
      print('Timer is working');
      if (seconds > 0) {
        seconds--;
      } else {
        if (minutes > 0) {
          seconds = 59;
          minutes--;
        } else {
          timer.cancel();
          emit(TimerStopped());
          print("Timer Complete");
        }
      }
    });
  }

  void toggleTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
      emit(PomodoroIsPaused());
      print('Timer paused');
    } else if(timer == null) {
      startTimer();
      emit(PomodoroIsPlayed());
      print('Timer started');
    }
  }
}
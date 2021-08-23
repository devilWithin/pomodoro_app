import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
  int totalSeconds = 10;
  Timer? timer;
  String finalTime = DateFormat.yMMMMd().format(DateTime.now());
  String clockMin = DateFormat('kk:mm a').format(DateTime.now());

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  Widget screens() => [
        PomodoroScreen(),
        PomodoroHistory(),
        SettingsScreen(),
      ][currentIndex];


  void addPomodoro() {
    Pomodoro pomodoro = Pomodoro()
      ..date = finalTime
      ..time = clockMin;
    final box = Boxes.getPomodoros();
    box.add(pomodoro);
  }

  void deletePomodoro(Pomodoro pomodoro) {
    pomodoro.delete().then((value) {
      emit(PomodoroDeleted());
    });
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
      currentSeconds = 10;
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
        addPomodoro();
        stopTimer();
        emit(TimerFinished());
      }
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

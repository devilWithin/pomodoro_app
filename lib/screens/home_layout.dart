import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/cubit/cubit.dart';
import 'package:pomodoro_app/cubit/states.dart';
import 'package:pomodoro_app/shared/constants.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PomodoroCubit, PomodoroStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
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
            currentIndex: PomodoroCubit.get(context).currentIndex,
            onTap: (int index) {
              PomodoroCubit.get(context).changeIndex(index);
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
          body: Builder(
            builder: (BuildContext context) {
              return PomodoroCubit.get(context).screens();
            },
          ),
        );
      },
    );
  }
}

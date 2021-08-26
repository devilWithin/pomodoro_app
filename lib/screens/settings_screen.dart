import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/cubit/cubit.dart';
import 'package:pomodoro_app/cubit/states.dart';
import 'package:pomodoro_app/shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PomodoroCubit, PomodoroStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PomodoroCubit.get(context);
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.dark_mode,
                      size: Theme.of(context).iconTheme.size,
                      color: cubit.isDark
                          ? Theme.of(context).iconTheme.color
                          : kHeavyPurpleColor,
                    ),
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dark Mode',
                        style: Theme.of(context).textTheme.bodyText1
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Adjust the appearance to reduce \nglare and give your eyes a break.',
                        style: TextStyle(
                          color: kPomodoroColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Switch(
                    value: cubit.isDark,
                    activeColor:  Colors.white,
                    activeTrackColor:  Colors.grey,
                    inactiveTrackColor: kPomodoroColor,
                    dragStartBehavior: DragStartBehavior.down,
                    onChanged: (value) {
                      cubit.changeAppMode();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

enum RadioTypes {
  DarkMode,
  LightMode,
}

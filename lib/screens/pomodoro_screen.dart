import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/components/percent_indicator.dart';
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 30),
                    ),
                    SizedBox(height: 50),
                    cubit.isDark
                        ? PercentIndicator(
                            cubit: cubit,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            progressColor: kHeavyPurpleColor,
                            arcBackgroundColor: Colors.white,
                          )
                        : PercentIndicator(
                            cubit: cubit,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            progressColor: kHeavyPinkColor,
                            arcBackgroundColor: kLightPinkColor,
                          ),
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: PomodoroCubit.get(context).isDark
                                ? Colors.grey[800]
                                : kHeavyPinkColor,
                            child: cubit.pomodoroOff == true
                                ? Icon(
                                    Icons.play_arrow,
                                    color: Theme.of(context).iconTheme.color,
                                    size: Theme.of(context).iconTheme.size,
                                  )
                                : Icon(
                                    Icons.pause,
                                    color: Theme.of(context).iconTheme.color,
                                    size: Theme.of(context).iconTheme.size,
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
                            backgroundColor: PomodoroCubit.get(context).isDark
                                ? Colors.grey[800]
                                : kHeavyPinkColor,
                            child: Icon(
                              Icons.stop,
                              color: Theme.of(context).iconTheme.color,
                              size: Theme.of(context).iconTheme.size,
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

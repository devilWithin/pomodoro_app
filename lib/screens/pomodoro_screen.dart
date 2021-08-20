import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_app/cubit/cubit.dart';
import 'package:pomodoro_app/cubit/states.dart';
import 'package:pomodoro_app/shared/constants.dart';

class PomodoroScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final time = NumberFormat("00");


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PomodoroCubit, PomodoroStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                      percent: PomodoroCubit.get(context).percent / 100,
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
                              Text(
                                "${time.format(PomodoroCubit.get(context).minutes)}:${time.format(PomodoroCubit.get(context).seconds)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 60,
                                  color: kHeavyPurpleColor,
                                ),
                              ),
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
                            child:
                                PomodoroCubit.get(context).pomodoroOff == true
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
                            PomodoroCubit.get(context).pauseOrPlay();
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
                            PomodoroCubit.get(context).stopTimer();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // TextButton(
                    //   onPressed: () {
                    //     showDialog(
                    //         barrierDismissible: false,
                    //         context: context,
                    //         builder: (context) {
                    //           return Container(
                    //             height: 400,
                    //             child: AlertDialog(
                    //               elevation: 0.5,
                    //               backgroundColor: Colors.white,
                    //               title: Text(
                    //                 'Add Pomodoro',
                    //                 style: TextStyle(
                    //                   color: kHeavyPinkColor,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //               content: Container(
                    //                 height: 200,
                    //                 child: Column(
                    //                   children: [
                    //                     TextFormField(
                    //                       decoration: InputDecoration(
                    //                         focusedBorder: OutlineInputBorder(
                    //                           borderSide: BorderSide(
                    //                             color: kHeavyPinkColor,
                    //                           ),
                    //                         ),
                    //                         enabledBorder: OutlineInputBorder(
                    //                           borderSide: BorderSide(
                    //                             color: kHeavyPinkColor,
                    //                           ),
                    //                         ),
                    //                         labelText: 'Name',
                    //                         labelStyle: TextStyle(
                    //                           color: kHeavyPinkColor,
                    //                           fontWeight: FontWeight.bold,
                    //                         ),
                    //                       ),
                    //                       controller: nameController,
                    //                       keyboardType: TextInputType.name,
                    //                       validator: (value) {
                    //                         if (value!.isEmpty) {
                    //                           return 'Please Enter the name of the Pomodoro';
                    //                         }
                    //                         return null;
                    //                       },
                    //                     ),
                    //                     SizedBox(height: 20),
                    //                   ],
                    //                 ),
                    //               ),
                    //               actions: [
                    //                 Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     TextButton(
                    //                       onPressed: () {
                    //                         Navigator.pop(context);
                    //                         nameController.clear();
                    //                       },
                    //                       style: TextButton.styleFrom(
                    //                         backgroundColor: Colors.white,
                    //                       ),
                    //                       child: Text(
                    //                         'Cancel',
                    //                         style: TextStyle(
                    //                           color: kHeavyPinkColor,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     TextButton(
                    //                       onPressed: () {
                    //                         PomodoroCubit.get(context)
                    //                             .startTimer();
                    //                         PomodoroCubit.get(context)
                    //                             .addPomodoro(
                    //                           nameController.text,
                    //                         );
                    //                         Navigator.pop(context);
                    //                       },
                    //                       style: TextButton.styleFrom(
                    //                         backgroundColor: kHeavyPinkColor,
                    //                       ),
                    //                       child: Text(
                    //                         'Add',
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //         });
                    //   },
                    //   child: Text(
                    //     'Start a new Pomodoro',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 22,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    //   style: TextButton.styleFrom(
                    //     backgroundColor: kHeavyPinkColor,
                    //     elevation: 0.0,
                    //   ),
                    // ),
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

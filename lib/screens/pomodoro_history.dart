import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro_app/cubit/cubit.dart';
import 'package:pomodoro_app/models/boxes.dart';
import 'package:pomodoro_app/models/pomodoro.dart';
import 'package:pomodoro_app/shared/constants.dart';

class PomodoroHistory extends StatefulWidget {
  @override
  _PomodoroHistoryState createState() => _PomodoroHistoryState();
}

class _PomodoroHistoryState extends State<PomodoroHistory> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Pomodoro>>(
      valueListenable: Boxes.getPomodoros().listenable(),
      builder: (context, box, _) {
        final pomodoros = box.values.toList().cast<Pomodoro>();
        return pomodoros.length == 0
            ? Center(
                child: Text(
                  'No Pomodoros Completed Yet!',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Colors.grey[300],
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  itemCount: pomodoros.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            PomodoroCubit.get(context).isDark ? Colors.black : kHeavyPinkColor,
                            PomodoroCubit.get(context).isDark ? Colors.white : kLightPinkColor,
                          ],
                          stops: [
                            0.5,
                            1,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.timer,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${pomodoros[index].date}',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${pomodoros[index].time}',
                                style: Theme.of(context).textTheme.bodyText1,
                                // TextStyle(
                                //   color: kHeavyPurpleColor,
                                //   fontWeight: FontWeight.w500,
                                // ),
                              ),
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.delete,
                                size: Theme.of(context).iconTheme.size,
                                color: kHeavyPurpleColor,
                              ),
                            ),
                            onTap: () {
                              PomodoroCubit.get(context).deletePomodoro(pomodoros[index]);
                            },
                          ),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro_app/cubit/cubit.dart';
import 'package:pomodoro_app/models/pomodoro.dart';
import 'package:pomodoro_app/screens/home_layout.dart';
import 'package:pomodoro_app/shared/constants.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PomodoroAdapter());
  await Hive.openBox<Pomodoro>('pomodoros');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PomodoroCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // CUSTOMIZE showDatePicker Colors
          colorScheme: ColorScheme.light(primary: kHeavyPinkColor),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        home: HomeLayout(),
      ),
    );
  }
}

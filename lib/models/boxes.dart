import 'package:hive/hive.dart';
import 'package:pomodoro_app/models/pomodoro.dart';

class Boxes {
  static Box<Pomodoro> getPomodoros() =>
      Hive.box<Pomodoro>('pomodoros');
}
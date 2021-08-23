import 'package:hive/hive.dart';

part 'pomodoro.g.dart';

@HiveType(typeId: 0)
class Pomodoro extends HiveObject {

  @HiveField(0)
  late String date;

  @HiveField(1)
  late String time;

}
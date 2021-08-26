abstract class PomodoroStates {}

class PomodoroInitialState extends PomodoroStates {}

class ChangeBottomNavBarState extends PomodoroStates {}

class TimerStarted extends PomodoroStates {}

class TimerStopped extends PomodoroStates {}

class PomodoroIsPaused extends PomodoroStates {}

class PomodoroIsPlayed extends PomodoroStates {}

class TimerFinished extends PomodoroStates {}

class PomodoroDeleted extends PomodoroStates {}

class ChangeAppMode extends PomodoroStates {}
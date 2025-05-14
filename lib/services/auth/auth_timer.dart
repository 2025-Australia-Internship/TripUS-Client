import 'dart:async';

class AuthTimer {
  late int secondsRemaining;
  Timer? _timer;
  Function(int)? onTick;
  Function? onTimeout;

  AuthTimer({
    this.onTick,
    this.onTimeout,
  });

  // 타이머 감소
  void start({int duration = 180}) {
    secondsRemaining = duration;
    _timer?.cancel(); // 기존 타이머 정지

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        if (onTick != null) onTick!(secondsRemaining); // 시간표시를 갱신
      } else {
        timer.cancel();
        if (onTimeout != null) onTimeout!();
      }
    });
  }

  // 타이머 정지
  void cancel() {
    _timer?.cancel();
  }

  // 타이머 시간 포맷팅
  String formatTime() {
    final minutes = (secondsRemaining ~/ 60).toString();
    final sec = (secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$sec';
  }

  // 타이머가 실행되고 있는지
  bool get isRunning => _timer?.isActive ?? false;
}

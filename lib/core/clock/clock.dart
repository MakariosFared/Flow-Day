abstract interface class Clock {
  DateTime now();
}

class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now();
}

class FakeClock implements Clock {
  FakeClock(this._currentTime);

  DateTime _currentTime;

  @override
  DateTime now() => _currentTime;

  void setTime(DateTime time) {
    _currentTime = time;
  }

  void advance(Duration duration) {
    _currentTime = _currentTime.add(duration);
  }
}

import 'dart:async';

typedef DebounceAction = FutureOr<void> Function();

/// Debounces all [run] calls using [delay].
class Debouncer {
  Debouncer(this.delay);

  final Duration delay;

  Timer? _timer;

  /// `true` while [run] is executing its [DebounceAction].
  bool get isRunningAction => _isRunningAction;
  var _isRunningAction = false;

  /// Runs [action] after [delay] duration.
  ///
  /// [action] will only run if there is no subsequent calls to [run] **before** [delay] has elapsed. If there are any
  /// calls to [run] **before** [delay] duration, it will not execute the previous [DebounceAction] call.
  void run(DebounceAction action) {
    _timer?.cancel();
    _timer = Timer(delay, () async {
      _isRunningAction = true;
      await action();
      _isRunningAction = false;
    });
  }

  void cancelOngoingAction() {
    _timer?.cancel();
  }
}

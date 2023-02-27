import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _fabstatus = BehaviorSubject<bool>();
  Stream<bool> get fab => _fabstatus.stream;
  Function(bool) get changeFab => _fabstatus.sink.add;

  void dispose() {
    _fabstatus.close();
  }
}

final homeBloc = HomeBloc();
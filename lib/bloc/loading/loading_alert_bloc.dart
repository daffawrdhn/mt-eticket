
import 'package:rxdart/rxdart.dart';

class LoadingAlertBloc {
  final _isAlertShow = BehaviorSubject<bool>.seeded(false);
  final _alertType = BehaviorSubject<String>();
  final _alertMessage = BehaviorSubject<String>();

  Stream<bool> get isLoading => _isAlertShow.stream;
  Stream<String> get alertType => _alertType.stream;
  Stream<String> get alertMessage => _alertMessage.stream;
  Function(bool) get updateLoading => _isAlertShow.sink.add;
  Function(String) get updateAlertMessage => _alertMessage.sink.add;
  Function(String) get updateAlertType => _alertType.sink.add;

  String get getAlertType => _alertType.value;
  String get getAlertMessage => _alertMessage.value;
  bool get getAlertLoading => _isAlertShow.value;

  resetBloc(){
    _isAlertShow.sink.add(false);
    _alertMessage.sink.add(null);
    _alertType.sink.add(null);
  }

  dispose() {
    _isAlertShow.close();
    _alertType.close();
    _alertMessage.close();
  }
}

final loadingAlertBloc = LoadingAlertBloc();
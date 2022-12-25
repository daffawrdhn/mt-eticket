import 'package:rxdart/rxdart.dart';

class ErrorBloc {
  final _errMsg = BehaviorSubject<String>();

  Function(String) get updateErrMsg => _errMsg.sink.add;
  Stream<String> get errMsg => _errMsg.stream;
  String get getErrMsg => _errMsg.value;

  resetBloc(){
    _errMsg.sink.add(null);
  }

  resetImage(){
    _errMsg.sink.add("");
  }

  dispose() {
    _errMsg.close();
  }

}

final errorBloc = ErrorBloc();
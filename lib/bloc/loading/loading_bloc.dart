import 'package:rxdart/rxdart.dart';

class LoadingBloc {
  final _isLoading = BehaviorSubject<bool>();
  Stream<bool> get isLoading => _isLoading.stream;
  Function(bool) get updateLoading => _isLoading.sink.add;

  resetBloc(){
    _isLoading.sink.add(false);
  }

  dispose() {
    _isLoading.close();
  }
}

final loadingBloc = LoadingBloc();
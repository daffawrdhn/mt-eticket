import 'package:mt/data/local/app_data.dart';
import 'package:mt/data/sharedpref/preferences.dart';
import 'package:rxdart/rxdart.dart';

class LogoutBloc {
  final _isLogoutButton = BehaviorSubject<bool>();
  Stream<bool> get isLogoutButton => _isLogoutButton.stream;
  Function(bool) get updateLogoutButton => _isLogoutButton.sink.add;

  Future logout() async {
      Prefs.setIsLogin(false);
      Prefs.clear();
  }

  resetLogout(){
    _isLogoutButton.sink.add(false);
  }

  dispose() {
    _isLogoutButton.close();
  }
}

final logoutBloc = LogoutBloc();
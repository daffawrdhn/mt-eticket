import 'package:mt/data/local/app_data.dart';
import 'package:mt/data/sharedpref/preferences.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _selectedIndexSubject = BehaviorSubject<int>();
  Stream<int> get selectedIndexStream => _selectedIndexSubject.stream;
  int get selectedIndex => _selectedIndexSubject.value;

  void onItemTapped(int index) {
    _selectedIndexSubject.add(index);
  }

  void dispose() {
    _selectedIndexSubject.close();
  }
}

final homeBloc = HomeBloc();
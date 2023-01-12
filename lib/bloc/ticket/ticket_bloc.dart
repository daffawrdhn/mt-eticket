import '../../data/local/app_data.dart';
import 'package:rxdart/rxdart.dart';

class TicketBloc extends Object {

  final _pic = BehaviorSubject<String>();
  final _helpdesk = BehaviorSubject<String>();

  Stream<String> get pic => _pic.stream;
  Stream<String> get helpdesk => _helpdesk.stream;

  Function(String) get changePic => _pic.sink.add;
  Function(String) get changeHelpdesk => _helpdesk.sink.add;

  resetBloc() {
    appData.setErrMsg("");
    _pic.sink.add(null);
    _helpdesk.sink.add(null);
  }

  resetResponse() {
    appData.setErrMsg('');
  }

  dispose() {
    _pic.close();
    _helpdesk.close();
  }
}
final ticketBloc = TicketBloc();
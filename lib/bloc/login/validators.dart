import 'dart:async';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if(email != null){
          if (email.contains('@')) {
            sink.add(email);
          } else {
            sink.addError('Enter a valid email');
          }
        }
      }
  );

  final validateNik = StreamTransformer<String, String>.fromHandlers(
      handleData: (nik, sink) {
        if(nik != null){
          if (nik.contains(RegExp(r'^(?=.*?[0-9]).{8,9}$'))) {
            sink.add(nik);
          } else {
            sink.addError('Nik must be at least 8 - 9 digits');
          }
        }
      }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if(password != null){
          if (password.contains(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?["|/?~`!@#$%^&*().,;:<>_+={}-]).{8,12}$'))) {
            sink.add(password);
          } else {
            sink.addError('Password doesn`t meet criteria');
          }
        }
      }
  );
}
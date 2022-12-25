import 'dart:async';

class Validators {
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

  final validateKtp = StreamTransformer<String, String>.fromHandlers(
      handleData: (ktp, sink) {
        if(ktp != null){
          if (ktp.contains(RegExp(r'^(?=.*?[0-9]).{16,}$'))) {
            sink.add(ktp);
          } else {
            sink.addError('KTP Must be 16 Digits');
          }
        }
      }
  );

  final validateBirth = StreamTransformer<String, String>.fromHandlers(
      handleData: (birth, sink) {
        if(birth != null){
          if (birth.contains(RegExp(r'^(?=.*?[0-9])(?=.*?[-]).{8,11}$'))) {
            sink.add(birth);
          } else {
            sink.addError('Date doesn`t meet criteria');
          }
        }
      }
  );
}
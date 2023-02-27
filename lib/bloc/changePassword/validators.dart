
import 'dart:async';
class Validators {
  String _password;

  StreamTransformer<String, String> get validatePassword {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (password, sink) {
          if(password != null){
            if (password.contains(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?["|/?~`!@#$%^&*().,;:<>_+={}-]).{8,12}$'))) {
              _password = password;
              sink.add(password);
            } else {
              sink.addError('Password doesnt meet criteria!');
            }
          }
        }
    );
  }

  StreamTransformer<String, String> get validateConfirmPassword {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (confirmPassword, sink) {
          if (confirmPassword != null) {
            if (confirmPassword == _password) {
              sink.add(confirmPassword);
            } else {
              sink.addError('Passwords do not match');
            }
          }
        }
    );

  }
}
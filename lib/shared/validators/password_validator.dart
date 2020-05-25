//const String _kMin8CharsOneLetterOneNumber = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
//const String _kMin8CharsOneLetterOneNumberOnSpecialCharacter = r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
//const String _kMin8CharsOneUpperLetterOneLowerLetterOnNumber = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$";
import 'dart:async';

import 'package:flutter/cupertino.dart';

const String _kMin8CharsOneUpperOneLowerOneNumberOneSpecial =
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
//const String _kMin8Max10OneUpperOneLowerOneNumberOneSpecial = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,10}$";

class PasswordValidator {
  final StreamTransformer<String, String> validatePassword =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    final RegExp passwordExp =
        RegExp(_kMin8CharsOneUpperOneLowerOneNumberOneSpecial);
    debugPrint('password $password');

    if (password.length < 3) {
      sink.addError('Enter a valid password');
    } else {
      sink.add(password);
    }

    // if (!passwordExp.hasMatch(password)) {
    //   sink.addError('Enter a valid password');
    // } else {
    //   sink.add(password);
    // }
  });
}

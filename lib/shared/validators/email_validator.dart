import 'dart:async';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class EmailValidator {
  final StreamTransformer<String, String> validateEmail =
      StreamTransformer.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = RegExp(_kEmailRule);
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      sink.addError('Enter a valid email');
    } else {
      sink.add(email);
    }
  });
}

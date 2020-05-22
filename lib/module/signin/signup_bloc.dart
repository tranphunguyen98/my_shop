import 'package:flutter/foundation.dart';
import 'package:my_shop/base/base_bloc.dart';
import 'package:my_shop/base/base_event.dart';
import 'package:my_shop/data/repo/user_repo.dart';
import 'package:my_shop/event/signup_event.dart';

class SignUpBloc extends BaseBloc {
  final UserRepo _userRepo;

  SignUpBloc({@required UserRepo userRepo}) : _userRepo = userRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case SignUpEvent:
        handleSignUp(event);
        break;
    }
  }

  void handleSignUp(BaseEvent event) {
    if (event is SignUpEvent) {
      _userRepo.signUp(event.email, event.pass).then(
        (value) => debugPrint(value),
        onError: (e) {
          debugPrint(e.toString());
        },
      );
    }
  }
}

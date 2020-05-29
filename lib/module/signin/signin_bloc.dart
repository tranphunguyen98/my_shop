import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:my_shop/base/base_bloc.dart';
import 'package:my_shop/base/base_event.dart';
import 'package:my_shop/data/repo/user_repo.dart';
import 'package:my_shop/event/singin_event.dart';
import 'package:my_shop/shared/validators/email_validator.dart';
import 'package:my_shop/shared/validators/password_validator.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc extends BaseBloc with EmailValidator, PasswordValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  final StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  UserRepo _userRepo;

  SignInBloc({@required UserRepo userRepo}) {
    _userRepo = userRepo;
    _eventStreamController.stream.listen((event) {
      dispatchEvent(event);
    });
  }

  // Input
  Function(BaseEvent) get onEventChanged => _eventStreamController.add;

  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;

  // Validators
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get signInValid =>
      CombineLatestStream.combine2(email, password, (email, pass) => true);

  void _handleSignIn(SignInEvent event) {
    _userRepo.signIn(event.email, event.pass);
  }

  @override
  void dispose() {
    debugPrint('sign in bloc dispose');
    super.dispose();
    _emailController?.close();
    _passwordController?.close();
    _eventStreamController?.close();
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is SignInEvent) {
      _handleSignIn(event);
    }
  }
}

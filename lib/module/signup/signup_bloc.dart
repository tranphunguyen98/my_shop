import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:my_shop/base/base_bloc.dart';
import 'package:my_shop/base/base_event.dart';
import 'package:my_shop/data/repo/user_repo.dart';
import 'package:my_shop/event/signup_event.dart';
import 'package:my_shop/shared/validators/email_validator.dart';
import 'package:my_shop/shared/validators/password_validator.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends BaseBloc with EmailValidator, PasswordValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _passwordConfirmController = BehaviorSubject<String>();

  final StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  UserRepo _userRepo;

  SignUpBloc({@required UserRepo userRepo}) {
    _userRepo = userRepo;
    _eventStreamController.stream.listen((event) {
      dispatchEvent(event);
    });
  }

  // Input
  Function(BaseEvent) get onEventChanged => _eventStreamController.add;

  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;
  Function(String) get onConfirmPasswordChanged =>
      _passwordConfirmController.sink.add;

  // Validators
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<String> get comfirmPassword =>
      CombineLatestStream.combine2<String, String, String>(
        _passwordController.stream,
        _passwordConfirmController.stream.transform(validatePassword),
        (pass, confirmPassword) {
          if (confirmPassword.isNotEmpty && pass != confirmPassword) {
            _passwordConfirmController.addError('No Match');
          }
          return confirmPassword;
        },
      );

  Stream<bool> get registerValid => CombineLatestStream.combine3(
      email, password, comfirmPassword, (email, pass, confirmPass) => true);

  void _handleSignUp(SignUpEvent event) {
    _userRepo.signUp(event.email, event.pass);
  }

  @override
  void dispose() {
    debugPrint('sign up bloc dispose');
    super.dispose();
    _emailController?.close();
    _passwordController?.close();
    _passwordConfirmController?.close();
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is SignUpEvent) {
      _handleSignUp(event);
    }
  }
}

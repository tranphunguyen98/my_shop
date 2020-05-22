import 'package:flutter/foundation.dart';
import 'package:my_shop/base/base_event.dart';

class SignUpEvent extends BaseEvent {
  String email;
  String pass;

  SignUpEvent({@required this.email, @required this.pass});
}

import 'package:flutter/material.dart';
import 'package:my_shop/event/singin_event.dart';
import 'package:my_shop/module/signin/signin_bloc.dart';
import 'package:provider/provider.dart';

import '../../base/base_widget.dart';
import '../../data/remote/user_service.dart';
import '../../data/repo/user_repo.dart';
import '../../shared/animations/fade_animation.dart';
import '../../shared/constant.dart';
import '../../shared/style/styles.dart';
import '../../shared/widget/divider_text_field.dart';
import '../../shared/widget/normal_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider<UserService>(
          create: (context) => UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
        ),
        ProxyProvider<UserRepo, SignInBloc>(
          update: (context, userRepo, previous) =>
              SignInBloc(userRepo: userRepo),
        )
      ],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildTopBackground(),
            const SignInFormWidget(),
          ],
        ),
      ),
    );
  }

  Container _buildTopBackground() {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            kImageBackgroundLogin,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 30,
            height: 160,
            child: FadeAnimation(
              delay: 1.3,
              child: Image.asset(
                kImageLight1,
              ),
            ),
          ),
          Positioned(
            left: 130,
            height: 120,
            child: FadeAnimation(
              delay: 1.5,
              child: Image.asset(
                kImageLight2,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 30,
            width: 64,
            child: FadeAnimation(
              delay: 1.6,
              child: Image.asset(
                kImageClock,
              ),
            ),
          ),
          const Positioned(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Center(
                child: Text(
                  'Sign In',
                  style: kTextStyleTitleXLarge,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SignInFormWidget extends StatefulWidget {
  const SignInFormWidget({
    Key key,
  }) : super(key: key);

  @override
  _SignInFormWidgetState createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  TextEditingController _emailTextController;
  TextEditingController _passwordTextController;

  @override
  void initState() {
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInBloc>(
      builder: (context, bloc, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          children: <Widget>[
            FadeAnimation(
              delay: 1.8,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: kBoxDecorationNormal,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(bloc),
                    const DividerTextField(),
                    _buildPasswordTextField(bloc),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder<bool>(
                initialData: false,
                stream: bloc.signInValid,
                builder: (context, snaphot) {
                  return NormalButton(
                    title: 'Sign In',
                    onPressed: () {
                      bloc.event.add(
                        SignInEvent(
                          email: _emailTextController.text,
                          pass: _passwordTextController.text,
                        ),
                      );
                    },
                    isEnable: snaphot.data ?? false,
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            _buildForgotPassword(),
            const SizedBox(
              height: 30,
            ),
            _buildRowLogin(context)
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextField(SignInBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.email,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _emailTextController,
            onChanged: (value) {
              bloc.onEmailChanged(value);
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Email or Phone number",
                errorText: snapshot.error?.toString(),
                hintStyle: kTextHint),
          ),
        );
      },
    );
  }

  Widget _buildPasswordTextField(SignInBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.password,
      builder: (context, snapshot) {
        debugPrint(snapshot.error.toString());
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _passwordTextController,
            obscureText: true,
            onChanged: (value) {
              bloc.onPasswordChanged(value);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Password",
              errorText: snapshot.error?.toString(),
              hintStyle: kTextHint,
            ),
          ),
        );
      },
    );
  }
}

SizedBox _buildForgotPassword() {
  return SizedBox(
    width: double.infinity,
    child: GestureDetector(
      onTap: () {
        // print('forgot?');
      },
      child: const FadeAnimation(
        delay: 1.5,
        child: Text(
          "Forgot Password?",
          textAlign: TextAlign.end,
          style: TextStyle(
            color: primaryColor,
          ),
        ),
      ),
    ),
  );
}

Widget _buildRowLogin(BuildContext context) {
  return FadeAnimation(
    delay: 1.5,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Already have an Account?"),
        const SizedBox(
          width: 8.0,
        ),
        GestureDetector(
          onTap: () {
            // print('login');
          },
          child: FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, kSignUpRoute);
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

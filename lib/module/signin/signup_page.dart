import 'package:flutter/material.dart';
import 'package:my_shop/base/base_widget.dart';
import 'package:my_shop/data/remote/user_service.dart';
import 'package:my_shop/data/repo/user_repo.dart';
import 'package:my_shop/event/signup_event.dart';
import 'package:my_shop/module/signin/signup_bloc.dart';
import 'package:my_shop/shared/animations/fade_animation.dart';
import 'package:my_shop/shared/constant.dart';
import 'package:my_shop/shared/style/styles.dart';
import 'package:my_shop/shared/widget/divider_text_field.dart';
import 'package:my_shop/shared/widget/normal_button.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
        ProxyProvider<UserRepo, SignUpBloc>(
          update: (context, userRepo, previous) =>
              SignUpBloc(userRepo: userRepo),
        )
      ],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildTopBackground(),
            const SignUpFormWidget(),
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
                  'Sign Up',
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

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key key,
  }) : super(key: key);

  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  TextEditingController _emailTextController;
  TextEditingController _passwordTextController;
  // final _confirmPasswordTextController = TextEditingController();

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
    return Consumer<SignUpBloc>(
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
                    _buildEmailTextField(),
                    const DividerTextField(),
                    _buildPasswordTextField(),
                    const DividerTextField(),
                    _buildConfirmPasswordTextField(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            NormalButton(
              title: 'Sign Up',
              onPressed: () {
                bloc.event.add(
                  SignUpEvent(
                    email: _emailTextController.text,
                    pass: _passwordTextController.text,
                  ),
                );
              },
              isEnable: true,
            ),
            const SizedBox(
              height: 20,
            ),
            _buildForgotPassword(),
            const SizedBox(
              height: 30,
            ),
            _buildRowLogin()
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _emailTextController,
        onChanged: (value) {},
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Email or Phone number",
            hintStyle: kTextHint),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _passwordTextController,
        obscureText: true,
        onChanged: (value) {},
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Password",
          hintStyle: kTextHint,
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        obscureText: true,
        onChanged: (value) {},
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Confirm Password",
          hintStyle: kTextHint,
        ),
      ),
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

Widget _buildRowLogin() {
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
          child: const Text(
            "Login",
            style: TextStyle(
              color: primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}

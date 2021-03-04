import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/login_bloc.dart';
import 'package:flutter_app/bloc/login_event.dart';
import 'package:flutter_app/bloc/login_state.dart';
import 'package:flutter_app/model/login_model.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/style/colors.dart' as Style;
import 'package:flutter_app/utils/navigators.dart';
import 'package:flutter_app/widgets/snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPass;

  @override
  void initState() {
    super.initState();
    showPass = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Style.Colors.primaryColor,
        appBar: AppBar(
          backgroundColor: Style.Colors.primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 20.0,
            onPressed: () {},
          ),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            print('$state OK');
            if (state is LoginSuccess) {
              pushName(context, HomeScreen.routeName);
              //move to home screen
            } else if (state is LoginInvalidData) {
              return showSnackBar(context, state.loginResponseModel.message);
            } else if (state is LoginInvalidEmail) {
              return showSnackBar(context, 'Invalid Email');
            } else if (state is LoginEmptyPassword) {
              return showSnackBar(context, 'You should enter a password');
            } else if (state is LoginError) {
              showSnackBar(context, 'Error has occurred');
            }
          },
          builder: (context, state) {
            LoginBloc loginBLoc = BlocProvider.of(context);
            return buildSingleChildScrollView(context, loginBLoc, state);
          },
        ),
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(
      BuildContext context, LoginBloc loginBLoc, LoginState loginState) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.0,
          ),
          Container(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 80.0,
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
            child: Container(
              color: Style.Colors.primaryDarkColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Style.Colors.textColor,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: TextFormField(
                      controller: emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: InputDecoration(
                        // labelText: 'Email Address',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        labelStyle: TextStyle(
                          color: Style.Colors.textColor,
                        ),
                        hintText: 'Email Address',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        color: Style.Colors.textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          controller: passwordController,
                          autofocus: false,
                          obscureText: showPass,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              color: Colors.grey,
                              icon: showPass
                                  ? Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: Style.Colors.accentColor,
                                    )
                                  : Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Style.Colors.accentColor,
                                    ),
                              onPressed: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintText: 'password',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          style: TextStyle(
                            color: Style.Colors.textColor,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text('Forgot Password?'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  loginState is LoginLoading
                      ? CircularProgressIndicator(
                          strokeWidth: 5,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                            Style.Colors.accentColor,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 32.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: () {
                                loginBLoc.add(
                                  LoginPressed(
                                    loginModel: LoginModel(
                                        emailAddressController.text,
                                        passwordController.text),
                                  ),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: Style.Colors.accentColor,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Style.Colors.primaryColor,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'I\'m a new user. ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Style.Colors.textColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          return showSnackBar(context, 'Sign Up Clicked');
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Style.Colors.accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

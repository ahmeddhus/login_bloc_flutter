import 'package:equatable/equatable.dart';
import 'package:flutter_app/model/login_response_model.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginUninitialized extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseModel loginResponseModel;

  LoginSuccess({this.loginResponseModel});

  @override
  List<Object> get props => [loginResponseModel];
}

class LoginInvalidData extends LoginState {
  final LoginResponseModel loginResponseModel;

  LoginInvalidData({this.loginResponseModel});

  @override
  List<Object> get props => [loginResponseModel];
}

class LoginInvalidEmail extends LoginState {}

class LoginEmptyPassword extends LoginState {}

//Something in the API (maybe)
class LoginError extends LoginState {}

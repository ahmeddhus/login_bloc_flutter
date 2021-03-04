import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/login_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginPressed extends LoginEvent {
  final LoginModel loginModel;

  LoginPressed({@required this.loginModel});

  @override
  List<Object> get props => [loginModel];
}

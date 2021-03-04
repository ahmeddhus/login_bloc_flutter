import 'package:flutter_app/bloc/login_event.dart';
import 'package:flutter_app/bloc/login_state.dart';
import 'package:flutter_app/model/login_response_model.dart';
import 'package:flutter_app/repository/login_repository.dart';
import 'package:flutter_app/utils/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginUninitialized());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPressed) {
      yield* login(event);
    }
  }
}

Stream<LoginState> login(LoginPressed event) async* {
  yield LoginLoading();

  if (validatorEmail(event.loginModel.emailAddress) != null) {
    yield LoginInvalidEmail();
  } else if (validatorRequired(event.loginModel.password) != null) {
    yield LoginEmptyPassword();
  } else {
    LoginResponseModel loginResponseModel =
        await LoginRepository.logIn(loginModel: event.loginModel);

    if (loginResponseModel.status != null) {
      if (loginResponseModel.status == 200) {
        yield LoginSuccess(loginResponseModel: loginResponseModel);
      } else if (loginResponseModel.status == 404) {
        yield LoginInvalidData(loginResponseModel: loginResponseModel);
      }
    } else if (validatorRequired(event.loginModel.password) != null) {
      yield LoginError();
    }
  }
}

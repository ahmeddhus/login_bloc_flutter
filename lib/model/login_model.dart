import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  @JsonKey(name: 'email_address')
  String emailAddress;
  @JsonKey(name: 'password')
  String password;


  LoginModel(this.emailAddress, this.password);

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
    _$LoginModelFromJson(json);

Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

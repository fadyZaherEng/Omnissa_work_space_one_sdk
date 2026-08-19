import 'package:json_annotation/json_annotation.dart';

part 'request_login.g.dart';

@JsonSerializable()
class RequestLogin {
  @JsonKey(name: 'grant_type')
  final String? grantType;
  @JsonKey(name: 'client_id')
  final String? clientId;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'client_secret')
  final String? clientSecret;
  @JsonKey(name: 'scope')
  final String? scope;

  const RequestLogin({
    required this.grantType,
    required this.clientId,
    required this.username,
    required this.password,
    required this.clientSecret,
    required this.scope,
  });

  factory RequestLogin.fromJson(Map<String, dynamic> json) =>
      _$RequestLoginFromJson(json);

  Map<String, dynamic> toJson() => _$RequestLoginToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/login/login.dart';

part 'remote_login.g.dart';

@JsonSerializable()
class RemoteLogin {
  @JsonKey(name: 'token_type')
  final String? tokenType;
  final String? scope;
  @JsonKey(name: 'expires_in')
  final int? expiresIn;
  @JsonKey(name: 'ext_expires_in')
  final int? extExpiresIn;
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @JsonKey(name: 'id_token')
  final String? idToken;

  const RemoteLogin({
    this.tokenType = '',
    this.scope = '',
    this.expiresIn = 0,
    this.extExpiresIn = 0,
    this.accessToken = '',
    this.refreshToken = '',
    this.idToken = '',
  });

  factory RemoteLogin.fromJson(Map<String, dynamic> json) =>
      _$RemoteLoginFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteLoginToJson(this);
}

extension RemoteLoginExtension on RemoteLogin {
  Login mapToLogin() => Login(
        accessToken: accessToken ?? '',
        refreshToken: refreshToken ?? '',
        expiresIn: expiresIn ?? 0,
        extExpiresIn: extExpiresIn ?? 0,
        tokenType: tokenType ?? '',
        scope: scope ?? '',
        idToken: idToken ?? '',
      );
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteLogin _$RemoteLoginFromJson(Map<String, dynamic> json) => RemoteLogin(
      tokenType: json['token_type'] as String? ?? '',
      scope: json['scope'] as String? ?? '',
      expiresIn: (json['expires_in'] as num?)?.toInt() ?? 0,
      extExpiresIn: (json['ext_expires_in'] as num?)?.toInt() ?? 0,
      accessToken: json['access_token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
      idToken: json['id_token'] as String? ?? '',
    );

Map<String, dynamic> _$RemoteLoginToJson(RemoteLogin instance) =>
    <String, dynamic>{
      'token_type': instance.tokenType,
      'scope': instance.scope,
      'expires_in': instance.expiresIn,
      'ext_expires_in': instance.extExpiresIn,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'id_token': instance.idToken,
    };

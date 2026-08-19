// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestLogin _$RequestLoginFromJson(Map<String, dynamic> json) => RequestLogin(
      grantType: json['grant_type'] as String?,
      clientId: json['client_id'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      clientSecret: json['client_secret'] as String?,
      scope: json['scope'] as String?,
    );

Map<String, dynamic> _$RequestLoginToJson(RequestLogin instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'client_id': instance.clientId,
      'username': instance.username,
      'password': instance.password,
      'client_secret': instance.clientSecret,
      'scope': instance.scope,
    };

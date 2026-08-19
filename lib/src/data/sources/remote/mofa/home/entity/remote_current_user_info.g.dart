// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_current_user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCurrentUserInfo _$RemoteCurrentUserInfoFromJson(
        Map<String, dynamic> json) =>
    RemoteCurrentUserInfo(
      id: json['id'] as String?,
      delegateId: json['delegateId'] as String?,
      userGroups: json['userGroups'] as List<dynamic>?,
      userName: json['userName'] as String?,
      userEmail: json['userEmail'] as String?,
      userEmailAccessRequest: json['userEmailAccessRequest'] as String?,
      userDelgateEmail: json['userDelgateEmail'] as String?,
      userDelgateName: json['userDelgateName'] as String?,
      isHaveDelgate: json['isHaveDelgate'] as bool?,
      isFullPath: json['isFullPath'] as bool?,
      departmentPrefix: json['departmentPrefix'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => RemoteRoles.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RemoteCurrentUserInfoToJson(
        RemoteCurrentUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'delegateId': instance.delegateId,
      'userGroups': instance.userGroups,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userEmailAccessRequest': instance.userEmailAccessRequest,
      'userDelgateEmail': instance.userDelgateEmail,
      'userDelgateName': instance.userDelgateName,
      'isHaveDelgate': instance.isHaveDelgate,
      'isFullPath': instance.isFullPath,
      'departmentPrefix': instance.departmentPrefix,
      'roles': instance.roles,
    };

RemoteRoles _$RemoteRolesFromJson(Map<String, dynamic> json) => RemoteRoles(
      id: json['id'] as String?,
      name: json['name'] as String?,
      normalizedName: json['normalizedName'] as String?,
      fullNameEnglish: json['fullNameEnglish'] as String?,
      fullNameArabic: json['fullNameArabic'] as String?,
      isSystemGroup: json['isSystemGroup'] as bool?,
    );

Map<String, dynamic> _$RemoteRolesToJson(RemoteRoles instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'normalizedName': instance.normalizedName,
      'fullNameEnglish': instance.fullNameEnglish,
      'fullNameArabic': instance.fullNameArabic,
      'isSystemGroup': instance.isSystemGroup,
    };

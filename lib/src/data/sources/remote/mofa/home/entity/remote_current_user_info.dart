import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/user_info.dart';

part 'remote_current_user_info.g.dart';

@JsonSerializable()
class RemoteCurrentUserInfo {
  final String? id;
  final String? delegateId;
  final List<dynamic>? userGroups;
  final String? userName;
  final String? userEmail;
  final String? userEmailAccessRequest;
  final String? userDelgateEmail;
  final String? userDelgateName;
  final bool? isHaveDelgate;
  final bool? isFullPath;
  final String? departmentPrefix;
  final List<RemoteRoles>? roles;

  const RemoteCurrentUserInfo({
    this.id,
    this.delegateId,
    this.userGroups,
    this.userName,
    this.userEmail,
    this.userEmailAccessRequest,
    this.userDelgateEmail,
    this.userDelgateName,
    this.isHaveDelgate,
    this.isFullPath,
    this.departmentPrefix,
    this.roles,
  });

  factory RemoteCurrentUserInfo.fromJson(Map<String, dynamic> json) =>
      _$RemoteCurrentUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCurrentUserInfoToJson(this);
}

extension RemoteCurrentUserInfoExtension on RemoteCurrentUserInfo {
  CurrentUserInfo toDomain() {
    return CurrentUserInfo(
      id: id ?? '',
      delegateId: delegateId ?? '',
      userGroups: userGroups ?? [],
      userName: userName ?? '',
      userEmail: userEmail ?? '',
      userEmailAccessRequest: userEmailAccessRequest ?? '',
      userDelgateEmail: userDelgateEmail ?? '',
      userDelgateName: userDelgateName ?? '',
      isHaveDelgate: isHaveDelgate ?? false,
      isFullPath: isFullPath ?? false,
      departmentPrefix: departmentPrefix ?? '',
      roles: roles?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

@JsonSerializable()
class RemoteRoles {
  final String? id;
  final String? name;
  final String? normalizedName;
  final String? fullNameEnglish;
  final String? fullNameArabic;
  final bool? isSystemGroup;

  const RemoteRoles({
    this.id,
    this.name,
    this.normalizedName,
    this.fullNameEnglish,
    this.fullNameArabic,
    this.isSystemGroup,
  });

  factory RemoteRoles.fromJson(Map<String, dynamic> json) =>
      _$RemoteRolesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteRolesToJson(this);
}

extension RemoteRolesExtension on RemoteRoles {
  Roles toDomain() {
    return Roles(
      id: id ?? '',
      name: name ?? '',
      normalizedName: normalizedName ?? '',
      fullNameEnglish: fullNameEnglish ?? '',
      fullNameArabic: fullNameArabic ?? '',
      isSystemGroup: isSystemGroup ?? false,
    );
  }
}

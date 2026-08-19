import 'package:equatable/equatable.dart';

class CurrentUserInfo extends Equatable {
  final String id;
  final String delegateId;
  final List<dynamic> userGroups;
  final String userName;
  final String userEmail;
  final String userEmailAccessRequest;
  final String userDelgateEmail;
  final String userDelgateName;
  final bool isHaveDelgate;
  final bool isFullPath;
  final String departmentPrefix;
  final List<Roles> roles;

  const CurrentUserInfo({
    this.id = '',
    this.delegateId = '',
    this.userGroups = const [],
    this.userName = '',
    this.userEmail = '',
    this.userEmailAccessRequest = '',
    this.userDelgateEmail = '',
    this.userDelgateName = '',
    this.isHaveDelgate = false,
    this.isFullPath = false,
    this.departmentPrefix = '',
    this.roles = const [],
  });

  @override
  List<Object?> get props => [
        id,
        delegateId,
        userGroups,
        userName,
        userEmail,
        userEmailAccessRequest,
        userDelgateEmail,
        userDelgateName,
        isHaveDelgate,
        isFullPath,
        departmentPrefix,
        roles,
      ];
}

class Roles extends Equatable {
  final String id;
  final String name;
  final String normalizedName;
  final String fullNameEnglish;
  final String fullNameArabic;
  final bool isSystemGroup;

  const Roles({
    this.id = '',
    this.name = '',
    this.normalizedName = '',
    this.fullNameEnglish = '',
    this.fullNameArabic = '',
    this.isSystemGroup = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        normalizedName,
        fullNameEnglish,
        fullNameArabic,
        isSystemGroup,
      ];
}

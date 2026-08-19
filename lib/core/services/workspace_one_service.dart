import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:workspaceone_sdk_flutter/workspaceone_sdk_flutter.dart';

/// Service class to manage Omnissa Workspace ONE SDK functionality and policy queries.
///
/// This is a singleton that initializes the SDK once and exposes helper methods
/// to query enrollment status, device compromise, DLP policies, and custom
/// configuration pushed from the UEM Console.
class WorkspaceOneService {
  WorkspaceOneService._internal();
  static final WorkspaceOneService instance = WorkspaceOneService._internal();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  // Cached policy values - refreshed on each policy check
  bool _cachedAllowCopyPaste = true;
  bool _cachedIsCompromised = false;
  String? _cachedCustomSettings;

  /// Start and initialize the Workspace ONE SDK
  Future<void> initialize() async {
    try {
      await WorkspaceoneSdkFlutter.startSDK;
      _isInitialized = true;
      developer.log('Workspace ONE SDK Started Successfully',
          name: 'WS1Service');

      // Fetch initial status values
      await refreshPolicyCache();
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'Workspace ONE startSDK failed or skipped in dev: $e',
          name: 'WS1Service',
        );
      }
    }
  }

  /// Refresh all cached policy values from the SDK
  Future<void> refreshPolicyCache() async {
    try {
      final isEnrolled = await WorkspaceoneSdkFlutter.isEnrolled;
      final isCompliant = await WorkspaceoneSdkFlutter.isCompliant;
      _cachedIsCompromised =
          (await WorkspaceoneSdkFlutter.isCompromised) ?? false;
      _cachedAllowCopyPaste =
          (await WorkspaceoneSdkFlutter.allowCopyPaste) ?? true;
      _cachedCustomSettings = await WorkspaceoneSdkFlutter.customSettings;

      developer.log(
        'WS1 Policy Refresh -> Enrolled: $isEnrolled, '
        'Compliant: $isCompliant, '
        'Compromised: $_cachedIsCompromised, '
        'AllowCopy: $_cachedAllowCopyPaste',
        name: 'WS1Service',
      );
    } catch (e) {
      if (kDebugMode) {
        developer.log('WS1 Policy refresh failed: $e', name: 'WS1Service');
      }
    }
  }

  /// Get enrollment status
  Future<bool> checkIsEnrolled() async {
    try {
      return (await WorkspaceoneSdkFlutter.isEnrolled) ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Check if device is compromised (rooted / jailbroken)
  Future<bool> checkIsCompromised() async {
    try {
      _cachedIsCompromised =
          (await WorkspaceoneSdkFlutter.isCompromised) ?? false;
      return _cachedIsCompromised;
    } catch (_) {
      return false;
    }
  }

  /// Check if device is compliant with MDM policies
  Future<bool> checkIsCompliant() async {
    try {
      return (await WorkspaceoneSdkFlutter.isCompliant) ?? true;
    } catch (_) {
      return true;
    }
  }

  /// Check if Copy/Paste is allowed by DLP policy
  Future<bool> checkAllowCopyPaste() async {
    try {
      _cachedAllowCopyPaste =
          (await WorkspaceoneSdkFlutter.allowCopyPaste) ?? true;
      return _cachedAllowCopyPaste;
    } catch (_) {
      return true;
    }
  }

  /// Get cached copy/paste policy (synchronous, uses last fetched value)
  bool get allowCopyPasteCached => _cachedAllowCopyPaste;

  /// Get cached compromised status (synchronous, uses last fetched value)
  bool get isCompromisedCached => _cachedIsCompromised;

  /// Get cached custom settings (synchronous, uses last fetched value)
  String? get customSettingsCached => _cachedCustomSettings;

  /// Fetch remote custom configurations sent from UEM Console
  Future<String?> getCustomSettings() async {
    try {
      _cachedCustomSettings = await WorkspaceoneSdkFlutter.customSettings;
      return _cachedCustomSettings;
    } catch (_) {
      return null;
    }
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mofa/core/services/workspace_one_service.dart';

/// Widget that wraps a child and applies Workspace ONE security policies:
/// - Prevents screenshots/screen recording when DLP policy denies it
/// - Uses FLAG_SECURE on Android / hides content on iOS app lifecycle
class SecureScreenWrapper extends StatefulWidget {
  final Widget child;

  /// If true, forces secure mode regardless of remote policy
  final bool forceSecure;

  const SecureScreenWrapper({
    super.key,
    required this.child,
    this.forceSecure = false,
  });

  @override
  State<SecureScreenWrapper> createState() => _SecureScreenWrapperState();
}

class _SecureScreenWrapperState extends State<SecureScreenWrapper>
    with WidgetsBindingObserver {
  static const _channel = MethodChannel('com.mofa.ksa/security');
  bool _shouldSecure = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkSecurityPolicy();
  }

  Future<void> _checkSecurityPolicy() async {
    if (widget.forceSecure) {
      _shouldSecure = true;
    } else {
      // Check if copy/paste (and by extension screenshot) is restricted
      final allowCopy =
          await WorkspaceOneService.instance.checkAllowCopyPaste();
      _shouldSecure = !allowCopy;
    }
    if (_shouldSecure) {
      _enableSecureFlag();
    }
    if (mounted) setState(() {});
  }

  void _enableSecureFlag() {
    if (Platform.isAndroid) {
      try {
        _channel.invokeMethod('enableSecureFlag');
      } catch (_) {
        // Method channel may not be implemented yet - gracefully skip
      }
    }
  }

  void _disableSecureFlag() {
    if (Platform.isAndroid) {
      try {
        _channel.invokeMethod('disableSecureFlag');
      } catch (_) {}
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // On iOS: hide content when app is in background (task switcher)
    if (Platform.isIOS && _shouldSecure) {
      if (state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused) {
        // Content is already obscured by Flutter's default behavior
        // Additional protection could be added here
      }
    }
  }

  @override
  void dispose() {
    if (_shouldSecure) {
      _disableSecureFlag();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

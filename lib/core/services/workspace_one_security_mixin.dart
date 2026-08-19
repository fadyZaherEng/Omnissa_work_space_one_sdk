import 'package:flutter/material.dart';
import 'package:mofa/core/services/workspace_one_service.dart';

/// Mixin that provides Workspace ONE security checks for any StatefulWidget.
/// 
/// Checks device compliance and enrollment status on screen initialization.
/// Shows warning dialog and prevents access if device is not compliant.
mixin WorkspaceOneSecurityMixin<T extends StatefulWidget> on State<T> {
  bool _isSecurityCheckPassed = false;
  bool get isSecurityCheckPassed => _isSecurityCheckPassed;

  bool _isCopyPasteAllowed = true;
  bool get isCopyPasteAllowed => _isCopyPasteAllowed;

  /// Call this in initState() to perform security checks
  Future<void> performSecurityChecks() async {
    // Check if device is compromised (rooted/jailbroken)
    final isCompromised =
        await WorkspaceOneService.instance.checkIsCompromised();
    if (isCompromised && mounted) {
      _isSecurityCheckPassed = false;
      _showCompromisedDialog();
      return;
    }

    // Check DLP copy/paste policy
    _isCopyPasteAllowed =
        await WorkspaceOneService.instance.checkAllowCopyPaste();

    _isSecurityCheckPassed = true;
    if (mounted) setState(() {});
  }

  void _showCompromisedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("تحذير أمني"),
        content: const Text(
          "تم اكتشاف كسر حماية في نظام هذا الجهاز (Root/Jailbreak).\n"
          "لا يمكن تشغيل التطبيق حفاظاً على أمان البيانات.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("رجوع"),
          ),
        ],
      ),
    );
  }

  /// Build a contextMenuBuilder that respects DLP copy/paste policy.
  /// Use this in TextField(contextMenuBuilder: secureContextMenuBuilder)
  Widget Function(BuildContext, EditableTextState)? get secureContextMenuBuilder {
    if (_isCopyPasteAllowed) {
      return null; // Use default context menu
    }
    // Return empty builder to disable context menu (no copy/paste/cut)
    return (BuildContext context, EditableTextState editableTextState) {
      return const SizedBox.shrink();
    };
  }
}

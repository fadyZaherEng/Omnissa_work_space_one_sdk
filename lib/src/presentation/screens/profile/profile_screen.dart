import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/entities/home/user_info.dart';

class ProfileScreen extends StatefulWidget {
  final CurrentUserInfo userInfo;

  const ProfileScreen({
    super.key,
    required this.userInfo,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).userProfile,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: ColorSchemes.black,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            ImagePaths.backArrow,
            width: 24,
            height: 24,
            matchTextDirection: true,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(S.of(context).userInformation),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              label: S.of(context).fullName,
              value: widget.userInfo.userName,
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              label: S.of(context).department,
              value: widget.userInfo.departmentPrefix,
              icon: Icons.local_fire_department,
            ),
            const Divider(height: 24),
            _buildInfoRow(
              context,
              label: S.of(context).email,
              value: widget.userInfo.userEmail,
              icon: Icons.email_outlined,
            ),
            const Divider(height: 24),
            _buildRoleSection(),
            const SizedBox(height: 16),
            // _buildFullPathVisibility(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ColorSchemes.primary,
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: ColorSchemes.black, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.gray,
                      fontWeight: Constants.fontWeightSemiBold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.black,
                      fontWeight: Constants.fontWeightSemiBold,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.people_outline,
                color: ColorSchemes.black, size: 24),
            const SizedBox(width: 12),
            Text(
              S.of(context).roles,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.gray,
                    fontWeight: Constants.fontWeightSemiBold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.userInfo.roles.map((role) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: ColorSchemes.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorSchemes.primary),
              ),
              child: Text(
                role.name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorSchemes.primary,
                      fontWeight: Constants.fontWeightSemiBold,
                    ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFullPathVisibility() {
    return Row(
      children: [
        Checkbox(
          value: widget.userInfo.isFullPath,
          onChanged: null, // Disabled for read-only
          activeColor: ColorSchemes.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            S.of(context).allowFullPathVisibility,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  fontWeight: Constants.fontWeightSemiBold,
                ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';

class TaskDetailsSkeleton extends StatelessWidget {
  const TaskDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Task Info Section
          _buildSectionSkeleton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Info Row
                Row(
                  children: [
                    Expanded(child: _buildFieldSkeleton()),
                    const SizedBox(width: 16),
                    Expanded(child: _buildFieldSkeleton()),
                  ],
                ),
                const SizedBox(height: 16),
                // Task Info Row 1
                Row(
                  children: [
                    Expanded(child: _buildFieldSkeleton()),
                    const SizedBox(width: 16),
                    Expanded(child: _buildFieldSkeleton()),
                  ],
                ),
                const SizedBox(height: 16),
                // Task Info Row 2
                Row(
                  children: [
                    Expanded(child: _buildFieldSkeleton()),
                    const SizedBox(width: 16),
                    Expanded(child: _buildFieldSkeleton()),
                  ],
                ),
                const SizedBox(height: 16),
                // Progress Section
                _buildProgressSkeleton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionSkeleton({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorSchemes.border, width: 0.75),
      ),
      child: child,
    );
  }

  Widget _buildFieldSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 25,
            width: 100,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 16),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 16,
            width: double.infinity,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 14,
            width: 100,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 8,
            width: double.infinity,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}

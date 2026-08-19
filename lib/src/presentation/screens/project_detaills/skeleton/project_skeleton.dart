import 'package:flutter/material.dart';
import 'package:mofa/src/presentation/screens/project/skeleton/project_card_skeleton.dart';
import 'package:skeletons/skeletons.dart';

class ProjectDetailsSkeleton extends StatelessWidget {
  const ProjectDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 38,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => const ProjectCardSkeleton(),
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemCount: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

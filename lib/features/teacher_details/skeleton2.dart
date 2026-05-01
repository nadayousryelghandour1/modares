import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UnitsSectionSkeleton extends StatelessWidget {
  const UnitsSectionSkeleton({super.key});

  Widget skeletonBox({
    double? width,
    double? height,
    BorderRadius? borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: List.generate(
          3,
          (gradeIndex) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Grade title
                skeletonBox(
                  width: 180,
                  height: 24,
                ),

                const SizedBox(height: 16),

                /// Subject chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                    4,
                    (index) => skeletonBox(
                      width: 90,
                      height: 36,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Units cards
                SizedBox(
                  height: 230,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 300,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            skeletonBox(
                              width: double.infinity,
                              height: 120,
                            ),
                            const SizedBox(height: 16),
                            skeletonBox(
                              width: 180,
                              height: 18,
                            ),
                            const SizedBox(height: 8),
                            skeletonBox(
                              width: 220,
                              height: 14,
                            ),
                            const SizedBox(height: 8),
                            skeletonBox(
                              width: 160,
                              height: 14,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
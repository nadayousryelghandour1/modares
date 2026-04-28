import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  Widget shimmerBox({
    double? width,
    double? height,
    BorderRadius? borderRadius,
    ShapeBorder? shape,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Colors.grey.shade300,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            ),
      ),
    );
  }

  Widget shimmerField(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment:
              isRTL ? Alignment.centerRight : Alignment.centerLeft,
          child: shimmerBox(
            width: 110,
            height: 14,
          ),
        ),
        const SizedBox(height: 8),
        shimmerBox(
          width: double.infinity,
          height: 58,
          borderRadius: BorderRadius.circular(15),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Header shimmer
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo,
                      Colors.blue,
                      Colors.cyan,
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Profile Image shimmer
            Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: shimmerBox(
                  width: 120,
                  height: 120,
                  shape: const CircleBorder(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Tabs shimmer
            Row(
              textDirection:
                  isRTL ? TextDirection.rtl : TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: shimmerBox(
                    width: 130,
                    height: 18,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: shimmerBox(
                    width: 130,
                    height: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            /// Fields shimmer
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                4,
                (index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: shimmerField(context),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Buttons shimmer
            Row(
              textDirection:
                  isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: shimmerBox(
                      height: 50,
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: shimmerBox(
                      height: 50,
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
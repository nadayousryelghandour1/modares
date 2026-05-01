import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TeacherDetailsSkeleton extends StatelessWidget {
  const TeacherDetailsSkeleton({super.key});

  Widget skeleton({
    double? width,
    double? height,
    BorderRadius? borderRadius,
    ShapeBorder? shape,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape:
            shape ??
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Header + cover + avatar
              Stack(
                clipBehavior: Clip.none,
                children: [
                  skeleton(
                    width: double.infinity,
                    height: 220,
                    borderRadius: BorderRadius.circular(0),
                  ),

                  Positioned(
                    bottom: -50,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: skeleton(
                        width: 110,
                        height: 110,
                        shape: const CircleBorder(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 70),

              /// Name
              skeleton(
                width: 180,
                height: 20,
              ),

              const SizedBox(height: 20),

              /// Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    4,
                    (_) => skeleton(
                      width: 70,
                      height: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: List.generate(
                    2,
                    (index) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: index == 0 ? 12 : 0,
                        ),
                        child: Column(
                          children: [
                            skeleton(
                              width: 80,
                              height: 18,
                            ),
                            const SizedBox(height: 12),
                            skeleton(
                              width: 40,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// Overview title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: skeleton(
                    width: 120,
                    height: 20,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// Overview content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: skeleton(
                  width: double.infinity,
                  height: 90,
                ),
              ),

              const SizedBox(height: 30),

              /// Subjects title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: skeleton(
                    width: 140,
                    height: 20,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Subject chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                    5,
                    (_) => skeleton(
                      width: 110,
                      height: 36,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: skeleton(
                  width: double.infinity,
                  height: 55,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
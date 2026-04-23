import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TeacherCardShimmer extends StatelessWidget {
  const TeacherCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 16, width: 140, color: Colors.white),
                    const SizedBox(height: 10),
                    Container(height: 14, width: 100, color: Colors.white),
                    const Spacer(),
                    Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(height: 12, width: 50, color: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

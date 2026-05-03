import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TeachersSkeleton extends StatelessWidget {
  const TeachersSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          return Container(
            width: 120,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // صورة دائرية وهمية
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 10),
                // اسم المدرس الوهمي
                Container(
                  width: 90,
                  height: 12,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 6),
                // تفاصيل إضافية وهمية
                Container(
                  width: 70,
                  height: 10,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 12),
                // زر الملف الشخصي الوهمي
                Container(
                  width: 80,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

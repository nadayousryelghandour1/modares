import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_subjects.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/features/widget/best_teachers.dart';
import 'package:modares/features/widget/home_banner.dart';
import 'package:modares/features/widget/subject_card.dart';
import 'package:modares/features/widget/todo_bar.dart';
import 'package:modares/l10n/app_localizations.dart';
import 'package:modares/model/user_model.dart';
import 'package:shimmer/shimmer.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    user = await CacheHelper.getUser();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || user == null) {
      return const StudentHomeShimmer();
    }
    final filterStage = filteredStages(user!.gradeId);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        title: Expanded(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColor.primeryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                "مُ",
                style: TextStyle(fontSize: 16, color: Colors.white , fontFamily: "Cairo", fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, size: 30),
          ),
          Container(
  margin: const EdgeInsets.symmetric(horizontal: 16),
  child: CircleAvatar(
    radius: 22.5,
    backgroundImage: NetworkImage(
      user!.image ??
          "https://i.pinimg.com/736x/d6/39/e0/d639e0e564e4a107d03543542900db7c.jpg",
    ),
  ),
)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeBanner(),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.of(context)!.subjects,
                  style: AppTextStyle.primaryStyle,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: filterStage.subjects.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SubjectCard(subject: filterStage.subjects[index]);
                  },
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "مدرسون مميزون",
                  style: AppTextStyle.primaryStyle.copyWith(fontSize: 18),
                ),
              ),

              const SizedBox(height: 20),

              const BestTeachers(),

              const SizedBox(height: 20),

              const SizedBox(height: 280, child: TodoBar()),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentHomeShimmer extends StatelessWidget {
  const StudentHomeShimmer({super.key});

  Widget shimmerBox({
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
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              shimmerBox(width: double.infinity, height: 180),

              const SizedBox(height: 20),

              shimmerBox(width: 150, height: 25),

              const SizedBox(height: 20),

              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, __) => shimmerBox(width: 120, height: 150),
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemCount: 4,
                ),
              ),

              const SizedBox(height: 20),

              shimmerBox(width: 180, height: 25),

              const SizedBox(height: 20),

              shimmerBox(width: double.infinity, height: 220),
            ],
          ),
        ),
      ),
    );
  }
}

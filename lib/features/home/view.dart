import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/core/resources/app_subjects.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/features/widget/containue.dart';
import 'package:modares/features/widget/home_banner.dart';
import 'package:modares/features/widget/subject_card.dart';
import 'package:modares/features/widget/todo_bar.dart';
import 'package:modares/l10n/app_localizations.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        title: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: AppColor.primeryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(AppLocalizations.of(context)!.logo),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, size: 30),
          ),

          Container(
            width: 45,
            height: 45,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColor.primeryColor,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              HomeBanner(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.of(context)!.subjects,
                  style: AppTextStyle.primaryStyle,
                ),
              ),

              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: filteredStages.subjects.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SubjectCard(subject: filteredStages.subjects[index]);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.units,
                      style: AppTextStyle.primaryStyle.copyWith(fontSize: 18),
                    ),
                    Text(
                      AppLocalizations.of(context)!.seeAll,
                      style: AppTextStyle.primaryStyle.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Containue(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(100),
                          child: CircleAvatar(
                            radius: 50,
                            child: Image.network(
                              "https://i.pinimg.com/736x/d6/39/e0/d639e0e564e4a107d03543542900db7c.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 60,
                              height: 24,
                              padding: EdgeInsets.symmetric(
                                horizontal: 2,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.mainGold,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 3,
                                children: [
                                  Text(
                                    'rate',
                                    style: AppTextStyle.primaryStyle.copyWith(
                                      fontSize: 14,
                                      fontFamily: "Sans",
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    AppImage.starIcon,
                                    width: 15,
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "name",
                      style: AppTextStyle.primaryStyle.copyWith(fontSize: 18),
                    ),
                    Text(
                      "sub",
                      style: AppTextStyle.secondaryStyle.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              TodoBar(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

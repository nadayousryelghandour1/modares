import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modares/bloc/teacher/teacher_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_error_page.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/core/resources/background.dart';
import 'package:modares/features/teacher_details/skeleton1.dart';
import 'package:modares/features/widget/details_form.dart';
import 'package:modares/features/widget/unit_section.dart';

class TeacherDetails extends StatelessWidget {
  const TeacherDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final TeacherBloc bloc = getIt<TeacherBloc>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(child: MudarrisBackground()),

          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: BlocConsumer<TeacherBloc, TeacherState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is TeacherLoadSuccess) {}
              },
              builder: (context, state) {
                if (state is TeacherLoadSuccess) {
                  return Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColor.primeryColorDark,
                              AppColor.primeryColor,
                              AppColor.secondaryLoginButtonColor,
                              AppColor.mainWhite,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height +
                              MediaQuery.of(context).viewInsets.bottom -
                              180,
                          padding: EdgeInsets.only(top: 78),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColor.mainBackground,
                                AppColor.mainBackground,
                                Colors.transparent,
                                Colors.transparent,
                              ],
                              stops: [
                                0.0,
                                0.07, // الجزء الأبيض الصغير
                                0.04,
                                1.0,
                              ],
                            ),
                          ),
                          child: DefaultTabController(
                            length: 3,
                            child: Column(
                              children: [
                                // 1️⃣ TabBar (هنا التابات نفسها)
                                TabBar(
                                  dividerColor: AppColor.secondaryColor,
                                  indicatorColor: AppColor.primeryColor,
                                  labelColor: AppColor.primeryColor,
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Cairo",
                                  ),
                                  unselectedLabelColor:
                                      AppColor.primaryTextColor,
                                  unselectedLabelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Cairo",
                                  ),

                                  tabs: [
                                    Tab(text: "عن المدرس"),
                                    Tab(text: "قوائم الدروس"),
                                    Tab(text: "التعليقات"),
                                  ],
                                ),

                                // 2️⃣ المحتوى
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 32,
                                    ),
                                    child: TabBarView(
                                      children: [
                                        SingleChildScrollView(
                                          child: DetailsForm(
                                            profile: state.teacher,
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: UnitsSection(teacherId: state.teacher.id),
                                        ),
                                        Container(color: Colors.blue),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.080,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColor.mainWhite,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Container(
                                    width: 160,
                                    height: 160,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      // state.profile.image ??
                                      "https://i.pinimg.com/736x/d6/39/e0/d639e0e564e4a107d03543542900db7c.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: Container(
                                  width: 80,
                                  height: 26,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    spacing: 5,
                                    children: [
                                      Text(
                                        '${state.teacher.rating}',
                                        style: AppTextStyle.primaryStyle
                                            .copyWith(
                                              fontSize: 16,
                                              fontFamily: "Sans",
                                            ),
                                      ),
                                      SvgPicture.asset(
                                        AppImage.starIcon,
                                        width: 16,
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is TeacherLoadFailure) {
                  return ErrorScreen(
                    message: state.message ?? "Unexpected Error Occur",
                  );
                }
                return TeacherDetailsSkeleton();
              },
            ),
          ),
        ],
      ),
    );
  }
}

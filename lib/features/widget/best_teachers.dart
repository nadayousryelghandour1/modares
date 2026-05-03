import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modares/bloc/teacher/teacher_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_error_page.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/features/home/skeleton.dart';
import 'package:modares/features/teacher_details/view.dart';
import 'package:modares/l10n/app_localizations.dart';

class BestTeachers extends StatelessWidget {
  const BestTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    final TeacherBloc bloc = getIt<TeacherBloc>();

    return BlocBuilder<TeacherBloc, TeacherState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is BestTeachersLoadFailure) {
          return ErrorScreen(message: state.message ?? "Unexpected Error");
        }
        if (state is BestTeachersLoadSuccess) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.teachers.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.mainWhite,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColor.mainGray.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(100),
                            child: CircleAvatar(
                              radius: 50,
                              child:
                                  state.teachers[index].image != null &&
                                      state.teachers[index].image!.startsWith(
                                        'http',
                                      )
                                  ? Image.network(
                                      state.teachers[index].image!,
                                      fit: BoxFit.fill,
                                      errorBuilder: (_, __, ___) => Image.network(
                                        "https://i.pinimg.com/736x/d6/39/e0/d639e0e564e4a107d03543542900db7c.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : state.teachers[index].image != null
                                  ? Image.memory(
                                      base64Decode(
                                        state.teachers[index].image!.replaceAll(
                                          RegExp(r'data:image/[^;]+;base64,'),
                                          '',
                                        ),
                                      ),
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
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
                                      state.teachers[index].rating.toString(),
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
                      Expanded(
                        child: Text(
                          state.teachers[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.primaryStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          bloc.add(GetTeacher(id: state.teachers[index].id));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TeacherDetails(),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primeryColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.profileButton,
                              style: AppTextStyle.primaryButtonStyle.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return TeachersSkeleton();
      },
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modares/bloc/teacher/teacher_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/features/teacher_details/view.dart';
import 'package:modares/l10n/app_localizations.dart';
import 'package:modares/model/teacher_model.dart';

class SearchItem extends StatelessWidget {
  final TeacherModel teacher;
  const SearchItem({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    final TeacherBloc bloc = getIt<TeacherBloc>();
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColor.mainWhite,
        border: Border.all(
          color: AppColor.primeryColor.withValues(alpha: 0.1),
          width: 2,
          style: BorderStyle.solid,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primeryColorDark.withValues(alpha: 0.12),
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            // Avatar
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(100),
                  child: CircleAvatar(
                    radius: 50,
                    child:
                        teacher.image != null &&
                            teacher.image!.startsWith('http')
                        ? Image.network(
                            teacher.image!,
                            fit: BoxFit.fill,
                            errorBuilder: (_, __, ___) => Image.network(
                              "https://i.pinimg.com/736x/d6/39/e0/d639e0e564e4a107d03543542900db7c.jpg",
                              fit: BoxFit.cover,
                            ),
                          )
                        : teacher.image != null
                        ? Image.memory(
                            base64Decode(
                              teacher.image!.replaceAll(
                                RegExp(r'data:image/[^;]+;base64,'),
                                '',
                              ),
                            ),
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            "https://i.pinimg.com/736x/d6/39/e0/d639e0e564e4a107d03543542900db7c.jpg",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 60,
                    height: 24,
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
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
                          '${teacher.rating}',
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
              ],
            ), // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 5,
                children: [
                  SizedBox(
                    height: 30,
                    child: Text(
                      teacher.name,
                      style: AppTextStyle.primaryStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false, 
                    ),
                  ),
                  Expanded(
                    child: Text(
                      teacher.subjects!.join(" • "),
                      style: AppTextStyle.secondaryStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),

                  SizedBox(height: 2),

                  GestureDetector(
                    onTap: () {
                      bloc.add(GetTeacher(id: teacher.id));
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
            ),
          ],
        ),
      ),
    );
  }
}

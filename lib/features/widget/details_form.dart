import 'package:flutter/material.dart';
import 'package:modares/bloc/profile/profile_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/network/services/chat.dart';
import 'package:modares/core/resources/app_button.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/features/chat/view.dart';
import 'package:modares/features/widget/avaliability.dart';
import 'package:modares/features/widget/profile_field.dart';
import 'package:modares/features/widget/subject_section.dart';
import 'package:modares/model/teacher_model.dart';

class DetailsForm extends StatefulWidget {
  final TeacherModel profile;
  const DetailsForm({super.key, required this.profile});

  @override
  State<DetailsForm> createState() => _DetailsFormState();
}

class _DetailsFormState extends State<DetailsForm> {
  bool isEditing = false;
  final ProfileBloc bloc = getIt<ProfileBloc>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey.shade500, width: 1),
              ),
              // لو عايز حدود
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    Column(
                      children: [
                        Text(
                          "الطلاب",
                          style: AppTextStyle.primaryStyle.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "+${widget.profile.studentsCount}",
                          style: AppTextStyle.secondaryStyle.copyWith(
                            fontSize: 20,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "ساعات التدريس",
                          style: AppTextStyle.primaryStyle.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "+${widget.profile.hoursOfTeaching}",
                          style: AppTextStyle.secondaryStyle.copyWith(
                            fontSize: 20,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Divider(),
            ),
            ProfileField(
              title: "نبذة مختصرة",
              hint: widget.profile.description ?? "No Bio Yet...",
              isEnabled: isEditing,
              controller: bloc.email,
            ),
            SubjectsSection(subjectIds: widget.profile.subjectsIds ?? []),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Divider(),
            ),
            AppButton(
              text: "حجز درس مباشر",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookLiveSession(
                      teacherAvailability: widget.profile.availability ?? {},
                      teacherName: widget.profile.name,
                    ),
                  ),
                );
              },
              widget: const Icon(
                Icons.calendar_month_outlined,
                color: Colors.white,
              ),
            ),
            AppButton(
              text: "ارسال رسالة",
              widget: Icon(Icons.message_outlined, color: AppColor.mainWhite),
              onTap: () async {
                final user = await CacheHelper.getUser();

                await getIt<ChatService>().createConversationIfNotExists(
                  currentUser: user,
                  teacherEmail: widget.profile.email!,
                  teacherName: widget.profile.name,
                  teacherImage: widget.profile.image,
                );

                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(
                      currentUser: user,
                      teacherEmail: widget.profile.email!,
                      teacherName: widget.profile.name,
                      teacherImage: widget.profile.image,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

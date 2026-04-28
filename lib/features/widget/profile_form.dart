import 'package:flutter/material.dart';
import 'package:modares/bloc/profile/profile_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_button.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/features/widget/profile_field.dart';
import 'package:modares/features/widget/stage_selector.dart';
import 'package:modares/l10n/app_localizations.dart';
import 'package:modares/model/user_model.dart';

class ProfileForm extends StatefulWidget {
  final UserModel profile;
  const ProfileForm({super.key, required this.profile});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  bool isEditing = false;
  final ProfileBloc bloc = getIt<ProfileBloc>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          spacing: 24,
          children: [
            ProfileField(
              title: "مفتاح الطالب",
              hint: widget.profile.key,
              isEnabled: false,
            ),
            ProfileField(
              title: "الاسم الكامل",
              hint: widget.profile.name,
              isEnabled: isEditing,
              controller: bloc.name,
            ),
            ProfileField(
              title: "البريد الإلكتروني",
              hint: widget.profile.email,
              isEnabled: isEditing,
              controller: bloc.email,
            ),
            ProfileField(
              title: "رقم الهاتف",
              hint: widget.profile.phoneNumber!,
              isEnabled: isEditing,
              controller: bloc.phoneNumber,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.choose_stage,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primaryTextColor,
                  ),
                ),
                SizedBox(height: 10),
                StageSelector(
                  isEnabled: isEditing,
                  val: widget.profile.gradeId,
                  onChanged: (stage) {
                    bloc.gradeId.text = stage.toString();
                  },
                ),
                SizedBox(height: 24),
                isEditing
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppButton(
                            text: "Edit",
                            width: 180,
                            onTap: () {
                              bloc.add(EditProfileEvent());

                              setState(() {
                                isEditing = !isEditing;
                              });
                            },
                          ),
                          AppButton(
                            text: "Cancel",
                            width: 180,
                            onTap: () {
                           setState(() {
                                isEditing = !isEditing;
                              });
                            },
                          ),
                        ],
                      )
                    : AppButton(
                        text: "Edit",
                        width: 70,
                        onTap: () {
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                      ),
                SizedBox(height: 70),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

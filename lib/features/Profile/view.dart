import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modares/bloc/profile/profile_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_error_page.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/core/resources/log_out_sheet.dart';
import 'package:modares/core/resources/snack_bar.dart';
import 'package:modares/features/Profile/skeleton.dart';
import 'package:modares/features/login/view.dart';
import 'package:modares/features/widget/profile_form.dart';
import 'package:modares/features/widget/quiz_result_table.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileBloc bloc = getIt<ProfileBloc>();
    getData() async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        bloc.add(EditProfileImageEvent(image: image));
      } else {
        showMySnackBar(
          msg: "sorry no image was chosen",
          type: AnimatedSnackBarType.warning,
          // ignore: use_build_context_synchronously
          context: context,
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is ProfileEditSuccess) {
              showMySnackBar(
                msg: "تم تحديث الملف الشخصي بنجاح",
                type: AnimatedSnackBarType.success,
                context: context,
              );
            } else if (state is LogoutSuccess ||
                state is AccountDeleteSuccess) {
                  
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false,
              );
            } else if (state is LogoutFailure ||
                state is AccountDeleteFailure) {
              showMySnackBar(
                msg: "Unexpected Error Occur",
                type: AnimatedSnackBarType.error,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileSuccess) {
              // print("=========================================%{state.profile[]}")ك
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    padding: EdgeInsets.all(32),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.primeryColorDark,
                          AppColor.primeryColor,
                          AppColor.secondaryLoginButtonColor,
                          AppColor.mainWhite,
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: PopupMenuButton<String>(
                        icon: Icon(
                          Icons.settings,
                          color: AppColor.primeryColor,
                          size: 35,
                        ), // أو Icons.more_vert
                        onSelected: (value) {
                          if (value == 'logout') {
                            LogOutSheet(
                              image: AppImage.wearningIcon,
                              purpose: "تسجيل الخروج",
                              question: "هل انت متأكد من تسجيل خروجك ؟",
                              answer: "نعم",
                              onTap: () {
                                bloc.add(Logout());
                              },
                            );
                          } else if (value == 'delete') {
                            LogOutSheet(
                              image: AppImage.wearningIcon,
                              purpose: "حذف الحساب",
                              question: "هل انت متأكد من حذف حسابك ؟",
                              answer: "نعم",
                              onTap: () {
                                bloc.add(DeleteAccount());
                              },
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'logout',
                            child: Text(
                              'تسجيل الخروج',
                              style: AppTextStyle.secondaryStyle,
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              'حذف الحساب',
                              style: AppTextStyle.secondaryStyle.copyWith(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
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
                        length: 2,
                        child: Column(
                          children: [
                            // 1️⃣ TabBar (هنا التابات نفسها)
                            TabBar(
                              dividerColor: AppColor.secondaryColor,
                              indicatorColor: AppColor.primeryColor,
                              labelColor: AppColor.primeryColor,
                              labelStyle: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Cairo",
                              ),
                              unselectedLabelColor: AppColor.primaryTextColor,
                              unselectedLabelStyle: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Cairo",
                              ),

                              tabs: [
                                Tab(text: "المعلومات الشخصية"),
                                Tab(text: "نتائج الاختبارات"),
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
                                      child: ProfileForm(
                                        profile: state.profile,
                                      ),
                                    ),
                                    QuizzesTable(quizzes: state.profile.quizResults ?? []),
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
                                  state.profile.image ??
                                      "https://i.pinimg.com/736x/d6/39/e0/d639e0e564e4a107d03543542900db7c.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: InkWell(
                              onTap: () async {
                                getData();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColor.primeryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ProfileFailure) {
              return ErrorScreen(
                message: state.message ?? "Unexpected Error Occur",
              );
            }
            return ProfileShimmer();
          },
        ),
      ),
    );
  }
}

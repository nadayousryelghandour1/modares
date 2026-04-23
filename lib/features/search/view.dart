import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modares/bloc/teacher_search/teacher_search_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/features/search/skeleton.dart';

import 'package:modares/features/widget/custom_field.dart';
import 'package:modares/features/widget/search_Item.dart';
import 'package:modares/features/widget/search_bar.dart';

class TeacherSearchPage extends StatefulWidget {
  const TeacherSearchPage({super.key});

  @override
  State<TeacherSearchPage> createState() => _TeacherSearchPageState();
}

class _TeacherSearchPageState extends State<TeacherSearchPage> {
  // final TextEditingController _searchController = TextEditingController();

  String selectedGovernorate = "";
  String selectedCourse = "";
  String selectedMethod = "all";

  @override
  Widget build(BuildContext context) {
    final TeacherSearchBloc bloc = getIt<TeacherSearchBloc>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Expanded(
                    child: CustomField(
                      hint: "Search by Teacher Name",
                      icon: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: SvgPicture.asset(
                          AppImage.searchIcon,
                          width: 25,
                          colorFilter: ColorFilter.mode(
                            AppColor.mainGray,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      AppImage.filterIcon,
                      width: 35,
                      height: 35,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        AppColor.primeryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {
                      _openFilterDialog(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomSearchBar(),
            BlocBuilder<TeacherSearchBloc, TeacherSearchState>(
              bloc: bloc,
              builder: (context, state) {
                print("=================================$state");
                if (state is TeacherLoadedSuccess) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.teachers.length,
                      itemBuilder: (context, index) {
                        return SearchItem(teacher: state.teachers[index]);
                      },
                    ),
                  );
                } else if (state is TeacherSearchError) {}
                return Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (_, __) => TeacherCardShimmer(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("اختيار الفلاتر"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedGovernorate.isEmpty ? null : selectedGovernorate,
                hint: const Text("اختر المحافظة"),
                items: ["القاهرة", "بورسعيد", "الإسكندرية"]
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedGovernorate = value ?? "");
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedCourse.isEmpty ? null : selectedCourse,
                hint: const Text("اختر المادة"),
                items: ["رياضيات", "لغة عربية", "إنجليزي"]
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedCourse = value ?? "");
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedMethod,
                items: ["all", "online", "offline"]
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedMethod = value ?? "all");
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("إلغاء"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("تطبيق"),
              onPressed: () {
                // هنا تبعتي Event للـ Bloc مع الفلاتر الجديدة
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

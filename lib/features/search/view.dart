import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modares/bloc/teacher_search/teacher_search_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/features/filter_dialog.dart';
import 'package:modares/features/search/skeleton.dart';
import 'package:modares/features/widget/custom_field.dart';
import 'package:modares/features/widget/no_match.dart';
import 'package:modares/features/widget/search_Item.dart';
import 'package:modares/features/widget/search_bar.dart';
import 'package:modares/l10n/app_localizations.dart';

class TeacherSearchPage extends StatefulWidget {
  const TeacherSearchPage({super.key});

  @override
  State<TeacherSearchPage> createState() => _TeacherSearchPageState();
}

class _TeacherSearchPageState extends State<TeacherSearchPage> {
  String selectedGovernorate = "";
  String selectedCourse = "";
  String selectedMethod = "all";
  final TeacherSearchBloc bloc = getIt<TeacherSearchBloc>();

  @override
  Widget build(BuildContext context) {
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
                      hint: AppLocalizations.of(context)!.searchTeacherNameHint,
                      controller: getIt<TeacherSearchBloc>().teacherName,
                      keyboard: TextInputType.webSearch,
                      onChange: (val) {
                        getIt<TeacherSearchBloc>().add(ApplyFilters());
                      },
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
                if (state is TeacherSearchLoaded) {
                  if (state.displayedTeachers.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.displayedTeachers.length,
                        itemBuilder: (context, index) {
                          return SearchItem(
                            teacher: state.displayedTeachers[index],
                          );
                        },
                      ),
                    );
                  } else {
                    return NoMatch();
                  }
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

  void _openFilterDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => FilterDialog(
        initial: FilterOptions(
          governorate: bloc.government,
          teachingMethod: bloc.learningMethod,
          sortBy: bloc.sortBy ?? 2,
        ),
      ),
    );
  }
}

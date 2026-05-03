import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modares/bloc/teacher_search/teacher_search_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_subjects.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/features/search/skeleton_main.dart';
import 'package:modares/l10n/app_localizations.dart';
import 'package:modares/model/subject_model.dart';
import 'package:modares/model/user_model.dart';

// ignore: must_be_immutable
class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  int? indexActive;
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
    final loc = AppLocalizations.of(context)!;

    if (isLoading || user == null) {
      return Expanded(child: TeachersPageSkeleton());
    }
    List<SubjectModel> choices = filteredStages(user!.gradeId).subjects;

    return BlocConsumer<TeacherSearchBloc, TeacherSearchState>(
      bloc: getIt<TeacherSearchBloc>(),
      listener: (context, state) {
        if (state is TeacherSearchLoaded) {
          indexActive = getIt<TeacherSearchBloc>().subjectId;
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: choices.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          indexActive = index;
                          getIt<TeacherSearchBloc>().subjectId =
                              choices[index].id;
                          getIt<TeacherSearchBloc>().add(ApplyFilters());
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 1,
                          color: indexActive == choices[index].id
                              ? Colors.transparent
                              : Colors.black,
                        ),
                        backgroundColor: indexActive == choices[index].id
                            ? AppColor.secondaryColor
                            : Colors.white,
                      ),
                      child: Text(
                        _localizedSubjectName(choices[index].labelKey, loc),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cairo",
                          color: indexActive == choices[index].id
                              ? AppColor.mainWhite
                              : AppColor.primeryColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

String _localizedSubjectName(String labelKey, AppLocalizations loc) {
  switch (labelKey) {
    case 'arabic':
      return loc.arabic;
    case 'mathematics':
      return loc.mathematics;
    case 'science':
      return loc.science;
    case 'socialStudies':
      return loc.socialStudies;
    case 'english':
      return loc.english;
    case 'physics':
      return loc.physics;
    case 'chemistry':
      return loc.chemistry;
    case 'biology':
      return loc.biology;
    case 'pureMathematics':
      return loc.pureMathematics;
    case 'appliedMathematics':
      return loc.appliedMathematics;
    case 'philosophy':
      return loc.philosophy;
    case 'psychology':
      return loc.psychology;
    case 'geography':
      return loc.geography;
    case 'history':
      return loc.history;
    default:
      return labelKey;
  }
}

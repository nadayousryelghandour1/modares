import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modares/bloc/unit/unit_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_error_page.dart';
import 'package:modares/core/resources/app_subjects.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/features/teacher_details/skeleton2.dart';
import 'package:modares/features/widget/unit_card.dart';
import 'package:modares/l10n/app_localizations.dart';

class UnitsSection extends StatefulWidget {
  final int teacherId;

  const UnitsSection({super.key, required this.teacherId});

  @override
  State<UnitsSection> createState() => _UnitsSectionState();
}

class _UnitsSectionState extends State<UnitsSection> {
  Map<dynamic, dynamic> selectedSubject = {};
  Map<dynamic, dynamic> selectedUnits = {};
  final UnitBloc bloc = getIt<UnitBloc>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      bloc.add(GetTeacherUnitsEvent(teacherId: widget.teacherId));
    });
  }

  void initializeDefaults(units) {
    Map<dynamic, dynamic> defaultSelectedSubject = {};
    Map<dynamic, dynamic> defaultSelectedUnits = {};

    units.forEach((gradeId, subjects) {
      final firstSubjectId = subjects.keys.first;

      defaultSelectedSubject[gradeId] = firstSubjectId;
      defaultSelectedUnits[gradeId] = subjects[firstSubjectId];
    });

    selectedSubject = defaultSelectedSubject;
    selectedUnits = defaultSelectedUnits;
  }

  void handleSelectSubject(
    dynamic gradeId,
    dynamic subjectId,
    List<dynamic> unitsList,
  ) {
    setState(() {
      selectedSubject[gradeId] = subjectId;
      selectedUnits[gradeId] = unitsList;
    });
  }

  String getGradeName(AppLocalizations loc, dynamic gradeId) {
    final List<Map<String, dynamic>> grades = [
      {"id": 0, "key": "stage_primary_1"},
      {"id": 1, "key": "stage_primary_2"},
      {"id": 2, "key": "stage_primary_3"},
      {"id": 3, "key": "stage_primary_4"},
      {"id": 4, "key": "stage_primary_5"},
      {"id": 5, "key": "stage_primary_6"},
      {"id": 6, "key": "stage_preparatory_1"},
      {"id": 7, "key": "stage_preparatory_2"},
      {"id": 8, "key": "stage_preparatory_3"},
      {"id": 9, "key": "stage_secondary_1"},
      {"id": 10, "key": "stage_secondary_2"},
      {"id": 11, "key": "stage_secondary_3"},
    ];

    final grade = grades.firstWhere((grade) => grade["id"] == gradeId);

    return _getLocalizedStage(grade["key"], loc);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<UnitBloc, UnitState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is GetUnitsFailure) {
          return ErrorScreen(
            message: state.message ?? "Unexpected Error Occur",
          );
        }
        if (state is GetUnitsSuccess) {
          initializeDefaults(state.units);
          return Column(
            children: state.units.entries.map((gradeEntry) {
              final gradeId = gradeEntry.key;
              final subjects = gradeEntry.value as Map<dynamic, dynamic>;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Grade Title
                    Text(
                      getGradeName(loc, gradeId),
                      style: AppTextStyle.primaryStyle.copyWith(fontSize: 20),
                    ),

                    const SizedBox(height: 16),

                    /// Subjects
                    Wrap(
                      spacing: 8,
                      children: subjects.entries.map((subjectEntry) {
                        final subjectId = subjectEntry.key;
                        final unitsList = subjectEntry.value;

                        return ChoiceChip(
                          selectedColor: AppColor.primeryColor,
                          disabledColor: AppColor.mainWhite,
                          showCheckmark: false,
                          label: Text(
                            getSubjectKey(subjectId, loc),
                            style: AppTextStyle.primaryStyle.copyWith(
                              fontSize: 16,
                              color: selectedSubject[gradeId] == subjectId
                                  ? AppColor.mainWhite
                                  : AppColor.primaryTextColor,
                            ),
                          ),
                          selected: selectedSubject[gradeId] == subjectId,
                          onSelected: (_) {
                            handleSelectSubject(gradeId, subjectId, unitsList);
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    /// Units Horizontal List
                    if (selectedUnits[gradeId] != null)
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedUnits[gradeId].length,
                          itemBuilder: (context, index) {
                            final unit = selectedUnits[gradeId][index];

                            return Container(
                              width: 280,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: UnitCard(
                                unit: unit,
                                onTap: () {
                                  /// Bloc event هنا
                                  /// context.read<LectureBloc>().add(
                                  ///   GetLectureByUnitId(unit['id']),
                                  /// );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          );
        }
        return UnitsSectionSkeleton();
      },
    );
  }
}

class UnitCard extends StatelessWidget {
  final dynamic unit;
  final VoidCallback onTap;

  const UnitCard({super.key, required this.unit, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: UnitPlaylistCard(unitCard: unit),
    );
  }
}

String _getLocalizedStage(String key, AppLocalizations loc) {
  switch (key) {
    case "stage_primary_1":
      return loc.stage_primary_1;
    case "stage_primary_2":
      return loc.stage_primary_2;
    case "stage_primary_3":
      return loc.stage_primary_3;
    case "stage_primary_4":
      return loc.stage_primary_4;
    case "stage_primary_5":
      return loc.stage_primary_5;
    case "stage_primary_6":
      return loc.stage_primary_6;
    case "stage_preparatory_1":
      return loc.stage_preparatory_1;
    case "stage_preparatory_2":
      return loc.stage_preparatory_2;
    case "stage_preparatory_3":
      return loc.stage_preparatory_3;

    case "stage_secondary_1":
      return loc.stage_secondary_1;
    case "stage_secondary_2":
      return loc.stage_secondary_2;
    case "stage_secondary_3":
      return loc.stage_secondary_3;

    default:
      return "";
  }
}

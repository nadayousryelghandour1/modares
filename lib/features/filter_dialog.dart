import 'package:flutter/material.dart';
import 'package:modares/bloc/teacher_search/teacher_search_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/features/widget/divider.dart';
import 'package:modares/features/widget/dropdown.dart';
import 'package:modares/l10n/app_localizations.dart';

enum SortOption {
  newest(0),
  rating(2),
  priceHigh(3),
  priceLow(4);

  final int value;
  const SortOption(this.value);
}

enum TeachingMethod {
  online(0),
  offline(1);

  final int value;
  const TeachingMethod(this.value);
}

class FilterOptions {
  String? governorate;
  int? teachingMethod;
  int sortBy;

  FilterOptions({
    this.governorate,
    this.teachingMethod,
    this.sortBy = 2,
  });

  FilterOptions copyWith({
    String? governorate,
    int? teachingMethod,
    int? sortBy,
  }) {
    return FilterOptions(
      governorate: governorate ?? this.governorate,
      teachingMethod: teachingMethod ?? this.teachingMethod,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

class FilterDialog extends StatefulWidget {
  final FilterOptions initial;
  const FilterDialog({super.key, required this.initial});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late FilterOptions _current;

  final List<String> _governorates = [
    'القاهرة',
    'الإسكندرية',
    'بورسعيد',
    'السويس',
    'البحيرة',
    'الدقهلية',
    'دمياط',
    'الغربية',
    'كفر الشيخ',
    'المنوفية',
    'القليوبية',
    'الشرقية',
    'الإسماعيلية',
    'أسيوط',
    'أسوان',
    'بني سويف',
    'الفيوم',
    'الجيزة',
    'الأقصر',
    'المنيا',
    'قنا',
    'سوهاج',
    'مطروح',
    'الوادي الجديد',
    'البحر الأحمر',
    'شمال سيناء',
    'جنوب سيناء',
  ];

  @override
  void initState() {
    super.initState();
    _current = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.mainBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.filterDialogTitle, style: AppTextStyle.primaryStyle),
                IconButton(
                  onPressed: () { setState((){  _current = FilterOptions();getIt<TeacherSearchBloc>().add(ResetFilters());});},
                  
                  icon: Icon(
                    Icons.restart_alt_rounded,
                    color: AppColor.primeryColor,
                    size: 45,
                  ),
                ),
              
              ],
            ),

            const CustomDivider(),

            Text(
              AppLocalizations.of(context)!.governorate,
              style: AppTextStyle.primaryStyle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            CustomDropDown(
              selectedValue: ValueNotifier(_current.governorate),
              items: _governorates,
              onChanged: (val) => setState(() {
                _current = _current.copyWith(governorate: val);
                        getIt<TeacherSearchBloc>().government = val;

              }),
              hint: Text(
                AppLocalizations.of(context)!.chooseGovernorate,
                style: AppTextStyle.primaryStyle.copyWith(fontSize: 16),
              ),
            ),

            const SizedBox(height: 16),
            const CustomDivider(),

            // طريقة التدريس
            Text(
              AppLocalizations.of(context)!.teachingMethod,
              style: AppTextStyle.primaryStyle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _methodChip(AppLocalizations.of(context)!.online, 0),
                _methodChip(AppLocalizations.of(context)!.offline, 1),
              ],
            ),

            const SizedBox(height: 16),
            const CustomDivider(),

            // الترتيب
            Text(
              AppLocalizations.of(context)!.sortBy,
              style: AppTextStyle.primaryStyle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 4),
            _sortTile(AppLocalizations.of(context)!.newest, 0),
            _sortTile(AppLocalizations.of(context)!.topRated, 2),
            _sortTile(AppLocalizations.of(context)!.priceHigh, 3),
            _sortTile(AppLocalizations.of(context)!.priceLow, 4),

            const SizedBox(height: 16),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: const TextStyle(
                        color: AppColor.primaryTextColor,
                        fontFamily: "Cairo",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, _current);
                      getIt<TeacherSearchBloc>().add(ApplyFilters());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primeryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.apply,
                      style: const TextStyle(
                        color: AppColor.mainWhite,
                        fontFamily: "Cairo",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _methodChip(String label, int method) {
    final selected = _current.teachingMethod == method;
    return GestureDetector(
      onTap: () => setState(() {
        _current = _current.copyWith(teachingMethod: selected ? null : method);
        getIt<TeacherSearchBloc>().learningMethod = method;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColor.primeryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? AppColor.primeryColor
                : AppColor.mainGray.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.secondaryStyle.copyWith(
            color: selected ? AppColor.mainWhite : AppColor.primaryTextColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _sortTile(String label, int option) {
    final selected = _current.sortBy == option;
    return InkWell(
      onTap: () => setState(() {
        _current = _current.copyWith(sortBy: option);
        getIt<TeacherSearchBloc>().sortBy = option;
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyle.primaryStyle.copyWith(fontSize: 15),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? AppColor.primeryColor
                      : AppColor.mainGray.withValues(alpha: 0.4),
                  width: 1.5,
                ),
                color: selected ? AppColor.primeryColor : Colors.transparent,
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.mainWhite,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/features/widget/divider.dart';
import 'package:modares/model/quiz_result_model.dart';

class QuizzesTable extends StatefulWidget {
  final List<QuizResultModel> quizzes;

  const QuizzesTable({super.key, required this.quizzes});

  @override
  State<QuizzesTable> createState() => _QuizzesTableState();
}

class _QuizzesTableState extends State<QuizzesTable> {
  // ── Filters ──────────────────────────────────────────────────────────────
  QuizStatus? _statusFilter; // null = الكل
  String? _subjectFilter; // null = الكل

  // ── Pagination ───────────────────────────────────────────────────────────
  int _page = 0;
  final int _rowsPerPage = 10;

  // ── Filtered data ─────────────────────────────────────────────────────────
  List<QuizResultModel> get _filtered {
    return widget.quizzes.where((row) {
      if (_statusFilter != null && row.status != _statusFilter) return false;
      if (_subjectFilter != null && row.subjectName != _subjectFilter) {
        return false;
      }
      return true;
    }).toList();
  }

  List<String> get _subjects {
    final seen = <String>{};
    return widget.quizzes
        .map((e) => e.subjectName ?? '')
        .where((s) => s.isNotEmpty && seen.add(s))
        .toList();
  }

  // ── Status helpers ────────────────────────────────────────────────────────
  String _statusLabel(QuizStatus s) => switch (s) {
    QuizStatus.notTaken => 'لم يمتحن بعد',
    QuizStatus.passed => 'ناجح',
    QuizStatus.needsImprovement => 'تحتاج لتحسين',
    QuizStatus.failed => 'راسب',
  };

  Color _statusBg(QuizStatus s, ColorScheme cs) => switch (s) {
    QuizStatus.notTaken => Colors.transparent,
    QuizStatus.passed => Colors.green.shade50,
    QuizStatus.needsImprovement => Colors.orange.shade50,
    QuizStatus.failed => Colors.red.shade50,
  };

  Color _statusFg(QuizStatus s, ColorScheme cs) => switch (s) {
    QuizStatus.notTaken => cs.onSurface.withOpacity(0.5),
    QuizStatus.passed => Colors.green.shade700,
    QuizStatus.needsImprovement => Colors.orange.shade700,
    QuizStatus.failed => Colors.red.shade700,
  };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final filtered = _filtered;
    final pageRows = filtered
        .skip(_page * _rowsPerPage)
        .take(_rowsPerPage)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ─────────────────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Icon(Icons.event_available, color: AppColor.primeryColor),
              const SizedBox(width: 8),
              Text('سجل الاختبارات', style: AppTextStyle.primaryStyle),
            ],
          ),
        ),
        CustomDivider(),

        // ── Filters ────────────────────────────────────────────────────────
        Container(
          color: Theme.of(context).cardColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // فلتر الحالة
              _FilterChip(
                label: 'الكل',
                selected: _statusFilter == null,
                onTap: () => setState(() {
                  _statusFilter = null;
                  _page = 0;
                }),
              ),
              for (final s in QuizStatus.values)
                _FilterChip(
                  label: _statusLabel(s),
                  selected: _statusFilter == s,
                  selectedColor: _statusBg(s, cs),
                  selectedTextColor: _statusFg(s, cs),
                  onTap: () => setState(() {
                    _statusFilter = _statusFilter == s ? null : s;
                    _page = 0;
                  }),
                ),

              // فاصل
              if (_subjects.isNotEmpty) ...[
                const SizedBox(width: 8),
                Container(width: 1, height: 24, color: AppColor.primeryColor),
                const SizedBox(width: 8),
              ],

              // فلتر المادة
              for (final sub in _subjects)
                _FilterChip(
                  label: sub,
                  selected: _subjectFilter == sub,
                  onTap: () => setState(() {
                    _subjectFilter = _subjectFilter == sub ? null : sub;
                    _page = 0;
                  }),
                ),
            ],
          ),
        ),
        const Divider(height: 1),

        // ── Table ──────────────────────────────────────────────────────────
        Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(),
          elevation: 0,
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints:  BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.92),
                child: DataTable(
                  border: TableBorder.all(
                    color: AppColor.primeryColor, width: 1

                    // inner borders
                    
                  ),

                  headingRowColor: WidgetStateProperty.all(
                    AppColor.primeryColor.withValues(alpha: 0.1),
                  ),

                  columns: [
                    DataColumn(
                      label: Text(
                        'الدرس',
                        style: AppTextStyle.primaryStyle.copyWith(fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'تاريخ',
                            style: AppTextStyle.primaryStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'التقديم',
                            style: AppTextStyle.primaryStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    DataColumn(
                      label: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'نتيجة',
                            style: AppTextStyle.primaryStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'الاختبار',
                            style: AppTextStyle.primaryStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'الحالة',
                        style: AppTextStyle.primaryStyle.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                  rows: pageRows.isEmpty
                      ? [
                          DataRow(
                            cells: [
                              DataCell(Center(child: Text("لا توجد بيانات"))),
                              DataCell(Text("—")),
                              DataCell(Text("—")),
                              DataCell(Text("—")),
                            ],
                          ),
                        ]
                      : pageRows.map((row) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(row.lectureName ?? row.quizName),
                                    if ((row.subjectName ?? '').isNotEmpty)
                                      Text(row.subjectName!),
                                  ],
                                ),
                              ),
                              DataCell(Text(row.displayDate)),
                              DataCell(Text(row.displayScore)),
                              DataCell(
                                Container(
                                  // status widget
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                ),
              ),
            ),
          ),
        ),

        // // ── Pagination ─────────────────────────────────────────────────────
        // Container(
        //   color: Theme.of(context).cardColor,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       const Text('صفوف في الصفحة: '),
        //       DropdownButton<int>(
        //         value: _rowsPerPage,
        //         underline: const SizedBox(),
        //         items: [10, 25, 100]
        //             .map((v) => DropdownMenuItem(value: v, child: Text('$v')))
        //             .toList(),
        //         onChanged: (v) => setState(() {
        //           _rowsPerPage = v!;
        //           _page = 0;
        //         }),
        //       ),
        //       const SizedBox(width: 16),
        //       Text(
        //         '${_page * _rowsPerPage + 1}–'
        //         '${(_page * _rowsPerPage + pageRows.length)} من ${filtered.length}',
        //       ),
        //       IconButton(
        //         icon: const Icon(Icons.chevron_left),
        //         onPressed: _page > 0 ? () => setState(() => _page--) : null,
        //       ),
        //       IconButton(
        //         icon: const Icon(Icons.chevron_right),
        //         onPressed: (_page + 1) * _rowsPerPage < filtered.length
        //             ? () => setState(() => _page++)
        //             : null,
        //       ),
        //       const SizedBox(width: 8),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

// ── Helper chip widget ────────────────────────────────────────────────────────
class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? selectedColor;
  final Color? selectedTextColor;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.selectedColor,
    this.selectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = selected
        ? (selectedColor ?? cs.primary)
        : cs.surfaceContainerHighest;
    final fg = selected ? (selectedTextColor ?? cs.onPrimary) : cs.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? Colors.transparent : cs.outline.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: fg,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/network/services/todo_service.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/model/todo_model.dart';

class TodoBar extends StatefulWidget {
  const TodoBar({super.key});

  @override
  State<TodoBar> createState() => _TodoBarState();
}

class _TodoBarState extends State<TodoBar> {
  final _todoService = TodoService();
  final _titleController = TextEditingController();
  DateTime? _selectedDueDate;
  Duration? _selectedTimeout;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _showAddDialog() {
    _titleController.clear();
    _selectedDueDate = null;
    _selectedTimeout = null;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColor.mainWhite,
          title: const Text('مهمة جديدة', style: AppTextStyle.primaryStyle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Title ───────────────────────────────────────────────────
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'عنوان المهمة',
                  hintText: 'ادخل عنوان المهمة',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // ── Due Date ─────────────────────────────────────────────────
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  _selectedDueDate == null
                      ? 'اختر تاريخ الانتهاء'
                      : '${_selectedDueDate!.day}/${_selectedDueDate!.month}/${_selectedDueDate!.year}',
                  style: const TextStyle(fontFamily: 'Cairo'),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: ctx,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: ctx,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setDialogState(() {
                        _selectedDueDate = DateTime(
                          date.year, date.month, date.day,
                          time.hour, time.minute,
                        );
                      });
                    }
                  }
                },
              ),

              // ── Timeout ──────────────────────────────────────────────────
              if (_selectedDueDate != null)
                DropdownButtonFormField<Duration>(
                  decoration: const InputDecoration(
                    labelText: 'تنبيه قبل',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedTimeout,
                  items: const [
                    DropdownMenuItem(value: Duration(minutes: 30), child: Text('30 دقيقة')),
                    DropdownMenuItem(value: Duration(hours: 1),    child: Text('ساعة')),
                    DropdownMenuItem(value: Duration(hours: 2),    child: Text('ساعتين')),
                    DropdownMenuItem(value: Duration(days: 1),     child: Text('يوم')),
                  ],
                  onChanged: (v) => setDialogState(() => _selectedTimeout = v),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text.trim().isEmpty) return;
                await _todoService.addTodo(
                  _titleController.text.trim(),
                  dueDate: _selectedDueDate,
                  timeout: _selectedTimeout,
                );
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('إضافة'),
            ),
          ],
        ),
      ),
    );
  }

  String _dueDateLabel(TodoModel todo) {
    if (todo.dueDate == null) return '';
    final d = todo.dueDate!;
    final now = DateTime.now();
    final diff = d.difference(now);
    if (todo.isOverdue) return 'متأخر!';
    if (diff.inDays == 0) return 'اليوم';
    if (diff.inDays == 1) return 'غداً';
    if (diff.inDays < 7) return '${diff.inDays} أيام';
    return '${d.day}/${d.month}';
  }

  Color _dueDateColor(TodoModel todo) {
    if (todo.isOverdue) return Colors.red;
    if (todo.isNearDue) return Colors.orange;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.mainWhite,
        border: Border.all(
          color: AppColor.mainGray.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Header ────────────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'قائمة المهام',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cairo',
                ),
              ),
              IconButton(
                onPressed: _showAddDialog,
                icon: const Icon(Icons.add_circle, color: AppColor.primeryColor, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // ── List ──────────────────────────────────────────────────────────
          SizedBox(
            height: 180,
            child: StreamBuilder<List<TodoModel>>(
              stream: _todoService.getTodos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final todos = snapshot.data ?? [];

                if (todos.isEmpty) {
                  return const Center(
                    child: Text(
                      'لا يوجد مهام',
                      style: AppTextStyle.primaryStyle,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return Dismissible(
                      key: Key(todo.id),
                      direction: DismissDirection.horizontal,
                      onDismissed: (_) async {
                        await _todoService.deleteTodo(todo.id);
                      },
                      background: const Icon(
                        Icons.delete,
                        color: AppColor.mainGold,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,

                          // ── Checkbox ──────────────────────────────────────
                          leading: GestureDetector(
                            onTap: () => _todoService.toggleTodo(
                              todo.id,
                              todo.isDone,
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: todo.isDone
                                  ? const Icon(Icons.check, color: AppColor.primeryColor)
                                  : const Icon(Icons.check_box_outline_blank, color: Colors.white),
                            ),
                          ),

                          // ── Title + Due Date ──────────────────────────────
                          title: Row(
                            children: [
                              SizedBox(
                                width: 155,
                                child: Text(
                                  todo.title,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    decoration: todo.isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: todo.isDone ? Colors.grey : Colors.black,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              if (todo.dueDate != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: _dueDateColor(todo)),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    _dueDateLabel(todo),
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: _dueDateColor(todo),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
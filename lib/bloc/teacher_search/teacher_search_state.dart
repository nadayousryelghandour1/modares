part of 'teacher_search_bloc.dart';

abstract class TeacherSearchState extends Equatable {
  const TeacherSearchState();

  @override
  List<Object?> get props => [];
}

// 🟡 Initial
class TeacherSearchInitial extends TeacherSearchState {}

// 🔄 Loading
class TeacherSearchLoading extends TeacherSearchState {}

// ✅ Success - فيه الداتا + الفلاتر
class TeacherSearchLoaded extends TeacherSearchState {
  final List<TeacherModel> teachers; // الداتا الأصلية من الـ API
  final List<TeacherModel> displayedTeachers; // الداتا بعد الفلتر

  const TeacherSearchLoaded({
    required this.teachers,
    required this.displayedTeachers,
  });

  TeacherSearchLoaded copyWith({
    List<TeacherModel>? teachers,
    List<TeacherModel>? displayedTeachers,
  }) {
    return TeacherSearchLoaded(
      teachers: teachers ?? this.teachers,
      displayedTeachers: displayedTeachers ?? this.displayedTeachers,
    );
  }

  @override
  List<Object?> get props => [teachers, displayedTeachers];
}

// ❌ Error
class TeacherSearchError extends TeacherSearchState {
  final dynamic errors;
  final String? message;

  const TeacherSearchError({required this.errors, this.message});

  @override
  List<Object?> get props => [message];
}

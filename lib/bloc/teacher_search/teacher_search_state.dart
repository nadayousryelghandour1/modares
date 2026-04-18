// /// The above class defines the initial state for a teacher search feature in a Dart application.
// /// The above class defines the initial state for a teacher search feature in a Dart application.
// part of 'teacher_search_bloc.dart';

// /// الأساس
// abstract class TeacherSearchState extends Equatable {
//   const TeacherSearchState();

//   @override
//   List<Object?> get props => [];
// }

// /// 🟡 Initial
// class TeacherSearchInitial extends TeacherSearchState {}

// /// 🔄 Loading
// class TeacherSearchLoading extends TeacherSearchState {}

// /// ✅ Loaded (فيه الداتا + الفلاتر)
// class TeacherSearchLoaded extends TeacherSearchState {
//   final List<TeacherModel> teachers;
//   final String course;
//   final String learningMethod;
//   final String governorate;
//   final String teacherName;
//   final String studentLevel;
//   final String sortBy;


//   const TeacherSearchLoaded({
//     required this.teachers,
//     this.course = "",
//     this.learningMethod = "all",
//     this.governorate = "",
//     this.teacherName = "",
//     this.studentLevel = "",
//     this.sortBy = "rating",

//   });

//   TeacherSearchLoaded copyWith({
//     List<TeacherModel>? teachers,
//     String? course,
//     String? learningMethod,
//     String? governorate,
//     String? teacherName,
//     String? studentLevel,
//     String? sortBy,

//   }) {
//     return TeacherSearchLoaded(
//       teachers: teachers ?? this.teachers,
//       filteredTeachers: filteredTeachers ?? this.filteredTeachers,
//       course: course ?? this.course,
//       learningMethod: learningMethod ?? this.learningMethod,
//       governorate: governorate ?? this.governorate,
//       teacherName: teacherName ?? this.teacherName,
//       studentLevel: studentLevel ?? this.studentLevel,
//       sortBy: sortBy ?? this.sortBy,

//     );
//   }

//   @override
//   List<Object?> get props => [
//     teachers,
//     filteredTeachers,
//     course,
//     learningMethod,
//     governorate,
//     teacherName,
//     studentLevel,
//     sortBy,
//     page,
//     pageSize,
//   ];
// }

// /// ❌ Error
// class TeacherSearchError extends TeacherSearchState {
//   final String message;

//   const TeacherSearchError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

part of 'teacher_search_bloc.dart';

@immutable
abstract class TeacherSearchEvent {}

/// 📥 تحميل أولي
class GetAllTeacher extends TeacherSearchEvent {
  GetAllTeacher();
}

/// 🎯 اختيار المادة
class SetSubject extends TeacherSearchEvent {
  final String subject;
  SetSubject(this.subject);
}

/// 🎯 اختيار طريقة التدريس (online / offline / all)
class SetLearningMethod extends TeacherSearchEvent {
  final String learningMethod;
  SetLearningMethod(this.learningMethod);
}

/// 🎯 اختيار المحافظة
class SetGovernorate extends TeacherSearchEvent {
  final String governorate;
  SetGovernorate(this.governorate);
}

/// 🔍 البحث بالاسم
class SetTeacherName extends TeacherSearchEvent {
  final String teacherName;
  SetTeacherName(this.teacherName);
}

/// 📊 ترتيب (price / rating)
class SetSortBy extends TeacherSearchEvent {
  final String sortBy;

  SetSortBy({required this.sortBy});
}

/// 🎓 المرحلة الدراسية
class SetStudentLevel extends TeacherSearchEvent {
  final String studentLevel;
  SetStudentLevel(this.studentLevel);
}

/// ✅ تطبيق الفلاتر (API call)
class ApplyFilters extends TeacherSearchEvent {
  ApplyFilters();
}

/// 🔄 إعادة تعيين الفلاتر
class ResetFilters extends TeacherSearchEvent {
  ResetFilters();
}

part of 'teacher_search_bloc.dart';

@immutable
abstract class TeacherSearchEvent {}

/// 📥 تحميل أولي
class GetAllTeacher extends TeacherSearchEvent {}
/// ✅ تطبيق الفلاتر (API call)
class ApplyFilters extends TeacherSearchEvent {}

/// 🔄 إعادة تعيين الفلاتر
class ResetFilters extends TeacherSearchEvent {}

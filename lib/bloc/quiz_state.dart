part of 'quiz/quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();
  
  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

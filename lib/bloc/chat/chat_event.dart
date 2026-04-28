// chat_event.dart
part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class OpenChat extends ChatEvent {
  final UserModel currentUser;
  final String teacherEmail;

  const OpenChat({required this.currentUser, required this.teacherEmail});

  @override
  List<Object?> get props => [currentUser, teacherEmail];
}

class SendMessage extends ChatEvent {
  final UserModel currentUser;
  final String teacherEmail;
  final String text;

  const SendMessage({
    required this.currentUser,
    required this.teacherEmail,
    required this.text,
  });

  @override
  List<Object?> get props => [currentUser, teacherEmail, text];
}

class MessagesUpdated extends ChatEvent {
  final List<MessageModel> messages;

  const MessagesUpdated({required this.messages});

  @override
  List<Object?> get props => [messages];
}

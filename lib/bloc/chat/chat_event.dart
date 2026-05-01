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
  final String teacherName;  
  final String? teacherImage; 

  const OpenChat({
    required this.currentUser,
    required this.teacherEmail,
    required this.teacherName,
    this.teacherImage,
  });
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

class MessagesFailed extends ChatEvent {
  final String message;

  const MessagesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

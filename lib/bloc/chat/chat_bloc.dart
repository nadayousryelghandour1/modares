// chat_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/network/services/chat.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/model/user_model.dart';
import 'package:modares/model/message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService _chatService = getIt<ChatService>();
  StreamSubscription? _messagesSubscription; 

  ChatBloc() : super(ChatInitial()) {
    on<OpenChat>(_onOpenChat);
    on<SendMessage>(_onSendMessage);
    on<MessagesUpdated>(_onMessagesUpdated);
  }

  Future<void> _onOpenChat(OpenChat event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final user = await CacheHelper.getUser();
    try {
      await _chatService.createConversationIfNotExists(
        currentUser: user,
        teacherEmail: event.teacherEmail,
        teacherImage: event.teacherImage,
        teacherName: event.teacherName
      );

     
     
     
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      await _chatService.sendMessage(
        currentUser: event.currentUser,
        teacherEmail: event.teacherEmail,
        text: event.text,
      );
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  void _onMessagesUpdated(MessagesUpdated event, Emitter<ChatState> emit) {
    emit(ChatLoaded(messages: event.messages));
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
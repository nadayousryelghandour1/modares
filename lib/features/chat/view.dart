// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modares/bloc/chat/chat_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/features/widget/custom_field.dart';
import 'package:modares/model/user_model.dart';

class ChatPage extends StatefulWidget {
  final UserModel currentUser;
  final String teacherEmail;
  final String teacherName;
  final String? teacherImage;

  const ChatPage({
    super.key,
    required this.currentUser,
    required this.teacherEmail,
    required this.teacherName,
    this.teacherImage,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _message = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ChatBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<ChatBloc>();
    _bloc.add(
      OpenChat(
        teacherEmail: widget.teacherEmail,
        teacherName: widget.teacherName,
        teacherImage: widget.teacherImage,
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_message.text.trim().isEmpty) return;
    _bloc.add(
      SendMessage(
        currentUser: widget.currentUser,
        teacherEmail: widget.teacherEmail,
        text: _message.text.trim(),
      ),
    );
    _message.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.mainBackground,
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColor.primeryColor.withValues(alpha: 0.1),
              backgroundImage: widget.teacherImage != null
                  ? NetworkImage(widget.teacherImage!)
                  : null,
              child: widget.teacherImage == null
                  ? Text(
                      widget.teacherName[0],
                      style: AppTextStyle.primaryStyle.copyWith(
                        color: AppColor.primeryColor,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(widget.teacherName, style: AppTextStyle.primaryStyle),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        elevation: 0,

        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              // child: Image.asset(AppImage.chatBackground, fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              // Messages
              Expanded(
                child: BlocConsumer<ChatBloc, ChatState>(
                  bloc: _bloc,
                  listener: (context, state) {
                    if (state is ChatLoaded) _scrollToBottom();
                  },
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ChatError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is ChatLoaded) {
                      if (state.messages.isEmpty) {
                        return Center(
                          child: Text(
                            "ابدأ المحادثة مع ${widget.teacherName}",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        );
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8),
                        itemCount: state.messages.length,
                        itemBuilder: (_, index) {
                          final msg = state.messages[index];
                          final isMe = msg.senderId == widget.currentUser.email;
                          String _formatTime(int ms) {
                            final date = DateTime.fromMillisecondsSinceEpoch(
                              ms,
                            );
                            final hour = date.hour > 12
                                ? date.hour - 12
                                : date.hour;
                            final minute = date.minute.toString().padLeft(
                              2,
                              '0',
                            );
                            final period = date.hour >= 12 ? 'PM' : 'AM';

                            return '$hour:$minute $period';
                          }

                          return Align(
  alignment: isMe
      ? Alignment.centerRight
      : Alignment.centerLeft,
  child: IntrinsicWidth(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isMe
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        BubbleSpecialThree(
          text: msg.text,
          color: isMe
              ? AppColor.primeryColor
              : Colors.grey[200]!,
          isSender: isMe,
          tail: true,
          textStyle: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
            fontSize: 16,
            fontFamily: "Cairo",
            fontWeight: FontWeight.w500
          ),
          delivered: true,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          child: Text(
            _formatTime(msg.createdAtMs),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: "Cairo",
            ),
          ),
        ),
      ],
    ),
  ),
);
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),

              // Input
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: AppColor.primeryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomField(
                        hint: "اكتب رسالتك...",
                        controller: _message,
                        onChange: (val) {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: _sendMessage,
                        icon: Icon(Icons.send, color: AppColor.primeryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _message.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

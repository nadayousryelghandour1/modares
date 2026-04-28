import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/consts.dart';
import 'package:modares/features/widget/custom_field.dart';
import 'package:modares/model/chat_model.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  // ImagePicker
  TextEditingController message = TextEditingController();
  String myName= "chat1";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: chat.length,
              itemBuilder: (_, index) {
                return BubbleSpecialThree(
                  text: chat[index].text,
                  color: const Color(0xFF1B97F3),
                  // isSender: chat[index].senderName == ,
                  tail: true,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                );
              },
            ),
          ),
          AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                      hint: "write your message",
                      controller: message,
                      onChange: (val) {
                        message.text = val;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.mainWhite,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          chat.add(ChatModel(message: message.text, senderName: "chat1"));
                          message.clear();
                        });
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

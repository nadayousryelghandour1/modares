import 'package:flutter/material.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/network/services/chat.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/features/chat/view.dart';
import 'package:modares/model/user_model.dart';

// ignore: must_be_immutable
class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await CacheHelper.getUser();
    setState(() => _user = user);
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: AppColor.mainBackground,
        title: const Text(
          "المحادثات",
          style: TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: StreamBuilder(
        stream: getIt<ChatService>().getConversations(_user!.email.toString()),
        builder: (context, snapshot) {
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // error
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          // فاضي
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImage.noConversations),
                  const SizedBox(height: 16),
                  Text(
                    "مفيش محادثات لحد دلوقتي",
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  ),
                ],
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: docs.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.15),
              indent: 80,
            ),
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
 
              return _ConversationItem(
                data: data,
                currentUserId: _user!.id.toString(),
                onTap: () {
                  // هنروح لصفحة الـ chat
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(
                        currentUser: _user!,
                        teacherEmail: data['teacherEmail'],
                        teacherName: data['teacherName'],
                        teacherImage: data['teacherImage'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _ConversationItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final String currentUserId;
  final VoidCallback onTap;

  const _ConversationItem({
    required this.data,
    required this.currentUserId,
    required this.onTap,
  });

  String _formatTime(int? ms) {
    if (ms == null || ms == 0) return "";
    final dt = DateTime.fromMillisecondsSinceEpoch(ms);
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) return "الآن";
    if (diff.inHours < 1) return "منذ ${diff.inMinutes} د";
    if (diff.inDays < 1) return "منذ ${diff.inHours} س";
    if (diff.inDays < 7) return "منذ ${diff.inDays} يوم";
    return "${dt.day}/${dt.month}/${dt.year}";
  }

  @override
  Widget build(BuildContext context) {
    final teacherName = data['teacherName'] ?? "مدرس";
    final teacherImage = data['teacherImage'];
    final lastMessage = data['lastMessageText'] ?? "";
    final lastMessageMs = data['lastMessageAtMs'];
    final isMe = data['lastMessageSenderId'] == currentUserId;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.mainWhite.withValues(alpha: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // صورة المدرس
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColor.primeryColor.withOpacity(0.1),
                backgroundImage: teacherImage != null
                    ? NetworkImage(teacherImage)
                    : null,
                child: teacherImage == null
                    ? Text(
                        teacherName[0],
                        style: TextStyle(
                          color: AppColor.primeryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    : null,
              ),
        
              const SizedBox(width: 12),
        
              // الاسم والمسج
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          teacherName,
                          style: const TextStyle(
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          _formatTime(lastMessageMs),
                          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lastMessage.isEmpty
                          ? "ابدأ المحادثة..."
                          : isMe
                          ? "أنت: $lastMessage"
                          : lastMessage,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontFamily: "Cairo",
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

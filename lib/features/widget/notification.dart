// notification_page.dart
import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'الإشعارات',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('اليوم'),
          _buildNotificationItem(
            icon: Icons.check_circle,
            iconColor: AppColor.primeryColor,
            title: 'تم تأكيد حجز جلسة مباشرة',
            subtitle: 'د. محمد حسن — الأحد 1 يونيو الساعة 10:00 ص',
            time: 'منذ 10 دقائق',
            isRead: false,
          ),
          _buildNotificationItem(
            icon: Icons.assignment_late,
            iconColor: Colors.red,
            title: 'مهمة متأخرة!',
            subtitle: 'مراجعة خطة الدراسة لم تكتمل بعد',
            time: 'منذ ساعة',
            isRead: false,
          ),
          _buildNotificationItem(
            icon: Icons.star,
            iconColor: Colors.amber,
            title: 'تقييم جديد',
            subtitle: 'قام طالب بتقييم محاضرتك بـ 5 نجوم',
            time: 'منذ 3 ساعات',
            isRead: true,
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('الأمس'),
          _buildNotificationItem(
            icon: Icons.video_call,
            iconColor: AppColor.primeryColor,
            title: 'جلسة مباشرة قادمة',
            subtitle: 'تبدأ جلستك مع د. أحمد غداً الساعة 2:00 م',
            time: 'أمس 8:00 م',
            isRead: true,
          ),
          _buildNotificationItem(
            icon: Icons.payment,
            iconColor: Colors.green,
            title: 'تم الدفع بنجاح',
            subtitle: 'تم شراء وحدة "الجبر المتقدم" بنجاح',
            time: 'أمس 5:30 م',
            isRead: true,
          ),
          _buildNotificationItem(
            icon: Icons.message,
            iconColor: AppColor.primeryColor,
            title: 'رسالة جديدة',
            subtitle: 'د. سارة: "موعد الجلسة القادمة تم تأكيده"',
            time: 'أمس 3:00 م',
            isRead: true,
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('هذا الأسبوع'),
          _buildNotificationItem(
            icon: Icons.book,
            iconColor: Colors.orange,
            title: 'محتوى جديد',
            subtitle: 'تمت إضافة درس جديد في وحدة "التفاضل والتكامل"',
            time: 'الجمعة 10:00 ص',
            isRead: true,
          ),
          _buildNotificationItem(
            icon: Icons.warning_amber,
            iconColor: Colors.orange,
            title: 'تذكير بمهمة',
            subtitle: 'موعد تسليم "تقرير الأداء الشهري" بعد يومين',
            time: 'الخميس 9:00 ص',
            isRead: true,
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    required bool isRead,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : AppColor.primeryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRead
              ? Colors.grey.withValues(alpha: 0.15)
              : AppColor.primeryColor.withValues(alpha: 0.2),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            if (!isRead)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColor.primeryColor,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 11,
                color: Colors.grey.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
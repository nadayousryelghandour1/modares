
// ignore_for_file: unused_element

// ─────────────────────────────────────────────
// PAYMENT METHOD MODEL
// ─────────────────────────────────────────────
import 'dart:ui';

class _PaymentMethod {
  final String key;
  final String label;
  final Color color;
  final bool disabled;
  final int integrationId;

  const _PaymentMethod({
    required this.key,
    required this.label,
    required this.color,
    required this.integrationId,
    this.disabled = false,
  });
}

// const List<_PaymentMethod> _methods = [
//   _PaymentMethod(
//     key: 'Card',
//     label: 'فيزا / ماستركارد',
//     color: Color(0xFF1a1f71),
//     integrationId: 5633982,
//   ),
//   _PaymentMethod(
//     key: 'Wallet',
//     label: 'محفظة فودافون (قريباً)',
//     color: Color(0xFFe60000),
//     integrationId: 5633984,
//     disabled: true,
//   ),
//   _PaymentMethod(
//     key: 'Kiosk',
//     label: 'فوري (قريباً)',
//     color: Color(0xFFf7a800),
//     integrationId: 5634095,
//     disabled: true,
//   ),
//   _PaymentMethod(
//     key: 'PayPal',
//     label: 'PayPal (قريباً)',
//     color: Color(0xFF003087),
//     integrationId: 5634090,
//     disabled: true,
//   ),
// ];

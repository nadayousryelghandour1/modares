import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

const _blue = Color(0xFF1b4fa8);
const _yellow = Color(0xFFf5a623);

class _ElData {
  final String id, type;
  final double ox, oy, opacity, dur, delay;
  final Color color;
  final String? char;
  final double? size, r, rotate;
  const _ElData({
    required this.id,
    required this.type,
    required this.ox,
    required this.oy,
    required this.color,
    required this.opacity,
    required this.dur,
    required this.delay,
    this.char,
    this.size,
    this.r,
    this.rotate,
  });
}

class _AtomData {
  final String id;
  final double x, y, nucleus, rx, ry, opacity;
  final double? spinDur;
  final bool reverse;
  const _AtomData({
    required this.id,
    required this.x,
    required this.y,
    required this.nucleus,
    required this.rx,
    required this.ry,
    required this.opacity,
    this.spinDur,
    this.reverse = false,
  });
}

const _els = [
  // العناصر الأصلية
  _ElData(id: "book1", type: "book", ox: 140, oy: 340, color: _blue, opacity: .35, dur: 8, delay: 0),
  _ElData(id: "book2", type: "book", ox: 490, oy: 370, color: _blue, opacity: .3, dur: 11, delay: 2.5),
  _ElData(id: "book3", type: "book", ox: 300, oy: 100, color: _blue, opacity: .2, dur: 13, delay: 1),
  _ElData(id: "pen1", type: "pencil", ox: 230, oy: 380, color: _yellow, opacity: .4, dur: 9, delay: 1, rotate: -30),
  _ElData(id: "pen2", type: "pencil", ox: 400, oy: 360, color: _yellow, opacity: .3, dur: 12, delay: 4, rotate: 20),
  _ElData(id: "pen3", type: "pencil", ox: 600, oy: 200, color: _yellow, opacity: .2, dur: 10, delay: 3, rotate: 10),
  _ElData(id: "sigma", type: "text", ox: 320, oy: 370, color: _blue, opacity: .3, dur: 10, delay: 3, char: "Σ", size: 28),
  _ElData(id: "pi", type: "text", ox: 560, oy: 350, color: _blue, opacity: .25, dur: 7, delay: 1.5, char: "π", size: 26),
  _ElData(id: "int", type: "text", ox: 70, oy: 370, color: _blue, opacity: .2, dur: 13, delay: 5, char: "∫", size: 30),
  _ElData(id: "delta", type: "text", ox: 460, oy: 390, color: _yellow, opacity: .3, dur: 9.5, delay: 6, char: "Δ", size: 24),
  _ElData(id: "inf", type: "text", ox: 160, oy: 130, color: _blue, opacity: .18, dur: 11, delay: 2, char: "∞", size: 26),
  _ElData(id: "sqrt", type: "text", ox: 450, oy: 150, color: _yellow, opacity: .2, dur: 8, delay: 4, char: "√", size: 28),
  _ElData(id: "dot1", type: "dot", ox: 190, oy: 360, color: _yellow, opacity: .4, dur: 6, delay: .5, r: 4),
  _ElData(id: "dot2", type: "dot", ox: 350, oy: 390, color: _blue, opacity: .35, dur: 8, delay: 2, r: 3),
  _ElData(id: "dot3", type: "dot", ox: 530, oy: 380, color: _yellow, opacity: .3, dur: 11, delay: 4.5, r: 4),
  _ElData(id: "dot4", type: "dot", ox: 280, oy: 395, color: _blue, opacity: .25, dur: 7, delay: 3.5, r: 3),

  // عناصر جديدة فوق السكرين
  _ElData(id: "bookTop1", type: "book", ox: 200, oy: 60, color: _blue, opacity: .3, dur: 9, delay: 2),
  _ElData(id: "penTop1", type: "pencil", ox: 400, oy: 70, color: _yellow, opacity: .35, dur: 10, delay: 3, rotate: 15),
  _ElData(id: "piTop", type: "text", ox: 300, oy: 50, color: _blue, opacity: .25, dur: 8, delay: 1, char: "π", size: 28),
];

const _atoms = [
  _AtomData(id: "atom1", x: 80, y: 200, nucleus: 6, rx: 30, ry: 10, opacity: .2, spinDur: 6),
  _AtomData(id: "atom2", x: 570, y: 120, nucleus: 10, rx: 40, ry: 15, opacity: .25, spinDur: 4),
  _AtomData(id: "atom3", x: 620, y: 340, nucleus: 10, rx: 40, ry: 14, opacity: .2, spinDur: 6, reverse: true),
];

// باقي الكود زي ما هو، مع تعديل في _drawAtoms
// بدل a.nucleus - 2 خلي الإلكترون بحجم ثابت أكبر


// ══════════════════════════════════════════════════════════════
//  PHYSICS
// ══════════════════════════════════════════════════════════════

class _Phys {
  double cx, cy, vx = 0, vy = 0;
  final double ox, oy;
  _Phys(this.ox, this.oy) : cx = ox, cy = oy;
}

// ══════════════════════════════════════════════════════════════
//  WIDGET
// ══════════════════════════════════════════════════════════════

class MudarrisBackground extends StatefulWidget {
  const MudarrisBackground({super.key});

  @override
  State<MudarrisBackground> createState() => _State();
}

class _State extends State<MudarrisBackground> with TickerProviderStateMixin {
  // physics
  late final Ticker _ticker;
  final _phys = <String, _Phys>{
    for (final e in _els) e.id: _Phys(e.ox, e.oy),
    for (final a in _atoms) a.id: _Phys(a.x, a.y),
  };

  // float progress per element (0..1, loops)
  final _float = <String, double>{for (final e in _els) e.id: 0};

  // atom spin angle per atom (radians)
  final _spin = <String, double>{for (final a in _atoms) a.id: 0};

  Offset _touch = const Offset(-9999, -9999);
  double _lastMs = 0;
  Size _paintSize = Size.zero;

  static const _repelRadius = 130.0;
  static const _repelStrength = 55.0;
  static const _damping = 0.88;
  static const _spring = 0.038;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final ms = elapsed.inMicroseconds / 1000.0;
    final dt = (_lastMs == 0) ? 16.0 : (ms - _lastMs).clamp(1.0, 50.0);
    _lastMs = ms;
    final dtN = dt / 16.0; // normalised to 60fps

    final mx = _touch.dx;
    final my = _touch.dy;

    // ── float progress ──
    for (final e in _els) {
      _float[e.id] = (_float[e.id]! + dtN / (e.dur * 60)) % 1.0;
    }

    // ── atom spin ──
    for (final a in _atoms) {
      if (a.spinDur == null) continue;
      final delta = dtN / (a.spinDur! * 60) * pi * 2;
      _spin[a.id] = (_spin[a.id]! + (a.reverse ? -delta : delta));
    }

    // ── physics (elements + atoms) ──
    for (final id in _phys.keys) {
      final p = _phys[id]!;
      final dx = p.cx - mx;
      final dy = p.cy - my;
      final dist = sqrt(dx * dx + dy * dy);

      double fx = 0, fy = 0;
      if (dist < _repelRadius && dist > 0.5) {
        final t = 1 - dist / _repelRadius;
        final force = t * t * _repelStrength;
        fx = (dx / dist) * force;
        fy = (dy / dist) * force;
      }
      fx += (p.ox - p.cx) * _spring;
      fy += (p.oy - p.cy) * _spring;

      p.vx = (p.vx + fx * dtN) * _damping;
      p.vy = (p.vy + fy * dtN) * _damping;
      p.cx += p.vx;
      p.cy += p.vy;
    }

    setState(() {});
  }

  Offset _toViewBox(Offset local) => Offset(
    local.dx * 680 / _paintSize.width,
    local.dy * 420 / _paintSize.height,
  );

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        _paintSize = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          onPanUpdate: (d) => _touch = _toViewBox(d.localPosition),
          onPanEnd: (_) => _touch = const Offset(-9999, -9999),
          onPanCancel: () => _touch = const Offset(-9999, -9999),
          child: CustomPaint(
            painter: _Painter(
              els: _els,
              atoms: _atoms,
              phys: _phys,
              float: _float,
              spin: _spin,
            ),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  PAINTER
// ══════════════════════════════════════════════════════════════

class _Painter extends CustomPainter {
  final List<_ElData> els;
  final List<_AtomData> atoms;
  final Map<String, _Phys> phys;
  final Map<String, double> float, spin;

  _Painter({
    required this.els,
    required this.atoms,
    required this.phys,
    required this.float,
    required this.spin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale((size.width / 680) , (size.height / 420) );

    _dotGrid(canvas);
    _drawAtoms(canvas);
    _drawElements(canvas);

    canvas.restore();
  }

  // ── dot grid ──────────────────────────────────────────────
  void _dotGrid(Canvas canvas) {
    final p = Paint()..color = _blue.withOpacity(0.06);
    for (final x in [60, 180, 300, 420, 540, 660]) {
      for (final y in [60, 160, 260, 360]) {
        canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1.5, p);
      }
    }
  }

  // ── atoms ─────────────────────────────────────────────────
  void _drawAtoms(Canvas canvas) {
    for (final a in atoms) {
      final p = phys[a.id]!;
      canvas.save();
      canvas.translate(p.cx, p.cy);

      // nucleus
      canvas.drawCircle(
        Offset.zero,
        a.nucleus,
        Paint()..color = _blue.withOpacity(a.opacity),
      );

      // 3 orbital rings at 0°, 60°, 120°
      final ringPaint = Paint()
        ..color = _blue.withOpacity(a.opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;

      for (final angle in [0.0, pi / 3, 2 * pi / 3]) {
        canvas.save();
        canvas.rotate(angle);
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset.zero,
            width: a.rx * 2,
            height: a.ry * 2,
          ),
          ringPaint,
        );
        canvas.restore();
      }

      // spinning electron
      if (a.spinDur != null) {
        final angle = spin[a.id] ?? 0;
        canvas.save();
        canvas.rotate(angle);
        canvas.drawCircle(
          Offset(a.rx, 0),
          a.nucleus - 2,
          Paint()..color = _yellow.withOpacity(a.opacity + 0.1),
        );
        canvas.restore();
      } else {
        // static electron
        canvas.drawCircle(
          Offset(a.rx, 0),
          2.5,
          Paint()..color = _yellow.withOpacity(a.opacity),
        );
      }

      canvas.restore();
    }
  }

  // ── elements ──────────────────────────────────────────────
  void _drawElements(Canvas canvas) {
    for (final el in els) {
      final p = phys[el.id]!;
      final t = float[el.id] ?? 0;

      // مراعاة الـ delay — مش هيظهر لحد ما الـ delay يعدي
      final floatY = -sin(t * pi) * 70;
      final floatX = sin(t * pi) * (el.id.hashCode.isEven ? 8 : -10);
      final opacity = _floatOpacity(t) * el.opacity;

      canvas.save();
      canvas.translate(p.cx + floatX, p.cy + floatY);

      switch (el.type) {
        case "book":
          _book(canvas, el.color, opacity);
        case "pencil":
          _pencil(canvas, el.color, opacity, el.rotate ?? 0);
        case "text":
          _char(canvas, el.char!, el.size!, el.color, opacity);
        case "dot":
          _dot(canvas, el.r!, el.color, opacity);
      }

      canvas.restore();
    }
  }

  // float opacity curve: 0→1 (10%) → 0.5 (90%) → 0
  double _floatOpacity(double t) {
    if (t < 0.1) return t / 0.1;
    if (t < 0.9) return 1 - (t - 0.1) / 0.8 * 0.5;
    return (1 - t) / 0.1 * 0.5;
  }

  // ── shapes ────────────────────────────────────────────────
  void _book(Canvas canvas, Color c, double op) {
    final stroke = Paint()
      ..color = c.withOpacity(op)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final thin = Paint()
      ..color = c.withOpacity(op * .85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = .8;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-10, -8, 20, 16),
        const Radius.circular(2),
      ),
      stroke,
    );
    canvas.drawLine(
      const Offset(-2, -8),
      const Offset(-2, 8),
      stroke..strokeWidth = 1.0,
    );
    for (final y in [-3.0, 0.0, 3.0]) {
      canvas.drawLine(Offset(-8, y), Offset(-4, y), thin);
    }
  }

  void _pencil(Canvas canvas, Color c, double op, double rotateDeg) {
    canvas.save();
    canvas.rotate(rotateDeg * pi / 180);

    final stroke = Paint()
      ..color = c.withOpacity(op)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-2, -12, 4, 18),
        const Radius.circular(1),
      ),
      stroke,
    );

    final tip = Path()
      ..moveTo(0, -14)
      ..lineTo(-2, -12)
      ..lineTo(2, -12)
      ..close();
    canvas.drawPath(tip, Paint()..color = c.withOpacity(op));
    canvas.drawLine(
      const Offset(-2, 4),
      const Offset(2, 4),
      stroke..strokeWidth = 1.0,
    );

    canvas.restore();
  }

  void _char(Canvas canvas, String ch, double fontSize, Color c, double op) {
    final tp = TextPainter(
      text: TextSpan(
        text: ch,
        style: TextStyle(
          fontSize: fontSize,
          color: c.withOpacity(op),
          fontFamily: 'serif',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
  }

  void _dot(Canvas canvas, double r, Color c, double op) =>
      canvas.drawCircle(Offset.zero, r, Paint()..color = c.withOpacity(op));

  @override
  bool shouldRepaint(_Painter old) => true;
}

// =============================================================================
// FLUTTER ANIMATION LEARNING MAP (this page is a hands-on lab, not production UI)
// =============================================================================
// 1) Implicit animations — Widgets that own their own AnimationController under
//    the hood (AnimatedOpacity, AnimatedScale, AnimatedContainer). Best when the
//    start/end state is known and you want minimal code.
// 2) Explicit animations — You own an AnimationController + Tween + Curve, wrapped
//    in AnimatedBuilder / ListenableBuilder. Best for loops, choreography, games.
// 3) TweenAnimationBuilder — One-shot or rebuild-driven tweens without subclassing
//    SingleTickerProviderStateMixin; good teaching step toward explicit controllers.
// 4) CustomPainter + animation — "Self canvas": paint frames yourself; used for
//    charts, orbits, loaders (fintech apps often mix this with Transform for icons).
// 5) flutter_animate (package) — Declarative chains (.fadeIn().scale()) used in
//    many shipped apps for marketing sections and staggered lists.
// 6) animations (Material motion / Google patterns) — OpenContainer, SharedAxis,
//    FadeThrough: patterns you see in Material Design reference apps.
// 7) PageRouteBuilder — Scale/fade transitions when opening routes (common "modal"
//    feel without extra packages).
// =============================================================================

import 'dart:math' as math;

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Wallet-style micro-motion (orbit / pulse) + industry-style patterns in one
/// scrollable reference. Nepali fintech apps (e.g. eSewa-style hubs) often combine
/// small orbital accents with scale emphasis on the primary action.
class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation lab'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _introCard(),
                const SizedBox(height: 20),
                _sectionTitle(
                  '1 · Implicit — AnimatedScale',
                  'Tap the card: Flutter interpolates between old and new scale. '
                  'No AnimationController in your State.',
                ),
                const SizedBox(height: 10),
                const _ImplicitAnimatedScaleDemo(),
                const SizedBox(height: 28),
                _sectionTitle(
                  '2 · One-shot — TweenAnimationBuilder',
                  'Drives a Tween from begin → end when `tweenEnd` changes. '
                  'Great first step before writing your own controller.',
                ),
                const SizedBox(height: 10),
                const _TweenAnimationBuilderDemo(),
                const SizedBox(height: 28),
                _sectionTitle(
                  '3 · Explicit loop — AnimationController',
                  'You control duration, curve, repeat, reverse. Wrapped in '
                  'AnimatedBuilder so only the subtree rebuilds.',
                ),
                const SizedBox(height: 10),
                const _ExplicitPulseDemo(),
                const SizedBox(height: 28),
                _sectionTitle(
                  '4 · Self canvas — CustomPainter + ticker',
                  'Orbit sketch: four "satellite" nodes on a ring (wallet hub metaphor). '
                  'Production apps often overlay real Icon widgets with Transform.rotate.',
                ),
                const SizedBox(height: 10),
                const _OrbitCanvasDemo(),
                const SizedBox(height: 28),
                _sectionTitle(
                  '5 · Package — flutter_animate',
                  'Declarative: delays, curves, stagger. Common in onboarding and '
                  'dashboard marketing blocks.',
                ),
                const SizedBox(height: 10),
                const _FlutterAnimateStaggerDemo(),
                const SizedBox(height: 28),
                _sectionTitle(
                  '6 · Package — OpenContainer (animations)',
                  'Material motion: closed surface morphs into open surface. '
                  'Used for expandable FAB / card → detail transitions.',
                ),
                const SizedBox(height: 10),
                const _OpenContainerDemo(),
                const SizedBox(height: 28),
                _sectionTitle(
                  '7 · Route transition — PageRouteBuilder',
                  'Scale + fade a full-screen page from the center — no extra package.',
                ),
                const SizedBox(height: 10),
                _RouteScaleDemoButton(),
                const SizedBox(height: 28),
                _sectionTitle(
                  '8 · Clip + Align — SizeTransition',
                  'Expand/collapse content with a clip; pairs well with lists and FAQs.',
                ),
                const SizedBox(height: 10),
                const _SizeTransitionDemo(),
                const SizedBox(height: 24),
                Text(
                  'Growth checklist: implicit → TweenAnimationBuilder → '
                  'AnimationController + AnimatedBuilder → CustomPainter → '
                  'packages (flutter_animate, animations) → custom routes.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _introCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Small → big motion vocabulary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text(
              'Scroll through each block. Read the subtitle under each title — '
              'it maps to how teams ship motion in Flutter (from hand-rolled to packages).',
              style: TextStyle(color: Colors.black54, height: 1.35),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            height: 1.35,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

// --- 1 Implicit ----------------------------------------------------------------

class _ImplicitAnimatedScaleDemo extends StatefulWidget {
  const _ImplicitAnimatedScaleDemo();

  @override
  State<_ImplicitAnimatedScaleDemo> createState() =>
      _ImplicitAnimatedScaleDemoState();
}

class _ImplicitAnimatedScaleDemoState extends State<_ImplicitAnimatedScaleDemo> {
  double _scale = 0.85;

  void _toggle() {
    setState(() {
      _scale = _scale < 1 ? 1.12 : 0.85;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        scale: _scale,
        child: Container(
          height: 110,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pinkAccent.shade100,
                Colors.pinkAccent.shade200,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Text(
            'Tap me — AnimatedScale\n(smaller ↔ bigger)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// --- 2 TweenAnimationBuilder ----------------------------------------------------

class _TweenAnimationBuilderDemo extends StatefulWidget {
  const _TweenAnimationBuilderDemo();

  @override
  State<_TweenAnimationBuilderDemo> createState() =>
      _TweenAnimationBuilderDemoState();
}

class _TweenAnimationBuilderDemoState extends State<_TweenAnimationBuilderDemo> {
  double _end = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.75, end: _end),
          duration: const Duration(milliseconds: 700),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              alignment: Alignment.center,
              child: child,
            );
          },
          child: Container(
            height: 96,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.deepPurple.shade100),
            ),
            child: Text(
              'Elastic scale (end = $_end)',
              style: TextStyle(
                color: Colors.deepPurple.shade800,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: () {
            setState(() {
              // Toggle end value retriggers tween from current → new end.
              _end = _end >= 1 ? 0.78 : 1;
            });
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Replay / shrink'),
        ),
      ],
    );
  }
}

// --- 3 Explicit AnimationController ---------------------------------------------

class _ExplicitPulseDemo extends StatefulWidget {
  const _ExplicitPulseDemo();

  @override
  State<_ExplicitPulseDemo> createState() => _ExplicitPulseDemoState();
}

class _ExplicitPulseDemoState extends State<_ExplicitPulseDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  late final Animation<double> _scale = Tween<double>(begin: 0.92, end: 1.06).animate(
    CurvedAnimation(parent: _c, curve: Curves.easeInOut),
  );

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) {
        return Transform.scale(
          scale: _scale.value,
          child: child,
        );
      },
      child: Container(
        height: 104,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.teal.shade600,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'Breathing CTA\n(AnimationController)',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// --- 4 CustomPainter orbit ------------------------------------------------------

class _OrbitCanvasDemo extends StatefulWidget {
  const _OrbitCanvasDemo();

  @override
  State<_OrbitCanvasDemo> createState() => _OrbitCanvasDemoState();
}

class _OrbitCanvasDemoState extends State<_OrbitCanvasDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        return SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _WalletOrbitPainter(rotation: _c.value * 2 * math.pi),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 52),
                child: Text(
                  'Hub + satellites (canvas)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 4, color: Colors.black45)],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Paints a simple wallet-style hub: ring + four orbiting nodes.
class _WalletOrbitPainter extends CustomPainter {
  _WalletOrbitPainter({required this.rotation});

  final double rotation;

  static const _nodeColors = [
    Color(0xFF2E7D32),
    Color(0xFF1565C0),
    Color(0xFFEF6C00),
    Color(0xFF6A1B9A),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 8);
    final radius = size.shortestSide * 0.38;

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.pinkAccent.withValues(alpha: 0.35);
    canvas.drawCircle(center, radius, ringPaint);

    for (var i = 0; i < 4; i++) {
      final angle = rotation + i * math.pi / 2;
      final pos = center + Offset(math.cos(angle), math.sin(angle)) * radius;
      canvas.drawCircle(
        pos,
        11,
        Paint()..color = _nodeColors[i],
      );
    }

    canvas.drawCircle(center, 20, Paint()..color = Colors.pinkAccent);
    canvas.drawCircle(center, 20, Paint()..style = PaintingStyle.stroke..color = Colors.white24);
  }

  @override
  bool shouldRepaint(covariant _WalletOrbitPainter oldDelegate) {
    return oldDelegate.rotation != rotation;
  }
}

// --- 5 flutter_animate ----------------------------------------------------------

class _FlutterAnimateStaggerDemo extends StatelessWidget {
  const _FlutterAnimateStaggerDemo();

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(
      5,
      (i) => 'Row item ${i + 1}',
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Row(
                children: [
                  Icon(Icons.bolt, color: Colors.amber.shade800),
                  const SizedBox(width: 8),
                  Expanded(child: Text(items[i])),
                ],
              )
                  .animate()
                  .fadeIn(duration: 350.ms, delay: (70 * i).ms)
                  .scale(
                    begin: const Offset(0.92, 0.92),
                    curve: Curves.easeOutBack,
                  ),
            ),
        ],
      ),
    );
  }
}

// --- 6 OpenContainer ------------------------------------------------------------

class _OpenContainerDemo extends StatelessWidget {
  const _OpenContainerDemo();

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 450),
      transitionType: ContainerTransitionType.fadeThrough,
      closedElevation: 4,
      closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      closedColor: Colors.indigo.shade600,
      openColor: Colors.white,
      closedBuilder: (context, openContainer) {
        return InkWell(
          onTap: openContainer,
          child: SizedBox(
            height: 88,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.open_in_full, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Tap — grow into detail',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      openBuilder: (context, closeContainer) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Opened surface'),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: closeContainer,
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'OpenContainer morphs the closed widget into this scaffold. '
                'This is the same pattern Google documents under Material motion.',
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: closeContainer,
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}

// --- 7 Route scale --------------------------------------------------------------

class _RouteScaleDemoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: () {
        Navigator.of(context).push(_scaleRoute());
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Text('Push route with scale + fade transition'),
      ),
    );
  }

  PageRouteBuilder<void> _scaleRoute() {
    return PageRouteBuilder<void>(
      opaque: false,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(18),
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360, maxHeight: 420),
              child: SizedBox(
                width: double.infinity,
                height: 320,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      color: Colors.pinkAccent,
                      child: const Text(
                        'Scaled route',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'PageRouteBuilder + FadeTransition + ScaleTransition '
                          'is enough for many modal flows.',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Dismiss'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.88, end: 1).animate(curved),
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
    );
  }
}

// --- 8 SizeTransition -----------------------------------------------------------

class _SizeTransitionDemo extends StatefulWidget {
  const _SizeTransitionDemo();

  @override
  State<_SizeTransitionDemo> createState() => _SizeTransitionDemoState();
}

class _SizeTransitionDemoState extends State<_SizeTransitionDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 380),
  );
  bool _expanded = false;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _c.forward();
      } else {
        _c.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: _toggle,
          icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
          label: Text(_expanded ? 'Collapse' : 'Expand details'),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizeTransition(
            sizeFactor: CurvedAnimation(parent: _c, curve: Curves.easeInOut),
            axisAlignment: -1,
            child: Container(
              width: double.infinity,
              color: Colors.blueGrey.shade50,
              padding: const EdgeInsets.all(14),
              child: const Text(
                'SizeTransition reveals height smoothly. Combine with '
                'AnimatedOpacity if you also want content fade.',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

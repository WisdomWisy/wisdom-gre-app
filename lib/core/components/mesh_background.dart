import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';

class MeshBackground extends ConsumerStatefulWidget {
  final Widget child;

  const MeshBackground({Key? key, required this.child}) : super(key: key);

  @override
  ConsumerState<MeshBackground> createState() => _MeshBackgroundState();
}

class _MeshBackgroundState extends ConsumerState<MeshBackground> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignment;
  late Animation<Alignment> _bottomAlignment;

  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _topAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft), weight: 1),
    ]).animate(_controller);

    _bottomAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight), weight: 1),
    ]).animate(_controller);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!_isActive) {
        setState(() => _isActive = true);
        _controller.repeat(reverse: true);
      }
    } else {
      if (_isActive) {
        setState(() => _isActive = false);
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(themeControllerProvider);
    final colors = themeData.gradientColors;

    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colors,
                    begin: _topAlignment.value,
                    end: _bottomAlignment.value,
                    stops: const [0.0, 0.3, 0.7, 1.0],
                  ),
                ),
              );
            },
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            child: widget.child,
          ),
        ),
      ],
    );
  }
}

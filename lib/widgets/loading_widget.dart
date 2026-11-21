import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;
  final double size;

  const LoadingWidget({
    super.key,
    this.color = AppColors.primary,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}

class ThreeDotLoading extends StatefulWidget {
  final Color color;
  final double dotSize;

  const ThreeDotLoading({
    super.key,
    this.color = Colors.white,
    this.dotSize = 6.0,
  });

  @override
  State<ThreeDotLoading> createState() => _ThreeDotLoadingState();
}

class _ThreeDotLoadingState extends State<ThreeDotLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final delay = index * 0.2;
            final progress = (_controller.value - delay) % 1.0;
            final scale = (progress < 0.5)
                ? 1.0 + (progress * 0.8)
                : 1.4 - ((progress - 0.5) * 0.8);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: widget.dotSize * scale,
              height: widget.dotSize * scale,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(
                  0.4 + (0.6 * (scale - 1.0) / 0.4).clamp(0.0, 1.0),
                ),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}

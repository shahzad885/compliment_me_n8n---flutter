import 'package:flutter/material.dart';
import 'glass_container.dart';

class ComplimentCard extends StatefulWidget {
  final String compliment;
  final int index;

  const ComplimentCard({
    super.key,
    required this.compliment,
    required this.index,
  });

  @override
  State<ComplimentCard> createState() => _ComplimentCardState();
}

class _ComplimentCardState extends State<ComplimentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Stagger animation based on index
    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GlassContainer(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // Crypto Green Gradient
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF00D084), // Neon Green
                      Color(0xFF008F58), // Darker Green
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.compliment,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

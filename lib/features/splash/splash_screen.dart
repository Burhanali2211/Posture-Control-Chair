import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/posture_chair_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) context.go('/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _controller,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PostureChairLogo(size: 88),
              const SizedBox(height: 24),
              const Text(
                AppStrings.appName,
                style: TextStyle(
                  fontSize:   26,
                  fontWeight: FontWeight.w700,
                  color:      AppColors.text,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'by PiJam Foundation',
                style: TextStyle(
                  fontSize: 13,
                  color:    AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

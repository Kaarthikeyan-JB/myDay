import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:res/utils/app_colors.dart';
import 'package:res/views/home/home_view.dart';

class SsplashScreen extends StatefulWidget {
  const SsplashScreen({super.key});

  @override
  State<SsplashScreen> createState() => _SsplashScreenState();
}

class _SsplashScreenState extends State<SsplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and animation
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<Offset>(
      begin: Offset.zero, // Start at the original position
      end: Offset(0, -1), // Slide up out of view
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start the slide-up animation after a delay
    Timer(Duration(seconds: 3), () {
      _animationController.forward();
    });

    // Navigate to the home screen after the animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.dispose(); // Dispose the controller when done
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // HomeView is placed in the background
          HomeView(),

          // Splash screen slides up
          SlideTransition(
            position: _animation,
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryColor,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Text(
                  "myDay",
                  style: GoogleFonts.pacifico(fontSize: 34),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

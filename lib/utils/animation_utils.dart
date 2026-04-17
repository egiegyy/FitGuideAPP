import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AnimationUtils {
  // Fade in animation
  static Widget fadeIn({
    required Widget child,
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return FadeIn(delay: delay, duration: duration, child: child);
  }

  // Slide in from left
  static Widget slideInLeft({
    required Widget child,
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return SlideInLeft(delay: delay, duration: duration, child: child);
  }

  // Slide in from right
  static Widget slideInRight({
    required Widget child,
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return SlideInRight(delay: delay, duration: duration, child: child);
  }

  // Slide in from top
  static Widget slideInDown({
    required Widget child,
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return SlideInDown(delay: delay, duration: duration, child: child);
  }

  // Bounce in animation
  static Widget bounceIn({
    required Widget child,
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    return BounceIn(delay: delay, duration: duration, child: child);
  }

  // Scale animation
  static Widget zoomIn({
    required Widget child,
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return ZoomIn(delay: delay, duration: duration, child: child);
  }

  // Pulse animation
  static Widget pulse({
    required Widget child,
    Duration delay = Duration.zero,
    bool infinite = true,
  }) {
    return Pulse(delay: delay, infinite: infinite, child: child);
  }

  // Elastic animation
  static Widget elasticIn({
    required Widget child,
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    return ElasticIn(delay: delay, duration: duration, child: child);
  }

  // Staggered animation for lists
  static List<Widget> staggeredAnimation({
    required List<Widget> children,
    Duration baseDelay = const Duration(milliseconds: 100),
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return children.asMap().entries.map((entry) {
      final index = entry.key;
      final child = entry.value;
      return fadeIn(child: child, delay: baseDelay * index, duration: duration);
    }).toList();
  }

  // Loading animation
  static Widget loadingAnimation() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  // Success animation
  static Widget successAnimation({
    required String message,
    VoidCallback? onComplete,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          bounceIn(
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
          ),
          const SizedBox(height: 20),
          fadeIn(
            delay: const Duration(milliseconds: 300),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Error animation
  static Widget errorAnimation({
    required String message,
    VoidCallback? onComplete,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          bounceIn(child: const Icon(Icons.error, color: Colors.red, size: 80)),
          const SizedBox(height: 20),
          fadeIn(
            delay: const Duration(milliseconds: 300),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

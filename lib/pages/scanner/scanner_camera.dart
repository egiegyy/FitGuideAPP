import 'dart:async';
import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/pages/workout/exercise/chest_press.dart';
import 'package:fitguide/pages/workout/exercise/leg_press.dart';
import 'package:fitguide/pages/workout/exercise/lat_pulldown.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerCameraPage extends StatefulWidget {
  const ScannerCameraPage({super.key});

  @override
  State<ScannerCameraPage> createState() => _ScannerCameraPageState();
}

class _ScannerCameraPageState extends State<ScannerCameraPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final MobileScannerController _controller;

  bool isScanning = false;
  static const double scanSize = 280;

  final Map<String, WidgetBuilder> machineRoutes = {
    "lat_pulldown": (context) => const WideGripLatPulldownPage(),
    "leg_press": (context) => const LegPressPage(),
    "chest_press": (context) => const ChestPressPage(),
  };

  @override
  void initState() {
    super.initState();

    _controller = MobileScannerController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: scanSize).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.repeat(reverse: true);
    _controller.start();
  }

  @override
  void dispose() {
    unawaited(_controller.stop());
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> handleBarcode(String code) async {
    if (isScanning) return;
    isScanning = true;

    final equipment = await DBHelper.getEquipmentByBarcode(code);
    if (!mounted) return;

    if (equipment != null) {
      await _controller.stop();

      final pageId = equipment['page'];

      if (machineRoutes.containsKey(pageId)) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: machineRoutes[pageId]!),
        );

        if (!mounted) return;

        await Future.delayed(const Duration(milliseconds: 500));
        isScanning = false;
        await _controller.start();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Halaman alat belum tersedia")),
        );
        isScanning = false;
        await _controller.start();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Alat tidak ditemukan di FitGuide")),
      );
      await Future.delayed(const Duration(milliseconds: 1200));
      isScanning = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Scanner",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF000000),
              Color(0xFF0A0F0A),
              Color(0xFF101810),
              Color(0xFF000000),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            MobileScanner(
              controller: _controller,
              onDetect: (BarcodeCapture capture) {
                if (isScanning) return;

                for (final barcode in capture.barcodes) {
                  final code = barcode.rawValue;
                  if (code != null) {
                    handleBarcode(code);
                    break;
                  }
                }
              },
            ),

            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _ScannerOverlayPainter(
                    scanSize: scanSize,
                    borderRadius: 20,
                  ),
                ),
              ),
            ),

            Center(
              child: SizedBox(
                width: scanSize,
                height: scanSize,
                child: Stack(
                  children: [
                    ..._buildCorners(),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (_, __) {
                        return Positioned(
                          top: _animation.value,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.green,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Scan the barcode",
                  style: TextStyle(color: Colors.green, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCorners() {
    const double cornerSize = 35;
    const double thickness = 4;

    return [
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.green, width: thickness),
              left: BorderSide(color: Colors.green, width: thickness),
            ),
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.green, width: thickness),
              right: BorderSide(color: Colors.green, width: thickness),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.green, width: thickness),
              left: BorderSide(color: Colors.green, width: thickness),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.green, width: thickness),
              right: BorderSide(color: Colors.green, width: thickness),
            ),
          ),
        ),
      ),
    ];
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  final double scanSize;
  final double borderRadius;

  const _ScannerOverlayPainter({
    required this.scanSize,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final overlayPaint = Paint()..color = Colors.black.withValues(alpha: 0.68);

    final fullScreen = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final scanRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanSize,
      height: scanSize,
    );

    final cutout = Path()
      ..addRRect(
        RRect.fromRectAndRadius(scanRect, Radius.circular(borderRadius)),
      );

    canvas.drawPath(
      Path.combine(PathOperation.difference, fullScreen, cutout),
      overlayPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScannerOverlayPainter oldDelegate) {
    return oldDelegate.scanSize != scanSize ||
        oldDelegate.borderRadius != borderRadius;
  }
}
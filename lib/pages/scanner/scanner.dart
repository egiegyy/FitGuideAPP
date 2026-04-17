import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/pages/workout/exercise/chest_press.dart';
import 'package:fitguide/pages/workout/exercise/leg_press.dart';
import 'package:fitguide/pages/workout/exercise/lat_pulldown.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  final MobileScannerController controller = MobileScannerController();
  bool isScanning = false;
  bool scannerStarted = false;
  static const double scanSize = 280;
  final Map<String, WidgetBuilder> machineRoutes = {
    "lat_pulldown": (context) => const WideGripLatPulldownPage(),
    "leg_press": (context) => const LegPressPage(),
    "chest_press": (context) => const ChestPressPage(),
  };
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: scanSize).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> handleBarcode(String code) async {
    if (isScanning) return;
    isScanning = true;
    final equipment = await DBHelper.getEquipmentByBarcode(code);
    if (!mounted) return;
    if (equipment != null) {
      await controller.stop();
      if (!mounted) return;
      final pageId = equipment['page'];
      if (machineRoutes.containsKey(pageId)) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: machineRoutes[pageId]!),
        );
        if (!mounted) return;
        await Future.delayed(const Duration(milliseconds: 500));
        isScanning = false;
        controller.start();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Halaman alat belum tersedia")),
        );
        isScanning = false;
        controller.start();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Alat tidak ditemukan di FitGuide")),
      );
      await Future.delayed(const Duration(milliseconds: 1200));
      isScanning = false;
    }
  }

  void startScanner() {
    setState(() {
      scannerStarted = true;
    });
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
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
            /// CAMERA
            if (scannerStarted)
              MobileScanner(
                controller: controller,
                onDetect: (BarcodeCapture capture) {
                  if (isScanning) return;

                  for (final barcode in capture.barcodes) {
                    final String? code = barcode.rawValue;

                    if (code != null) {
                      handleBarcode(code);
                      break;
                    }
                  }
                },
              ),

            /// INTRO SCREEN
            if (!scannerStarted)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.all(30),

                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white24),
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.qr_code_scanner,
                        size: 70,
                        color: Colors.green,
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Scan Gym Equipment",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Scan the barcode on the gym machine to see workout guidance.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 25),
                      InkWell(
                        onTap: startScanner,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "Start Scan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            /// OVERLAY
            if (scannerStarted)
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.75),
                  BlendMode.srcOut,
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        backgroundBlendMode: BlendMode.dstOut,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: scanSize,
                        height: scanSize,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            /// SCAN FRAME
            if (scannerStarted)
              Center(
                child: SizedBox(
                  width: scanSize,
                  height: scanSize,
                  child: Stack(
                    children: [
                      ..._buildCorners(),

                      AnimatedBuilder(
                        animation: _animation,
                        builder: (_, child) {
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
                      const Center(
                        child: Icon(
                          Icons.qr_code,
                          color: Colors.green,
                          size: 45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            /// TEXT
            if (scannerStarted)
              const Positioned(
                bottom: 120,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Align barcode inside the frame",
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

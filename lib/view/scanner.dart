import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/view/exercise/chestPress.dart';
import 'package:fitguide/view/exercise/legPress.dart';
import 'package:fitguide/view/exercise/wideGripLP.dart';
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

  /// ROUTER MAP MACHINE PAGE
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

  /// HANDLE BARCODE
  Future<void> handleBarcode(String code) async {
    if (isScanning) return;

    isScanning = true;

    final equipment = await DBHelper.getEquipmentByBarcode(code);

    if (!mounted) return;

    if (equipment != null) {
      /// STOP CAMERA
      await controller.stop();

      final pageId = equipment['page'];

      if (machineRoutes.containsKey(pageId)) {
        /// NAVIGATE TO MACHINE PAGE
        await Navigator.push(
          context,
          MaterialPageRoute(builder: machineRoutes[pageId]!),
        );

        /// AFTER RETURN FROM PAGE
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Scanner",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          /// CAMERA VIEW
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
              child: ElevatedButton(
                onPressed: startScanner,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  "Start Scan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

          /// DARK OVERLAY
          if (scannerStarted)
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7),
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

          /// SCANNER FRAME
          if (scannerStarted)
            Center(
              child: SizedBox(
                width: scanSize,
                height: scanSize,
                child: Stack(
                  children: [
                    ..._buildCorners(),

                    /// SCAN LINE
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (_, __) {
                        return Positioned(
                          top: _animation.value,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 2,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.blue,
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
                        Icons.camera_alt_rounded,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          /// TEXT
          if (scannerStarted)
            const Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Scan Barcode",
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
            ),
        ],
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
              top: BorderSide(color: Colors.blue, width: thickness),
              left: BorderSide(color: Colors.blue, width: thickness),
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
              top: BorderSide(color: Colors.blue, width: thickness),
              right: BorderSide(color: Colors.blue, width: thickness),
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
              bottom: BorderSide(color: Colors.blue, width: thickness),
              left: BorderSide(color: Colors.blue, width: thickness),
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
              bottom: BorderSide(color: Colors.blue, width: thickness),
              right: BorderSide(color: Colors.blue, width: thickness),
            ),
          ),
        ),
      ),
    ];
  }
}

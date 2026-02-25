import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final _controller = MobileScannerController();

  bool _isProcessing = false;
  final ImagePicker _imagePicker = ImagePicker();

  static final RegExp _eightDigits = RegExp(r'\d{8}');

  String? _extractAccountNumber(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final match = _eightDigits.firstMatch(raw);
    return match?.group(0);
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    if (_isProcessing) return;
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    for (final barcode in barcodes) {
      final account = _extractAccountNumber(barcode.rawValue);
      if (account != null) {
        _isProcessing = true;
        context.router.maybePop(account);
        return;
      }
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (file == null || !mounted) return;

    final String path = file.path;
    if (path.isEmpty || !mounted) return;

    try {
      final BarcodeCapture? result = await _controller.analyzeImage(path);
      if (!mounted) return;
      if (result != null) {
        _onBarcodeDetected(result);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr(LocaleKeys.scannerNoCodeFound))));
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.router.maybePop(),
        ),
        title: Text(
          context.tr(LocaleKeys.scannerTitle),
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on, color: Colors.white),
            onPressed: () => _controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch, color: Colors.white),
            onPressed: () => _controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(controller: _controller, onDetect: _onBarcodeDetected),
          // Instruction overlay
          Positioned(
            top: 24,
            left: 24,
            right: 24,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  context.tr(LocaleKeys.scannerInstruction),
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // Scanner frame — центрированная по умолчанию или наводится на QR
          _ScanFrameOverlay(controller: _controller),
          // Bottom section
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 34),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.85)],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Account search info card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.textPrimary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.qr_code_scanner, color: AppColors.textPrimary, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr(LocaleKeys.scannerAccountSearch),
                                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                context.tr(LocaleKeys.scannerAccountSearchDesc),
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Select from gallery button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _pickFromGallery,
                      icon: const Icon(Icons.photo_library_outlined, color: Colors.white, size: 22),
                      label: Text(
                        context.tr(LocaleKeys.scannerSelectFromGallery),
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.textPrimary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Оверлей рамки: по умолчанию в центре, при обнаружении QR — наводится на него.
class _ScanFrameOverlay extends StatefulWidget {
  const _ScanFrameOverlay({required this.controller});

  final MobileScannerController controller;

  @override
  State<_ScanFrameOverlay> createState() => _ScanFrameOverlayState();
}

class _ScanFrameOverlayState extends State<_ScanFrameOverlay> {
  int _orientationKey = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(covariant _ScanFrameOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onControllerChanged);
      widget.controller.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    final orientation = widget.controller.value.deviceOrientation;
    if (orientation != _lastOrientation) {
      _lastOrientation = orientation;
      setState(() => _orientationKey++);
    }
  }

  DeviceOrientation? _lastOrientation;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MobileScannerState>(
      valueListenable: widget.controller,
      builder: (context, state, _) {
        if (!state.isInitialized || !state.isRunning || state.error != null) {
          return const SizedBox();
        }
        return StreamBuilder<BarcodeCapture>(
          key: ValueKey(_orientationKey),
          stream: widget.controller.barcodes,
          builder: (context, snapshot) {
            final capture = snapshot.data;
            Barcode? targetBarcode;
            if (capture != null &&
                capture.size.width > 0 &&
                capture.size.height > 0 &&
                capture.barcodes.isNotEmpty) {
              for (final b in capture.barcodes) {
                if (b.corners.length >= 4 && !b.size.isEmpty) {
                  targetBarcode = b;
                  break;
                }
              }
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                final size = constraints.biggest;
                if (targetBarcode != null) {
                  return CustomPaint(
                    size: size,
                    painter: _BarcodeFramePainter(
                      barcode: targetBarcode,
                      captureSize: capture!.size,
                      deviceOrientation: state.deviceOrientation,
                      color: AppColors.textPrimary,
                    ),
                  );
                }
                return Center(
                  child: _ScannerFrame(
                    width: 260,
                    height: 260,
                    color: AppColors.textPrimary,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

/// Рисует L-рамку вокруг обнаруженного штрихкода.
class _BarcodeFramePainter extends CustomPainter {
  _BarcodeFramePainter({
    required this.barcode,
    required this.captureSize,
    required this.deviceOrientation,
    required this.color,
  });

  final Barcode barcode;
  final Size captureSize;
  final DeviceOrientation? deviceOrientation;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (barcode.corners.length < 4 || captureSize.isEmpty) return;

    final isLandscape = deviceOrientation == DeviceOrientation.landscapeLeft ||
        deviceOrientation == DeviceOrientation.landscapeRight;
    final camSize = isLandscape ? Size(captureSize.height, captureSize.width) : captureSize;

    final ratio = math.max(
      size.width / camSize.width,
      size.height / camSize.height,
    );
    final padX = (camSize.width * ratio - size.width) / 2;
    final padY = (camSize.height * ratio - size.height) / 2;

    final pts = <Offset>[
      for (final o in barcode.corners)
        Offset(o.dx * ratio - padX, o.dy * ratio - padY),
    ];
    if (pts.length < 4) return;

    const cornerLen = 28.0;
    const strokeWidth = 4.0;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 4; i++) {
      final p = pts[i];
      final next = pts[(i + 1) % 4];
      final prev = pts[(i + 3) % 4];
      final dir1 = (next - p).normalize();
      final dir2 = (prev - p).normalize();
      final len = (cornerLen * 0.8).clamp(16.0, 36.0);
      canvas.drawLine(p, p + dir1 * len, paint);
      canvas.drawLine(p, p + dir2 * len, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BarcodeFramePainter old) =>
      !identical(old.barcode, barcode) || old.captureSize != captureSize;
}

extension on Offset {
  Offset normalize() {
    final l = math.sqrt(dx * dx + dy * dy);
    return l > 0 ? Offset(dx / l, dy / l) : this;
  }
}

class _ScannerFrame extends StatelessWidget {
  const _ScannerFrame({required this.width, required this.height, required this.color});

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const cornerLength = 32.0;
    const strokeWidth = 4.0;

    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _ScannerFramePainter(color: color, cornerLength: cornerLength, strokeWidth: strokeWidth),
      ),
    );
  }
}

class _ScannerFramePainter extends CustomPainter {
  _ScannerFramePainter({required this.color, required this.cornerLength, required this.strokeWidth});

  final Color color;
  final double cornerLength;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, cornerLength), Offset.zero, paint);
    canvas.drawLine(Offset.zero, Offset(cornerLength, 0), paint);

    canvas.drawLine(Offset(size.width - cornerLength, 0), Offset(size.width, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, cornerLength), paint);

    canvas.drawLine(Offset(size.width, size.height - cornerLength), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - cornerLength, size.height), paint);

    canvas.drawLine(Offset(cornerLength, size.height), Offset(0, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - cornerLength), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

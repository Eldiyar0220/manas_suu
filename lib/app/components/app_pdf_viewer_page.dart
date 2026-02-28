import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

@RoutePage()
class AppPdfviewerPage extends StatefulWidget {
  /// Путь к PDF после dio.download (приоритет).
  final String? filePath;

  /// Base64 PDF (если открываем без скачивания).
  final String? base64Pdf;

  const AppPdfviewerPage({super.key, this.filePath, this.base64Pdf});

  @override
  State<AppPdfviewerPage> createState() => _AppPdfviewerPageState();
}

class _AppPdfviewerPageState extends State<AppPdfviewerPage> {
  late Uint8List _pdfBytes;
  final PdfViewerController _pdfController = PdfViewerController();
  int _currentPage = 1;
  int _totalPages = 1;

  @override
  void initState() {
    super.initState();
    if (widget.filePath != null && widget.filePath!.isNotEmpty) {
      _pdfBytes = File(widget.filePath!).readAsBytesSync();
    } else if (widget.base64Pdf != null && widget.base64Pdf!.isNotEmpty) {
      _pdfBytes = base64Decode(widget.base64Pdf!);
    } else {
      _pdfBytes = Uint8List(0);
    }
  }

  Future<void> _sharePdf() async {
    if (_pdfBytes.isEmpty) return;
    final File file;
    if (widget.filePath != null && widget.filePath!.isNotEmpty) {
      file = File(widget.filePath!);
    } else {
      file = File('${(await getTemporaryDirectory()).path}/receipt.pdf');
      await file.writeAsBytes(_pdfBytes);
    }
    await Share.shareXFiles([XFile(file.path)], text: 'Квитанция');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText('Квитанция'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _sharePdf),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.green.shade900,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.picture_as_pdf, color: Colors.green),
                  const SizedBox(width: 8),
                  CustomText(
                    'Страница $_currentPage из $_totalPages',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SfPdfViewer.memory(
                _pdfBytes,
                controller: _pdfController,
                onDocumentLoaded: (details) {
                  setState(() {
                    _totalPages = details.document.pages.count;
                    _currentPage = _pdfController.pageNumber;
                  });
                },
                onPageChanged: (details) {
                  setState(() {
                    _currentPage = details.newPageNumber;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_chart_response_model.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

class MainChartWidget extends StatefulWidget {
  const MainChartWidget({
    super.key,
    required this.accountChartData,
    this.initialMonths = 3,
    this.onPeriodChanged,
  });

  final AccountChartData accountChartData;
  final int initialMonths;
  final void Function(int months)? onPeriodChanged;

  @override
  State<MainChartWidget> createState() => _MainChartWidgetState();
}

class _MainChartWidgetState extends State<MainChartWidget> {
  int _selectedPeriod = 0;

  static const _periods = ['3 мес', '6 мес', '12 мес'];

  static const _chartData = [
    [114.0, 114.0, 114.0],

    [80.0, 95.0, 114.0, 100.0, 110.0, 114.0],

    [
      60.0,
      70.0,
      80.0,
      95.0,
      100.0,
      110.0,
      114.0,
      108.0,
      112.0,
      114.0,
      114.0,
      114.0,
    ],
  ];

  static const _chartLabels = [
    ['Дек', 'Янв', 'Фев'],
    ['Сен', 'Окт', 'Ноя', 'Дек', 'Янв', 'Фев'],
    [
      'Мар',
      'Апр',
      'Май',
      'Июн',
      'Июл',
      'Авг',
      'Сен',
      'Окт',
      'Ноя',
      'Дек',
      'Янв',
      'Фев',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    final cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white54 : Colors.black45;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black38
                : Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.mainColor.withValues(alpha: 0.12),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: AppColors.mainColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'Начисления и оплаты',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: textColor,
                      ),
                    ),
                    CustomText(
                      'За последние ${_periods[_selectedPeriod]}',
                      style: TextStyle(fontSize: 12, color: subTextColor),
                    ),
                  ],
                ),
              ),
              Icon(Icons.fullscreen_outlined, color: subTextColor),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(_periods.length, (i) {
              final selected = i == _selectedPeriod;
              return Padding(
                padding: EdgeInsets.only(
                  right: i < _periods.length - 1 ? 8 : 0,
                ),
                child: InkWell(
                  onTap: () => setState(() => _selectedPeriod = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selected
                          ? AppColors.mainColor
                          : (isDark ? Colors.white10 : Colors.grey.shade100),
                    ),
                    child: CustomText(
                      _periods[i],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: selected
                            ? Colors.white
                            : (isDark ? Colors.white60 : Colors.black54),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 140,
            child: _SimpleLineChart(
              data: _chartData[_selectedPeriod],
              labels: _chartLabels[_selectedPeriod],
              isDark: isDark,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(color: Colors.blueAccent, label: 'Начислено'),
              const SizedBox(width: 20),
              _LegendItem(color: AppColors.mainColor, label: 'Оплачено'),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        CustomText(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _SimpleLineChart extends StatelessWidget {
  const _SimpleLineChart({
    required this.data,
    required this.labels,
    required this.isDark,
  });

  final List<double> data;
  final List<String> labels;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LineChartPainter(data: data, labels: labels, isDark: isDark),
      child: const SizedBox.expand(),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({
    required this.data,
    required this.labels,
    required this.isDark,
  });

  final List<double> data;
  final List<String> labels;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final double maxVal = data.reduce((a, b) => a > b ? a : b);
    final double minVal = 0;
    final double chartHeight = size.height - 24;
    final double chartWidth = size.width;
    final int n = data.length;

    final gridPaint = Paint()
      ..color = (isDark ? Colors.white10 : Colors.grey.shade200)
      ..strokeWidth = 1;

    for (int i = 0; i <= 2; i++) {
      final y = chartHeight - chartHeight * (i / 2) * 0.9;
      canvas.drawLine(Offset(0, y), Offset(chartWidth, y), gridPaint);

      final label = ((maxVal * (i / 2)) * 0.9 + minVal).round().toString();
      final tp = _makeTextPainter(
        label,
        isDark ? Colors.white38 : Colors.black26,
        10,
      );
      tp.paint(canvas, Offset(0, y - 14));
    }

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppColors.mainColor.withValues(alpha: isDark ? 0.25 : 0.15),
          AppColors.mainColor.withValues(alpha: 0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, chartWidth, chartHeight))
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = AppColors.mainColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final dotPaint = Paint()
      ..color = AppColors.mainColor
      ..style = PaintingStyle.fill;

    final dotBorderPaint = Paint()
      ..color = isDark ? const Color(0xFF1C1C1E) : Colors.white
      ..style = PaintingStyle.fill;

    List<Offset> points = [];
    for (int i = 0; i < n; i++) {
      final x = n == 1 ? chartWidth / 2 : (i / (n - 1)) * chartWidth;
      final normalized = maxVal == minVal
          ? 0.5
          : (data[i] - minVal) / (maxVal - minVal);
      final y =
          chartHeight - normalized * chartHeight * 0.85 - chartHeight * 0.05;
      points.add(Offset(x, y));
    }

    final areaPath = Path();
    areaPath.moveTo(points.first.dx, chartHeight);
    for (final p in points) {
      areaPath.lineTo(p.dx, p.dy);
    }
    areaPath.lineTo(points.last.dx, chartHeight);
    areaPath.close();
    canvas.drawPath(areaPath, fillPaint);

    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(linePath, linePaint);

    for (int i = 0; i < n; i++) {
      if (n <= 4 || i == 0 || i == n - 1 || i == n ~/ 2) {
        canvas.drawCircle(points[i], 7, dotBorderPaint);
        canvas.drawCircle(points[i], 5, dotPaint);
      }

      if (n <= 6 || i == 0 || i == n - 1 || i % (n ~/ 3) == 0) {
        final ltp = _makeTextPainter(
          labels[i],
          isDark ? Colors.white54 : Colors.black45,
          11,
        );
        ltp.paint(
          canvas,
          Offset(points[i].dx - ltp.width / 2, chartHeight + 6),
        );
      }
    }
  }

  TextPainter _makeTextPainter(String text, Color color, double fontSize) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    return tp;
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter old) =>
      old.data != data || old.isDark != isDark;
}

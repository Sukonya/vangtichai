import 'package:flutter/material.dart';
import 'constants.dart';
import 'change_calculator.dart';

void main() {
  runApp(const VangtiChaiApp());
}

class VangtiChaiApp extends StatelessWidget {
  const VangtiChaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VangtiChai',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _amount = 0;

  void _onDigit(int digit) {
    setState(() {
      _amount = _amount * 10 + digit;
    });
  }

  void _onClear() {
    setState(() {
      _amount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isTablet = constraints.maxWidth > 600;

        return OrientationBuilder(
          builder: (context, orientation) {
            final bool isLandscape = orientation == Orientation.landscape;

            return Scaffold(
              appBar: AppBar(
                title: const Text('VangtiChai'),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              body: Padding(
                padding: const EdgeInsets.all(kScreenPadding),
                child: Column(
                  children: [
                    _AmountDisplay(
                      amount: _amount,
                      isTablet: isTablet,
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: isLandscape
                          ? _LandscapeBody(
                        amount: _amount,
                        isTablet: isTablet,
                        onDigit: _onDigit,
                        onClear: _onClear,
                      )
                          : _PortraitBody(
                        amount: _amount,
                        isTablet: isTablet,
                        onDigit: _onDigit,
                        onClear: _onClear,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// AMOUNT DISPLAY

class _AmountDisplay extends StatelessWidget {
  final int amount;
  final bool isTablet;

  const _AmountDisplay({required this.amount, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final double labelSize = isTablet ? kTabletLabelFontSize : kLabelFontSize;
    final double amountSize = isTablet ? kTabletAmountFontSize : kAmountFontSize;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Taka: ',
          style: TextStyle(fontSize: labelSize, fontWeight: FontWeight.w500),
        ),
        Text(
          '$_amount',
          style: TextStyle(
            fontSize: amountSize,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  int get _amount => amount;
}

// PORTRAIT LAYOUT

class _PortraitBody extends StatelessWidget {
  final int amount;
  final bool isTablet;
  final Function(int) onDigit;
  final VoidCallback onClear;

  const _PortraitBody({
    required this.amount,
    required this.isTablet,
    required this.onDigit,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ChangeTable(amount: amount, isTablet: isTablet),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _Keypad(
            onDigit: onDigit,
            onClear: onClear,
            isTablet: isTablet,
          ),
        ),
      ],
    );
  }
}

// LANDSCAPE LAYOUT

class _LandscapeBody extends StatelessWidget {
  final int amount;
  final bool isTablet;
  final Function(int) onDigit;
  final VoidCallback onClear;

  const _LandscapeBody({
    required this.amount,
    required this.isTablet,
    required this.onDigit,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _ChangeTable(amount: amount, isTablet: isTablet),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: _Keypad(
            onDigit: onDigit,
            onClear: onClear,
            isTablet: isTablet,
          ),
        ),
      ],
    );
  }
}

// CHANGE TABLE

class _ChangeTable extends StatelessWidget {
  final int amount;
  final bool isTablet;

  const _ChangeTable({required this.amount, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final Map<int, int> change = calculateChange(amount);
    final double fontSize = isTablet ? kTabletTableFontSize : kTableFontSize;
    final double rowHeight = isTablet ? kTabletTableRowHeight : kTableRowHeight;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: kNotes.length,
        itemBuilder: (context, index) {
          final int note = kNotes[index];
          final int count = change[note] ?? 0;

          return Container(
            height: rowHeight,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: index.isEven ? Colors.grey.shade50 : Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$note:',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '$count',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: count > 0
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// KEYPAD

class _Keypad extends StatelessWidget {
  final Function(int) onDigit;
  final VoidCallback onClear;
  final bool isTablet;

  const _Keypad({
    required this.onDigit,
    required this.onClear,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final double fontSize = isTablet ? kTabletButtonFontSize : kButtonFontSize;

    final List<List<String>> rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['0', 'CLEAR'],
    ];

    return Column(
      children: rows.map((row) {
        return Expanded(
          child: Row(
            children: row.map((label) {
              final bool isClear = label == 'CLEAR';
              return Expanded(
                flex: isClear ? 2 : 1,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: _KeypadButton(
                    label: label,
                    fontSize: fontSize,
                    onTap: isClear
                        ? onClear
                        : () => onDigit(int.parse(label)),
                    isClear: isClear,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final String label;
  final double fontSize;
  final VoidCallback onTap;
  final bool isClear;

  const _KeypadButton({
    required this.label,
    required this.fontSize,
    required this.onTap,
    this.isClear = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(kButtonPadding),
          backgroundColor: isClear
              ? Theme.of(context).colorScheme.errorContainer
              : Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: isClear
              ? Theme.of(context).colorScheme.onErrorContainer
              : Theme.of(context).colorScheme.onPrimaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
import 'constants.dart';

// Given an amount, returns how many of each note you need.
// Example: 688 → {500:1, 100:1, 50:1, 20:1, 10:1, 5:1, 2:1, 1:1}
Map<int, int> calculateChange(int amount) {
  int remaining = amount;
  Map<int, int> result = {};

  for (int note in kNotes) {
    result[note] = remaining ~/ note; // ~/ means integer division in Dart
    remaining %= note;               // % means remainder
  }

  return result;
}
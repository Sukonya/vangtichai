import 'constants.dart';

Map<int, int> calculateChange(int amount) {
  int remaining = amount;
  Map<int, int> result = {};

  for (int note in kNotes) {
    result[note] = remaining ~/ note;
    remaining %= note;
  }

  return result;
}
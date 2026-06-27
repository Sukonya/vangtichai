VangtiChai - Change Calculator App
====================================
Student: Sukonya Meghoboti
ID: 22201576
Course: CSE 489
Assignment: 1

Description:
A Flutter app that calculates Bangladeshi Taka change.
Enter an amount using the custom numeric keypad
The app displays how many of each note (500, 100, 50, 20, 10, 5, 2, 1) make up that amount.
The app maintains a hierarchy according to the notes. e.g: first we check how many 500tk notes are used for that amount, then how many 100tk note and so on.

Devices Tested:
- Pixel 8 (API 35) - Portrait and Landscape
- Pixel Tablet (API 35) - Portrait and Landscape

Implementation Notes:
- Built with Flutter/Dart
- OrientationBuilder handles portrait/landscape switching
- LayoutBuilder detects tablet vs phone (threshold: 600dp)
- State persists through rotation via StatefulWidget
- No hardcoded values — all sizes defined in lib/constants.dart
- Change calculation uses greedy algorithm in lib/change_calculator.dart


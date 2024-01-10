import 'dart:math';

import 'package:flutter/material.dart';

class RandomColor {
  Random random = Random();
  List<Color> colors() {
    return List.generate(
        50,
        (index) => Color.fromARGB(255, random.nextInt(254), random.nextInt(254),
            random.nextInt(254)));
  }
}

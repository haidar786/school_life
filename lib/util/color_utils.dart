import 'package:flutter/material.dart';

const double _offset = 0.2;
const double _maxLightness = 0.9;
const double _minLightness = 0.15;

extension ColorUtils on Color {
  Color getLighterAccent() {
    HSLColor hsl = HSLColor.fromColor(this);
    if (hsl.saturation + _offset > 1) {
      hsl = hsl.withSaturation(1);
    } else {
      hsl = hsl.withSaturation(hsl.saturation + _offset);
    }
    if (hsl.lightness + _offset > _maxLightness) {
      hsl = hsl.withLightness(_maxLightness);
    } else {
      hsl = hsl.withLightness(hsl.lightness + _offset);
    }
    return hsl.toColor();
  }

  Color getDarkerAccent() {
    HSLColor hsl = HSLColor.fromColor(this);
    if (hsl.lightness - _offset < _minLightness) {
      hsl = hsl.withLightness(_minLightness);
    } else {
      hsl = hsl.withLightness(hsl.lightness - _offset);
    }
    return hsl.toColor();
  }
}

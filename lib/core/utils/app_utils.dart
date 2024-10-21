import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:math';

/**
 * Created by Abdullah on 18/10/24.
 */


class AppUtils {

  static Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color.withOpacity(0.2) ?? Colors.grey[200]!;
  }

  static String getSecuredCallEmojis() {
    int length = 4;
    final List<String> emojis = [
      '🔒', '🔑', '🛡️', '💬', '📞', '✨', '🦄', '🌟', '🔮', '👾',
      // Add more emojis as needed
    ];

    final random = Random();
    final selectedEmojis = <String>{}; // Use a Set to avoid duplicates

    while (selectedEmojis.length < length) {
      final emoji = emojis[random.nextInt(emojis.length)];
      selectedEmojis.add(emoji);
    }

    return selectedEmojis.join(' '); // Join them into a single string
  }
}
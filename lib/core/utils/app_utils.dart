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


  static String formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  static String getChatTime(String time) {
    final DateTime dateTime = DateTime.parse(time).toLocal(); // Convert to local time
    final int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12; // Convert to 12-hour format
    final String minute = dateTime.minute.toString().padLeft(2, '0'); // Add leading zero if needed
    final String period = dateTime.hour >= 12 ? 'PM' : 'AM'; // Determine AM/PM
    return "$hour:$minute $period";
  }

}
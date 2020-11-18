import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';

import './viking_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Util().fullScreen();
  await Util().setOrientation(DeviceOrientation.portraitUp);

  final game = VikingGame();
  runApp(game.widget);
}

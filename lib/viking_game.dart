import 'dart:math';
import 'dart:ui';

import 'package:flame/components/sprite_component.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:flame/gestures.dart';
import 'package:flame/extensions/offset.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/gestures.dart';

import 'boundaries.dart';
import 'viking.dart';

class VikingGame extends Forge2DGame with TapDetector {
  Image _backgroundImage;
  Image _vikingImage;
  Image _evilVikingImage;
  final List<Wall> walls = [];
  SpriteComponent _background;

  VikingGame() : super(scale: 10.0) {
    addContactCallback(EvilContactCallback());
  }

  @override
  void onResize(Vector2 size) {
    super.onResize(size);
    // Add a background
    _background?.remove();
    _background = SpriteComponent.fromImage(size, _backgroundImage);
    add(_background);

    // Add walls so that the bodies don't move outside of the screen
    removeAll(walls);
    walls.clear();
    walls.addAll(createBoundaries(viewport));
    addAll(walls);
  }

  @override
  Future<void> onLoad() async {
    _backgroundImage = await images.load('background.png');
    _vikingImage = await images.load('viking.png');
    _evilVikingImage = await images.load('evil_viking.png');
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    final position = details.localPosition.toVector2();

    if(Random().nextDouble() > 0.2) {
      add(Viking(position, _vikingImage));
    } else {
      add(EvilViking(position, _evilVikingImage));
    }
  }
}

class EvilContactCallback extends ContactCallback<Viking, EvilViking> {
  @override
  void begin(Viking viking, EvilViking evilViking, Contact contact) {
    viking.smacked = true;
  }

  @override
  void end(Viking viking, EvilViking evilViking, Contact contact) {}
}



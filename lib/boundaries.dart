import 'dart:ui';

import 'package:forge2d/forge2d.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/viewport.dart';

List<Wall> createBoundaries(Viewport viewport) {
  final Vector2 screenSize = viewport.size / viewport.scale;
  final Vector2 topLeft = (screenSize / 2) * -1;
  final Vector2 bottomRight = screenSize / 2;
  final Vector2 topRight = Vector2(bottomRight.x, topLeft.y);
  final Vector2 bottomLeft = Vector2(topLeft.x, bottomRight.y);

  return [
    Wall(topLeft, topRight),
    Wall(topRight, bottomRight),
    Wall(bottomRight, bottomLeft),
    Wall(bottomLeft, topLeft),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;

  Wall(this.start, this.end);

  @override
  Body createBody() {
    final EdgeShape shape = EdgeShape();
    shape.set(start, end);

    final fixtureDef = FixtureDef()
      ..shape = shape
      ..restitution = 0.0
      ..friction = 0.1;

    final bodyDef = BodyDef()
      ..setUserData(this) // To be able to determine object in collision
      ..position = Vector2.zero()
      ..type = BodyType.STATIC;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

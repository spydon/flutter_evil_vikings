import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flame_forge2d/sprite_body_component.dart';
import 'package:forge2d/forge2d.dart';

class Viking extends SpriteBodyComponent {
  final Vector2 startPosition;
  final Image image;
  bool smacked = false;

  Viking(this.startPosition, this.image) : super(Sprite(image), Vector2(10, 8));

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();

    final vertices = [
      Vector2(-size.x / 2, size.y / 2.5),
      Vector2(size.x / 3, size.y / 2),
      Vector2(size.x / 2, -size.y / 10),
      Vector2(size.x / 2, -size.y / 8),
      Vector2(size.x / 6, -size.y / 2),
      Vector2(0, -size.y / 2),
      Vector2(-size.x / 2.5, 0),
    ];
    shape.set(vertices, vertices.length);

    final fixtureDef = FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.3;
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.2;

    final bodyDef = BodyDef();
    bodyDef.setUserData(this);
    bodyDef.position = viewport.getScreenToWorld(startPosition);
    bodyDef.angle = Random().nextDouble() * 2 * 3.14;
    bodyDef.type = BodyType.DYNAMIC;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    if(smacked) {
      body.applyLinearImpulse(Vector2(0, 1000), body.getLocalCenter(), true);
      smacked = false;
    }
  }
  
  @override
  void renderPolygon(Canvas canvas, List<Offset> points) {}
}

class EvilViking extends Viking {
  EvilViking(Vector2 startPosition, Image image) : super(startPosition, image);
}


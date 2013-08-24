Vec2 = Crafty.math.Vector2D

Vec2.prototype.rotate_90 = () ->
  return new Vec2(@y,-@x)

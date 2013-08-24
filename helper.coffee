Vec2 = Crafty.math.Vector2D

Vec2.prototype.rotate_90 = () ->
  return new Vec2(@y,-@x)

Vec2.prototype.rotate = (rad) ->
    rot_mat = new Crafty.math.Matrix2D().rotate(rad)
    return rot_mat.apply(this.clone())

angle_between = (a,b) ->
  return Math.atan2(a.x, a.y)-Math.atan2(b.x, b.y)


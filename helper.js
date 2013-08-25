var Vec2, degToRad, radToDeg;

Vec2 = Crafty.math.Vector2D;

Vec2.prototype.rotate_90 = function() {
  return new Vec2(this.y, -this.x);
};

Vec2.prototype.rotate = function(rad) {
  var rot_mat;
  rot_mat = new Crafty.math.Matrix2D().rotate(rad);
  return rot_mat.apply(this.clone());
};

Vec2.prototype.asArray = function() {
  return [this.x, this.y];
};

degToRad = function(deg) {
  return deg * Math.PI / 180;
};

radToDeg = function(rad) {
  return rad * 180 / Math.PI;
};


Crafty.c("Centered", {
  get_pos: function() {
    return new Vec2(this.x + this.w / 2, this.y + this.h / 2);
  },
  set_pos: function(x, y) {
    if (!(y != null)) {
      this.x = x.x - this.w / 2;
      this.y = x.y - this.h / 2;
    } else {
      this.x = x - this.w / 2;
      this.y = y - this.h / 2;
    }
    return this;
  }
});

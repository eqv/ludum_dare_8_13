
Crafty.c("Weapon", {
  init: function() {
    this.requires("2D, Collision");
    this.arc = 90;
    this.reload_time = 1;
    this.charge = this.reload_time;
    this.speed = 5;
    this.shield_dmg = 10;
    this.armor_dmg = 10;
    this.duration = 5000;
    this.range = 300;
    this.color_head = "rgba(255, 255, 255, 1)";
    this.color_tail = "rgba(255, 255, 255, 0)";
    this.width = 1;
    this.ship = null;
    this.box = null;
    this.last_frame = Date.now();
    return this.bind("EnterFrame", this.on_frame.bind(this));
  },
  weapon: function(ship) {
    this.ship = ship;
    this.ship.attach(this);
    this.box = this.build_poly();
    return this.collision(this.box);
  },
  build_poly: function() {
    var pos1, pos2, pos3;
    pos1 = new Vec2(this.x, this.y);
    pos2 = (new Vec2(Math.cos(Crafty.math.degToRad(-this.arc / 2 + this.rotation)), Math.sin(Crafty.math.degToRad(-this.arc / 2 + this.rotation)))).scale(this.range).add(pos1);
    pos3 = (new Vec2(Math.cos(Crafty.math.degToRad(this.arc / 2 + this.rotation)), Math.sin(Crafty.math.degToRad(this.arc / 2 + this.rotation)))).scale(this.range).add(pos1);
    return new Crafty.polygon(pos1.asArray(), pos2.asArray(), pos3.asArray());
  },
  build_bullet: function(vx, vy) {
    return Crafty.e("Bullet").attr({
      x: this.x,
      y: this.y,
      vx: vx,
      vy: vy,
      width: this.width,
      color_tail: this.color_tail,
      color_head: this.color_head,
      duration: this.duration,
      armor_dmg: this.armor_dmg,
      shield_dmg: this.shield_dmg
    }).bullet(this.ship.team);
  },
  on_frame: function() {
    var dir, now, ship, sp, _i, _len, _ref, _results;
    if ((typeof currentLevel !== "undefined" && currentLevel !== null) && currentLevel.state === "animating") {
      now = Date.now();
      this.charge = Math.min(this.reload_time, this.charge + now - this.last_frame);
      this.last_frame = now;
      if (this.charge >= this.reload_time) {
        _ref = currentLevel.ships;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          ship = _ref[_i];
          if (ship.team === this.ship.team || !ship.is_alive()) continue;
          sp = ship.get_pos();
          if (this.box.containsPoint(sp.x, sp.y)) {
            this.charge = 0;
            dir = sp.subtract(new Vec2(this.x, this.y)).scaleToMagnitude(this.speed);
            _results.push(this.build_bullet(dir.x, dir.y));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      }
    }
  }
});

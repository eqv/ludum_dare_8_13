var bullet_last_update;

bullet_last_update = 0;

Crafty.c("Bullet", {
  init: function() {
    this.requires("2D, Collision");
    this.width = 1;
    this.color_head = "rgba(255, 255, 255, 1)";
    this.color_tail = "rgba(255, 255, 255, 0)";
    this.armor_dmg = 1;
    this.shield_dmg = 1;
    this.duration = 1000;
    this.now = this.start_time = Date.now();
    this.animating = true;
    this.my_team = null;
    this.c = $("#bullet_canvas")[0];
    if (!(this.c != null)) {
      this.c = document.createElement("canvas");
      this.c.id = "bullet_canvas";
      this.c.width = Crafty.viewport.width;
      this.c.height = Crafty.viewport.height;
      this.c.style.position = "absolute";
      this.c.style.left = "0px";
      this.c.style.top = "0px";
      Crafty.stage.elem.appendChild(this.c);
    }
    this.ctx = this.c.getContext("2d");
    this.bind("EnterFrame", this.on_frame.bind(this));
    this.collision(new Crafty.polygon([0, 0]));
    return this.onHit("Damagable", this.on_hit.bind(this));
  },
  bullet: function(my_team) {
    this.start_pos = new Vec2(this.x, this.y);
    return this.my_team = my_team;
  },
  stop: function() {
    if (this.animating) {
      this.animating = false;
      this.now = Date.now();
      return this.duration -= this.now - this.start_time;
    }
  },
  start: function() {
    if (!this.animating) {
      this.animating = true;
      return this.start_time = Date.now();
    }
  },
  on_frame: function(e) {
    var len, lingrad, trail_mid;
    if (bullet_last_update < e.frame) {
      bullet_last_update = e.frame;
      this.ctx.setTransform(1, 0, 0, 1, 0, 0);
      this.ctx.clearRect(0, 0, this.c.width, this.c.height);
      this.ctx.setTransform(1, 0, 0, 1, Crafty.viewport.x, Crafty.viewport.y);
    }
    if (currentLevel.state === "planning") {
      this.stop();
    } else if (currentLevel.state === "animating") {
      this.start();
    }
    this.now = this.animating ? Date.now() : this.now;
    if (this.now - this.start_time < this.duration) {
      if (this.animating) {
        this.x += this.vx;
        this.y += this.vy;
      }
      len = this.start_pos.distance(new Vec2(this.x, this.y));
      if (len > 80) {
        this.start_pos.scale(80 / len).add(new Vec2(this.x, this.y).scale(1 - 80 / len));
      }
      trail_mid = Math.max(0, 1 - 15 / len);
      this.ctx.beginPath();
      lingrad = this.ctx.createLinearGradient(this.start_pos.x, this.start_pos.y, this.x, this.y);
      lingrad.addColorStop(0, this.color_tail);
      lingrad.addColorStop(trail_mid, this.color_head);
      lingrad.addColorStop(1, this.color_head);
      this.ctx.strokeStyle = lingrad;
      this.ctx.lineCap = "round";
      this.ctx.lineWidth = this.width;
      this.ctx.moveTo(this.start_pos.x, this.start_pos.y);
      this.ctx.lineTo(this.x, this.y);
      return this.ctx.stroke();
    } else if (this.animating) {
      return this.destroy();
    }
  },
  on_hit: function(e) {
    var s, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = e.length; _i < _len; _i++) {
      s = e[_i];
      if (s.obj.team !== this.my_team) {
        this.duration = 0;
        _results.push(s.obj.take_dmg(this));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  }
});

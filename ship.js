
Crafty.c("Damagable", {
  init: function() {
    this.armor_stat = this.armor;
    return this.shield_stat = this.shields;
  },
  take_dmg: function(bullet) {
    this.trigger("DamageTaken");
    this.was_damaged = true;
    if (this.shield_stat > 0) {
      return this.shield_stat -= bullet.shield_dmg;
    } else {
      return this.armor_stat -= bullet.armor_dmg;
    }
  },
  regen_shields: function() {
    if (this.armor_stat <= 0) return false;
    if (this.shield_stat > 0 && this.shield_stat < this.shields) {
      this.shield_stat += this.shield_regen;
      if (this.shield_Stat > this.shields) this.shield_stat = this.shields;
    } else {
      if (!this.was_damaged) this.shield_stat = this.shield_regen;
    }
    return this.was_damaged = false;
  },
  get_shield_factor: function() {
    if (this.shield_stat < 0) return 0;
    return this.shield_stat / this.shields;
  },
  get_armor_factor: function() {
    if (this.armor_stat < 0) return 0;
    return this.armor_stat / this.armor;
  },
  is_alive: function() {
    return this.armor_stat > 0;
  }
});

Crafty.c("Ship", {
  init: function() {
    return this.requires("2D,DOM, Image, Damagable, Centered");
  },
  get_dir: function() {
    return (new Vec2(1, 0)).rotate(degToRad(this._rotation));
  },
  get_path_to: function(target) {
    var center, dot, radius, res, steering, target_dir;
    steering = this.get_steering_circle(target);
    center = steering.center;
    radius = steering.radius;
    res = {
      end_pos: target,
      center: center,
      radius: radius,
      end_time: 1
    };
    if (!this.is_valid_target(target, center, radius)) {
      this.get_closest_valid_target(res);
    }
    target_dir = res.end_pos.clone().subtract(this.get_pos());
    dot = target_dir.dotProduct(this.get_dir());
    if (dot < 0) return null;
    return res;
  },
  get_closest_valid_target: function(res) {
    var center, dist, max_rad, min_rad, new_center, new_target, new_target_a, new_target_b, radius, self_dir, target, target_dir;
    target = res.end_pos;
    center = res.center;
    radius = res.radius;
    dist = this.get_movement_length(target, center, radius);
    if (!center) {
      if (dist > this.get_max_move_dist()) {
        new_target = this.get_pos().subtract(target).normalize().scale(this.get_max_move_dist());
        new_target.add(this.get_pos());
        target.x = new_target.x;
        target.y = new_target.y;
      }
      if (dist < this.get_min_move_dist()) {
        new_target = this.get_pos().subtract(target).normalize().scale(this.get_min_move_dist());
        new_target.add(this.get_pos());
        target.x = new_target.x;
        return target.y = new_target.y;
      }
    } else {
      if (radius < this.get_min_turn_radius()) {
        new_center = center.clone().subtract(this.get_pos()).normalize().scale(this.get_min_turn_radius());
        new_center.add(this.get_pos());
        center.x = new_center.x;
        center.y = new_center.y;
        target_dir = target.clone().subtract(center);
        target_dir.scaleToMagnitude(this.get_min_turn_radius());
        target.x = center.x + target_dir.x;
        target.y = center.y + target_dir.y;
        radius = this.get_min_turn_radius();
        res.radius = radius;
        dist = this.get_movement_length(target, center, radius);
      }
      if (dist < this.get_min_move_dist()) {
        target_dir = target.clone().subtract(center);
        self_dir = this.get_pos().subtract(center);
        min_rad = this.get_min_move_dist() / radius;
        new_target_a = self_dir.clone().rotate(min_rad);
        new_target_b = self_dir.clone().rotate(-min_rad);
        if (target_dir.distance(new_target_a) < target_dir.distance(new_target_b)) {
          target.x = new_target_a.x + center.x;
          target.y = new_target_a.y + center.y;
        } else {
          target.x = new_target_b.x + center.x;
          target.y = new_target_b.y + center.y;
        }
      }
      if (dist > this.get_max_move_dist()) {
        target_dir = target.clone().subtract(center);
        self_dir = this.get_pos().subtract(center);
        max_rad = this.get_max_move_dist() / radius;
        new_target_a = self_dir.clone().rotate(max_rad);
        new_target_b = self_dir.clone().rotate(-max_rad);
        if (target_dir.distance(new_target_a) > target_dir.distance(new_target_b)) {
          target.x = new_target_b.x + center.x;
          return target.y = new_target_b.y + center.y;
        } else {
          target.x = new_target_a.x + center.x;
          return target.y = new_target_a.y + center.y;
        }
      }
    }
  },
  is_valid_target: function(target, center, radius) {
    var dist;
    dist = this.get_movement_length(target, center, radius);
    if (dist > this.get_max_move_dist() || dist < this.get_min_move_dist()) {
      return false;
    }
    if (center && radius < this.get_min_turn_radius()) return false;
    return true;
  },
  get_min_turn_radius: function() {
    return this.min_turn_radius;
  },
  get_max_move_dist: function() {
    return this.max_speed;
  },
  get_min_move_dist: function() {
    return this.min_speed;
  },
  get_movement_length: function(target, center, radius) {
    var rad;
    if (center) {
      rad = (this.get_pos().subtract(center)).angleBetween(target.clone().subtract(center));
      return Math.abs(rad * radius);
    } else {
      return this.get_pos().subtract(target).magnitude();
    }
  },
  get_steering_circle: function(target) {
    var center, dir, halfway, in_dir, l1_p1, l1_p2, l2_p1, l2_p2, pos, target_dir;
    pos = this.get_pos();
    dir = this.get_dir();
    in_dir = pos.clone().add(dir.clone().scale(20));
    target_dir = target.clone().subtract(pos).normalize();
    l1_p1 = pos;
    l1_p2 = dir.rotate_90().add(pos);
    halfway = pos.clone().add(target).scale(0.5);
    l2_p1 = halfway;
    l2_p2 = target_dir.rotate_90().scale(10).add(halfway);
    center = this.checkLineIntersection(l1_p1, l1_p2, l2_p1, l2_p2);
    return {
      center: center,
      radius: center && center.distance(pos)
    };
  },
  checkLineIntersection: function(line1_start, line1_end, line2_start, line2_end) {
    var a, b, denominator, numerator1, numerator2, x, y;
    denominator = ((line2_end.y - line2_start.y) * (line1_end.x - line1_start.x)) - ((line2_end.x - line2_start.x) * (line1_end.y - line1_start.y));
    if (denominator === 0) return null;
    a = line1_start.y - line2_start.y;
    b = line1_start.x - line2_start.x;
    numerator1 = ((line2_end.x - line2_start.x) * a) - ((line2_end.y - line2_start.y) * b);
    numerator2 = ((line1_end.x - line1_start.x) * a) - ((line1_end.y - line1_start.y) * b);
    a = numerator1 / denominator;
    b = numerator2 / denominator;
    x = line1_start.x + (a * (line1_end.x - line1_start.x));
    y = line1_start.y + (a * (line1_end.y - line1_start.y));
    return new Vec2(x, y);
  }
});

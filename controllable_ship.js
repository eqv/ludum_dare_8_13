
Crafty.c("ControllableShip", {
  init: function() {
    var pos;
    this.requires("Ship, Mouse");
    if (this.is_alive()) {
      this.bind("Click", this.on_contrallable_ship_on_click);
      this.controller = Crafty.e("Controller");
      return this.controller.controller(this);
    } else {
      pos = this.get_pos().add(this.get_dir().scale(this.get_min_move_dist()));
      return this.keyframes = [
        {
          end_pos: pos,
          center: null,
          radius: null,
          end_time: 1
        }
      ];
    }
  },
  controllable_ship_on_click: function() {
    this.unbind("Click", this.on_click);
    if (this.controller) return this.controller.activate();
  },
  remove_controll: function() {
    this.unbind("Click", this.on_contrallable_ship_on_click);
    if (this.controller) this.controller.destroy();
    this.controller = null;
    return this.removeComponent("ControllableShip");
  }
});

Crafty.c("Controller", {
  init: function() {
    this.requires("2D, DOM, Image, RestrictedDraggable, Centered");
    this.image("assets/move_target.png");
    this.w = 32;
    this.h = 32;
    return this.origin("center");
  },
  controller: function(ship) {
    var pos;
    this.ship = ship;
    pos = this.ship.get_pos().add(this.ship.get_dir().scale((this.ship.get_min_move_dist() + this.ship.get_max_move_dist()) / 2));
    this.set_path({
      end_pos: pos,
      center: null,
      radius: null,
      end_time: 1
    });
    this.x = pos.x;
    this.y = pos.y;
    this.enableDrag();
    this.bind("DragStart", function() {
      return Crafty.viewport.lookmouse(false);
    });
    this.bind("DragEnd", function() {
      return Crafty.viewport.lookmouse(true);
    });
    return this.alpha = 0.4;
  },
  activate: function() {
    var controller_id, _i, _len, _ref;
    _ref = Crafty("Controller");
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      controller_id = _ref[_i];
      Crafty(controller_id).deactivate();
    }
    this.alpha = 1;
    this.active = true;
    this.selected = true;
    return this.ship.trigger("SelectedShip");
  },
  deactivate: function() {
    this.alpha = 0.4;
    this.selected = false;
    return this.ship.trigger("DeselectedShip");
  },
  set_path: function(path) {
    this.path = path;
    if (path) this.ship.keyframes = [path];
    return this.rotation = this.get_final_rotation(path);
  },
  get_final_rotation: function(path) {
    var self_dir, target_dir;
    if (path.center) {
      target_dir = path.end_pos.clone().subtract(path.center);
      self_dir = this.ship.get_pos().clone().subtract(path.center);
      return this.ship.rotation - radToDeg(target_dir.angleBetween(self_dir));
    } else {
      return radToDeg(this.ship.get_pos().angleTo(path.end_pos));
    }
  },
  is_valid_drag_position: function(x, y) {
    var path;
    this.activate();
    this.alpha = 1;
    path = this.ship.get_path_to(new Vec2(x, y));
    this.set_path(path);
    if (path) return path.end_pos;
    return null;
  }
});

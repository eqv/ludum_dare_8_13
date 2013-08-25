
Crafty.c("ViewportStatic", {
  xOff: 0,
  yOff: 0,
  startGui: function() {
    this.requires("2D");
    return this.bind("EnterFrame", function() {
      var relative_x, relative_y;
      relative_x = -Crafty.viewport.x + this.xOff;
      relative_y = -Crafty.viewport.y + this.yOff;
      if (this._x !== relative_x || this._y !== relative_y) {
        this.x = relative_x;
        return this.y = relative_y;
      }
    });
  }
});

Crafty.c("NextTurnButton", {
  init: function() {
    this.requires("2D, DOM, Image, Mouse, ViewportStatic");
    this.image("assets/next_turn.png");
    this.xOff = 20;
    return this.yOff = 20;
  },
  nextTurnButton: function(team) {
    this.team = team;
    this.bind("Click", this.on_click);
    return this.startGui();
  },
  remove: function() {
    return this.destroy();
  },
  on_click: function(e) {
    var count_unused_ships, ok, ship, ship_id, _i, _len, _ref;
    count_unused_ships = 0;
    _ref = Crafty("ControllableShip");
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      ship_id = _ref[_i];
      ship = Crafty(ship_id);
      if (ship.is_alive() && !ship.controller.active) count_unused_ships += 1;
    }
    ok = true;
    if (count_unused_ships > 0) {
      ok = confirm("you have unused ships, do you really want to continue?");
    }
    if (ok) {
      this.team.cleanup_planning();
      return currentLevel.next_planning_turn();
    }
  }
});

Crafty.c("StatusBar", {
  init: function() {
    return this.requires("2D, DOM, ViewportStatic, Color");
  },
  statusBar: function(icon, attr) {
    this.xOff = icon.xOff + (attr.xOff || 0);
    this.yOff = icon.yOff + (attr.yOff || 0);
    this.h = attr.h || 2;
    this.w = attr.factor * 32;
    this.color(attr.color || "#f00");
    return this.startGui();
  }
});

Crafty.c("ShipIcon", {
  init: function() {
    this.requires("2D, DOM, Image, Mouse, ViewportStatic");
    return this.bind("Click", this.on_click);
  },
  shipIcon: function(ship) {
    var armor_factor, shield_factor, that;
    this.ship = ship;
    this.xOff = 60 + ship.ship_id * 36;
    this.yOff = 20;
    this.startGui();
    this.set_icon(this, ship);
    this.body = Crafty.e("StatusBar");
    armor_factor = ship.get_armor_factor();
    shield_factor = ship.get_shield_factor();
    this.body.statusBar(this, {
      color: "#f00",
      factor: armor_factor,
      yOff: 32
    });
    this.shield = Crafty.e("StatusBar");
    this.shield.statusBar(this, {
      color: "#00f",
      factor: shield_factor,
      yOff: 34
    });
    that = this;
    this.set_icon_callback = function() {
      return that.set_icon(that, ship);
    };
    this.ship.bind("SelectedShip", this.set_icon_callback);
    return this.ship.bind("DeselectedShip", this.set_icon_callback);
  },
  remove: function() {
    this.ship.unbind("SelectedShip", this.set_icon_callback);
    this.ship.unbind("DeselectedShip", this.set_icon_callback);
    this.shield.destroy();
    this.body.destroy();
    return this.destroy();
  },
  set_icon: function(icon, ship) {
    if (ship.armor_stat > 0) {
      if ((ship.controller != null) && ship.controller.selected) {
        return icon.image("" + ship.filename + "_icon_selected.png");
      } else {
        return icon.image("" + ship.filename + "_icon.png");
      }
    } else {
      return icon.image("" + ship.filename + "_icon_dead.png");
    }
  },
  on_click: function() {
    var h, w;
    w = Crafty.viewport.width;
    h = Crafty.viewport.height;
    Crafty.viewport.x = -(this.ship.get_pos().x - w / 2);
    Crafty.viewport.y = -(this.ship.get_pos().y - h / 2);
    return this.ship.controller.activate();
  }
});

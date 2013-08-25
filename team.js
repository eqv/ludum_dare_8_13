
Crafty.c("Team", {
  init: function() {
    return this.fleet = [];
  },
  planning_turn: function() {
    return this.perform_planning();
  }
});

Crafty.c("HumanPlayer", {
  init: function() {
    return this.requires("Team");
  },
  perform_planning: function() {
    var btn, e, ship, _i, _j, _len, _len2, _ref, _ref2, _results;
    _ref = this.fleet;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      ship = _ref[_i];
      ship.addComponent("ControllableShip");
    }
    btn = Crafty.e("NextTurnButton");
    btn.nextTurnButton(this);
    _ref2 = this.fleet;
    _results = [];
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      ship = _ref2[_j];
      e = Crafty.e("ShipIcon");
      _results.push(e.shipIcon(ship));
    }
    return _results;
  },
  cleanup_planning: function() {
    var id, ship, _i, _j, _len, _len2, _ref, _ref2, _results;
    _ref = Crafty("ShipIcon, NextTurnButton");
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      id = _ref[_i];
      Crafty(id).remove();
    }
    _ref2 = this.fleet;
    _results = [];
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      ship = _ref2[_j];
      _results.push(ship.remove_controll());
    }
    return _results;
  }
});

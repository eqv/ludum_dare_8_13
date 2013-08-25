var Level, currentLevel, i, levels, startScene;

levels = [];

currentLevel = null;

levels[1] = {
  ships: [
    {
      type: "BattleShip",
      x: 320,
      y: 240,
      rot: 20,
      team: "coco"
    }, {
      type: "Cruiser",
      x: 150,
      y: 100,
      rot: 90,
      team: "eugen"
    }, {
      type: "Fighter",
      x: 100,
      y: 120,
      rot: 30,
      team: "eugen"
    }
  ],
  teams: [
    {
      name: "eugen",
      type: "HumanPlayer"
    }, {
      name: "coco",
      type: "HumanPlayer"
    }
  ]
};

Level = (function() {

  function Level(lvl) {
    var i, ship, ship_desc, team, team_desc, _len, _len2, _ref, _ref2;
    this.ships = [];
    this.teams = [];
    this.teams_by_name = {};
    _ref = lvl.teams;
    for (i = 0, _len = _ref.length; i < _len; i++) {
      team_desc = _ref[i];
      team = Crafty.e(team_desc.type);
      team.name = team_desc.name;
      this.teams[i] = team;
      this.teams_by_name[team_desc.name] = team;
    }
    _ref2 = lvl.ships;
    for (i = 0, _len2 = _ref2.length; i < _len2; i++) {
      ship_desc = _ref2[i];
      ship = Crafty.e(ship_desc.type);
      ship.attr({
        rotation: ship_desc.rot
      });
      ship.set_pos(ship_desc.x, ship_desc.y);
      ship.team = ship_desc.team;
      ship.ship_id = this.teams_by_name[ship_desc.team].fleet.length;
      this.teams_by_name[ship_desc.team].fleet.push(ship);
      this.ships[i] = ship;
    }
  }

  Level.prototype.next_planning_turn = function() {
    if (this.current_team >= this.teams.length) {
      return this.animation_phase();
    } else {
      this.teams[this.current_team].planning_turn();
      return this.current_team += 1;
    }
  };

  Level.prototype.planning_phase = function() {
    var obj_id, ship, _i, _j, _len, _len2, _ref, _ref2;
    this.check_win_conditions();
    this.state = "planning";
    _ref = Crafty("Damagable");
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      obj_id = _ref[_i];
      Crafty(obj_id).regen_shields();
    }
    if (this.check_win_conditions()) return;
    _ref2 = Crafty("Ship");
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      ship = _ref2[_j];
      ship = Crafty(ship);
      ship.removeComponent("AnimatedShip");
    }
    this.current_team = 0;
    return this.next_planning_turn();
  };

  Level.prototype.animation_phase = function() {
    var ship, ship_id, _i, _len, _ref, _results;
    this.state = "animating";
    _ref = Crafty("Ship");
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      ship_id = _ref[_i];
      ship = Crafty(ship_id);
      _results.push(ship.addComponent("AnimatedShip"));
    }
    return _results;
  };

  Level.prototype.ship_finished_animating = function() {
    var count_unfinished_ships, ship, _i, _len, _ref;
    count_unfinished_ships = 0;
    _ref = Crafty("Ship");
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      ship = _ref[_i];
      ship = Crafty(ship);
      if (ship.has("AnimatedShip")) count_unfinished_ships += 1;
    }
    if (count_unfinished_ships === 0) return this.planning_phase();
  };

  Level.prototype.check_win_conditions = function() {
    var alive_teams, team, _i, _len, _ref;
    alive_teams = 0;
    _ref = this.teams;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      team = _ref[_i];
      if (this.get_living_ships_of(team).length > 0) alive_teams += 1;
    }
    if (alive_teams <= 1) {
      console.log("We have a Winner, going to game_ended scene");
      Crafty.scene("game_ended");
      return true;
    }
    return false;
  };

  Level.prototype.get_living_ships_of = function(team) {
    var ship;
    return (function() {
      var _i, _len, _ref, _results;
      _ref = team.fleet;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        ship = _ref[_i];
        if (ship.is_alive()) _results.push(ship);
      }
      return _results;
    })();
  };

  return Level;

})();

startScene = function(i) {
  currentLevel = new Level(levels[i]);
  Crafty.viewport.mouselook(true);
  return currentLevel.planning_phase();
};

for (i = 1; i <= 5; i++) {
  Crafty.scene("level_" + i, startScene.bind(null, i));
}

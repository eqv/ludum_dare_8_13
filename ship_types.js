
Crafty.c("Fighter", {
  init: function() {
    this.filename = "assets/fighter";
    this.max_speed = 200;
    this.min_speed = 20;
    this.min_turn_radius = 100;
    this.armor = 10;
    this.shields = 10;
    this.shield_regen = 5;
    this.requires("Ship");
    this.image("" + this.filename + ".png");
    this.w = 26;
    this.h = 30;
    this.origin("center");
    return this.weapons = [
      Crafty.e("FighterWeapon").attr({
        x: 17,
        y: 11,
        rotation: 0
      }).weapon(this), Crafty.e("FighterWeapon").attr({
        x: 17,
        y: 19,
        rotation: 0
      }).weapon(this)
    ];
  }
});

Crafty.c("Cruiser", {
  init: function() {
    this.filename = "assets/cruiser";
    this.max_speed = 150;
    this.min_speed = 50;
    this.min_turn_radius = 100;
    this.armor = 20;
    this.shields = 20;
    this.shield_regen = 5;
    this.requires("Ship");
    this.image("" + this.filename + ".png");
    this.w = 64;
    this.h = 31;
    this.origin("center");
    return this.weapons = [
      Crafty.e("CruiserWeapon").attr({
        x: 60,
        y: 15,
        rotation: 0
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 22,
        y: 10,
        rotation: 270
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 29,
        y: 10,
        rotation: 270
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 46,
        y: 11,
        rotation: 270
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 22,
        y: 21,
        rotation: 90
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 29,
        y: 21,
        rotation: 90
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 46,
        y: 21,
        rotation: 90
      }).weapon(this)
    ];
  }
});

Crafty.c("BattleShip", {
  init: function() {
    this.filename = "assets/battleship";
    this.max_speed = 100;
    this.min_speed = 20;
    this.min_turn_radius = 180;
    this.armor = 50;
    this.shields = 50;
    this.shield_regen = 10;
    this.requires("Ship");
    this.image("" + this.filename + ".png");
    this.w = 179;
    this.h = 71;
    this.origin("center");
    return this.weapons = [
      Crafty.e("BattleShipWeapon").attr({
        x: 119,
        y: 17,
        rotation: 0
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 119,
        y: 53,
        rotation: 0
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 133,
        y: 26,
        rotation: 270
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 145,
        y: 26,
        rotation: 270
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 100,
        y: 28,
        rotation: 270
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 85,
        y: 28,
        rotation: 270
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 70,
        y: 28,
        rotation: 270
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 133,
        y: 44,
        rotation: 90
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 146,
        y: 44,
        rotation: 90
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 100,
        y: 42,
        rotation: 90
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 85,
        y: 42,
        rotation: 90
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 70,
        y: 42,
        rotation: 90
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 50,
        y: 29,
        rotation: 250
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 50,
        y: 41,
        rotation: 130
      }).weapon(this)
    ];
  }
});

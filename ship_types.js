
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
        x: 10,
        y: 5,
        rotation: 0
      }).weapon(this), Crafty.e("FighterWeapon").attr({
        x: 10,
        y: 10,
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
        x: 30,
        y: 8,
        rotation: 0
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 15,
        y: 12,
        rotation: 90
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 20,
        y: 12,
        rotation: 90
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 25,
        y: 12,
        rotation: 90
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 15,
        y: 4,
        rotation: 270
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 20,
        y: 4,
        rotation: 270
      }).weapon(this), Crafty.e("CruiserWeapon").attr({
        x: 25,
        y: 4,
        rotation: 270
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
    this.w = 185;
    this.h = 84;
    this.origin("center");
    return this.weapons = [
      Crafty.e("BattleShipWeapon").attr({
        x: 61,
        y: 11,
        rotation: 0
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 61,
        y: 29,
        rotation: 0
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 75,
        y: 15,
        rotation: 270
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 68,
        y: 15,
        rotation: 270
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 50,
        y: 12,
        rotation: 270
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 45,
        y: 12,
        rotation: 270
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 40,
        y: 12,
        rotation: 270
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 75,
        y: 25,
        rotation: 90
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 68,
        y: 25,
        rotation: 90
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 50,
        y: 28,
        rotation: 90
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 45,
        y: 28,
        rotation: 90
      }).weapon(this), Crafty.e("BattleShipWeapon").attr({
        x: 40,
        y: 28,
        rotation: 90
      }).weapon(this)
    ];
  }
});

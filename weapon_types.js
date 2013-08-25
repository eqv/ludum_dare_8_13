
Crafty.c("StandardWeapon", {
  init: function() {
    this.requires("Weapon");
    this.arc = 90;
    this.reload_time = 2000;
    this.charge = this.reload_time;
    this.speed = 5;
    this.shield_dmg = 1;
    this.armor_dmg = 1;
    this.duration = 5000;
    this.range = 300;
    this.color_head = "rgba(0, 0, 255, 1)";
    this.color_tail = "rgba(255, 0, 0, 0)";
    return this.width = 3;
  }
});

Crafty.c("FighterWeapon", {
  init: function() {
    this.requires("Weapon");
    this.arc = 40;
    this.reload_time = 2000;
    this.charge = this.reload_time;
    this.speed = 10;
    this.shield_dmg = 2;
    this.armor_dmg = 2;
    this.duration = 2500;
    this.range = 300;
    this.color_head = "rgba(255,   0,   0, 1)";
    this.color_tail = "rgba(255, 255, 255, 0)";
    return this.width = 1;
  }
});

Crafty.c("CruiserWeapon", {
  init: function() {
    this.requires("Weapon");
    this.arc = 40;
    this.reload_time = 2000;
    this.charge = this.reload_time;
    this.speed = 7;
    this.shield_dmg = 5;
    this.armor_dmg = 5;
    this.duration = 2500;
    this.range = 400;
    this.color_head = "rgba(  0, 255,   0, 1)";
    this.color_tail = "rgba(255, 255, 255, 0)";
    return this.width = 2;
  }
});

Crafty.c("BattleShipWeapon", {
  init: function() {
    this.requires("Weapon");
    this.arc = 60;
    this.reload_time = 2000;
    this.charge = this.reload_time;
    this.speed = 10;
    this.shield_dmg = 10;
    this.armor_dmg = 10;
    this.duration = 2500;
    this.range = 500;
    this.color_head = "rgba(  0,   0, 255, 1)";
    this.color_tail = "rgba(255, 255, 255, 0)";
    return this.width = 2;
  }
});

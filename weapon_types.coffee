Crafty.c "StandardWeapon", {
  init: ->
    this.requires "Weapon"
    @arc = 90
    @reload_time = 2000
    @charge = @reload_time
    @speed = 5
    @shield_dmg = 1
    @armor_dmg = 1
    @duration = 5000
    @range = 300
    @color_head = "rgba(0, 0, 255, 1)"
    @color_tail = "rgba(255, 0, 0, 0)"
    @width = 3
}

Crafty.c "FighterWeapon", {
  init: ->
    this.requires "Weapon"
    @arc = 40
    @reload_time = 300
    @charge = @reload_time
    @speed = 10
    @shield_dmg = 0.5
    @armor_dmg = 0.5
    @duration = 1000
    @range = 300
    @color_head = "rgba(255,   0,   0, 1)"
    @color_tail = "rgba(255, 255, 255, 0)"
    @width = 1
}

Crafty.c "CruiserWeapon", {
  init: ->
    this.requires "Weapon"
    @arc = 60
    @reload_time = 2000
    @charge = @reload_time
    @speed = 7
    @shield_dmg = 5
    @armor_dmg = 5
    @duration = 2500
    @range = 400
    @color_head = "rgba(  0, 255,   0, 1)"
    @color_tail = "rgba(255, 255, 255, 0)"
    @width = 2
}

Crafty.c "BattleShipWeapon", {
  init: ->
    this.requires "Weapon"
    @arc = 60
    @reload_time = 4000
    @charge = @reload_time
    @speed = 5
    @shield_dmg = 10
    @armor_dmg = 10
    @duration = 3000
    @range = 600
    @color_head = "rgba(  0,   0, 255, 1)"
    @color_tail = "rgba(255, 255, 255, 0)"
    @width = 3
}

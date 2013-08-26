
Crafty.c "Fighter", {
  init: ->
    @filename = "assets/fighter"
    @max_speed = 240
    @min_speed = 20
    @min_turn_radius = 80
    @armor = 6
    @shields = 2
    @shield_regen = 1
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship"
    this.image("#{@filename}.png")
    @w = 26
    @h = 30
    this.origin("center")
    @weapons = [Crafty.e("FighterWeapon").attr(x: 17, y: 11, rotation: 0, detection_delay: 1).weapon(this),
                Crafty.e("FighterWeapon").attr(x: 17, y: 19, rotation: 0, detection_delay: 0.0).weapon(this)]
}


Crafty.c "Cruiser", {
  init: ->
    @filename = "assets/cruiser"
    @max_speed = 150
    @min_speed = 50
    @min_turn_radius = 120
    @armor = 10
    @shields = 10
    @shield_regen = 2
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship"
    this.image("#{@filename}.png")
    @w = 64
    @h = 31
    this.origin("center")
    @weapons = [Crafty.e("CruiserWeapon").attr(x: 60, y: 15, rotation:   0).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 22, y: 10, rotation: 270).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 29, y: 10, rotation: 270).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 46, y: 11, rotation: 270).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 22, y: 21, rotation:  90).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 29, y: 21, rotation:  90).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 46, y: 21, rotation:  90).weapon(this)]
}


Crafty.c "BattleShip", {
  init: ->
    @filename = "assets/battleship"
    @max_speed = 100
    @min_speed = 20
    @min_turn_radius = 180
    @armor = 50
    @shields = 50
    @shield_regen = 10
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship"
    this.image("#{@filename}.png")
    @w = 179
    @h = 71
    this.origin("center")
    @weapons = [Crafty.e("BattleShipWeapon").attr(x: 119, y: 17, rotation:   0).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 119, y: 53, rotation:   0).weapon(this),
                # TOP
                Crafty.e("BattleShipWeapon").attr(x: 133, y: 26, rotation: 270).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 145, y: 26, rotation: 270).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 100, y: 28, rotation: 270).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x:  85, y: 28, rotation: 270).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x:  70, y: 28, rotation: 270).weapon(this),
                # BOTTOM
                Crafty.e("BattleShipWeapon").attr(x: 133, y: 44, rotation:  90).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 146, y: 44, rotation:  90).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 100, y: 42, rotation:  90).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x:  85, y: 42, rotation:  90).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x:  70, y: 42, rotation:  90).weapon(this),
                # LEFT
                Crafty.e("CruiserWeapon").attr(x:  50, y: 29, rotation: 250).weapon(this),
                Crafty.e("CruiserWeapon").attr(x:  50, y: 41, rotation: 130).weapon(this)]
}

Crafty.c "TestShip",  {
  init: ->
    @filename = "assets/testship"
    @speed = 1
    @maneuverability = 1
    @armor = 1
    @shields = 1
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship"
    this.image("#{@filename}.png")
    @w = 120
    @h = 55
    this.origin("center")
    @weapons = [Crafty.e("StandardWeapon").attr(x: 50, y: 14, rotation: 45).weapon(this)]
}


Crafty.c "Fighter", {
  init: ->
    @filename = "assets/fighter"
    @speed = 1
    @maneuverability = 1
    @armor = 10
    @shields = 10
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship"
    this.image("#{@filename}.png")
    @w = 26
    @h = 30
    this.origin("center")
    @weapons = [Crafty.e("FighterWeapon").attr(x: 10, y:  5, rotation: 0).weapon(this),
                Crafty.e("FighterWeapon").attr(x: 10, y: 10, rotation: 0).weapon(this)]
}


Crafty.c "Cruiser", {
  init: ->
    @filename = "assets/cruiser"
    @speed = 1
    @maneuverability = 1
    @armor = 20
    @shields = 20
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship"
    this.image("#{@filename}.png")
    @w = 64
    @h = 31
    this.origin("center")
    @weapons = [Crafty.e("CruiserWeapon").attr(x: 30, y:  8, rotation:   0).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 15, y: 12, rotation:  90).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 20, y: 12, rotation:  90).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 25, y: 12, rotation:  90).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 15, y:  4, rotation: 270).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 20, y:  4, rotation: 270).weapon(this),
                Crafty.e("CruiserWeapon").attr(x: 25, y:  4, rotation: 270).weapon(this)]
}


Crafty.c "BattleShip", {
  init: ->
    @filename = "assets/battleship"
    @speed = 1
    @maneuverability = 1
<<<<<<< HEAD
    @armor = 5
    @shields = 5
    @shield_regen = 1
=======
    @armor = 50
    @shields = 50
>>>>>>> e3844851e82bbc5a4c78ad4b302df10666e21728
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship"
    this.image("#{@filename}.png")
    @w = 185
    @h = 84
    this.origin("center")
    @weapons = [Crafty.e("BattleShipWeapon").attr(x: 61, y: 11, rotation:   0).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 61, y: 29, rotation:   0).weapon(this),
                # TOP
                Crafty.e("BattleShipWeapon").attr(x: 75, y: 15, rotation: 270).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 68, y: 15, rotation: 270).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 50, y: 12, rotation: 270).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 45, y: 12, rotation: 270).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 40, y: 12, rotation: 270).weapon(this),
                # BOTTOM
                Crafty.e("BattleShipWeapon").attr(x: 75, y: 25, rotation:  90).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 68, y: 25, rotation:  90).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 50, y: 28, rotation:  90).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 45, y: 28, rotation:  90).weapon(this),
                Crafty.e("BattleShipWeapon").attr(x: 40, y: 28, rotation:  90).weapon(this)]
}

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
    @armor = 1
    @shields = 1
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship"
    this.image("#{@filename}.png")
    @w = 26
    @h = 30
    this.origin("center")
    @weapons = [Crafty.e("StandardWeapon").attr(x: 50, y: 14, rotation: 45).weapon(this)]
}


Crafty.c "Cruiser", {
  init: ->

    @filename = "assets/cruiser"
    @speed = 1
    @maneuverability = 1
    @armor = 1
    @shields = 1
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship"
    this.image("#{@filename}.png")
    @w = 64
    @h = 31
    this.origin("center")
    @weapons = [Crafty.e("StandardWeapon").attr(x: 50, y: 14, rotation: 45).weapon(this)]
}


Crafty.c "BattleShip", {
  init: ->

    @filename = "assets/battleship"
    @speed = 1
    @maneuverability = 1
    @armor = 1
    @shields = 1
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship"
    this.image("#{@filename}.png")
    @w = 185
    @h = 84
    this.origin("center")
    @weapons = [Crafty.e("StandardWeapon").attr(x: 50, y: 14, rotation: 45).weapon(this)]
}

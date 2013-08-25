
Crafty.c "TestShip",  {
  init: ->

    @filename = "assets/testship"
    @speed = 1
    @maneuverability = 1
    @armor = 1
    @weapons = [Crafty.e("Weapon").attr(x: 50, y: 14, rotation: 45).weapon(120, 2000, this)]
    @shields = 1
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship"
    this.image("#{@filename}.png")
    @w = 120
    @h = 55
    this.origin("center")
}

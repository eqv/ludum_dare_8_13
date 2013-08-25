Crafty.c "TestShip",  {
  init: ->
    @filename = "assets/testship"
    @speed = 1
    @maneuverability = 1
    @armor = 1
    @weapons = [Crafty.e("Weapon").weapon(0, 0, 0, 90, 10, this)]
    @shields = 1
    @shields_regen = 1
    #you should put this at the end, otherwise initialization of the other
    #components that depend on th ships characteristics fail
    this.requires "Ship" 
    this.image("#{@filename}.png")
}

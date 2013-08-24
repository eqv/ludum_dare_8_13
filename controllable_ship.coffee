Crafty.c "Ship", {
  init: ->
    this.requires "2D,DOM,Image"
  }

Crafty.c "ControllableShip", {
  init: ->
    this.requires "Ship, Mouse"
    this.bind "Click", this.on_click
    @controller = Crafty.e "Controller"
    @controller.ship = this

  on_click: ->
    console.log "clicked"
    @controller.activate()
  }

Crafty.c "TestShip",  {
  init: ->
    this.requires "Ship"
    this.image("assets/testship.png")
    @speed = 1
    @maneuverability = 1
    @armor = 1
    @weapons = []
    @shields = 1
}

Crafty.c "Controller", {
  init: ->
    this.requires "2D, DOM, Image, Draggable"
    this.image("assets/move_target.png")
  activate: ->
    console.log "activated this controller"
}

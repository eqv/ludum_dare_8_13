Crafty.c "Ship", {
  init: ->
    this.requires "2D,DOM,Image"
    this.image("assets/testship.png")
  }

Crafty.c "ControllableShip", {
  init: ->
    this.requires "Ship, Mouse"
    console.log("initing a ship")
    this.bind "Click", this.on_click
    @controller = Crafty.e "Controller"
    @controller.ship = this

  on_click: ->
    console.log "clicked"
    @controller.activate()
  }

Crafty.c "Controller", {
  init: ->
    this.requires "2D, DOM, Image, Draggable"
    this.image("assets/move_target.png")
}

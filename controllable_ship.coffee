Crafty.c "ControllableShip", {
  init: ->
    this.requires "Ship, Mouse"
    this.bind "Click", this.on_click
    @controller = Crafty.e "Controller"
    @controller.controller(this)

  on_click: ->
    this.unbind "Click", this.on_click
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
    @weapons = [Crafty.e("Weapon").weapon(0, 0, 0, 90, 10, this)]
    @shields = 1
}

Crafty.c "Controller", {
  init: ->
    this.requires "2D, DOM, Image, RestrictedDraggable, Color"
    #this.image "assets/move_target.png"
    #this.bind "Dragging", this.drag
    this.color( "#00ff00")

  controller: (ship) ->
    @ship = ship
    pos = @ship.get_pos().add(@ship.get_dir().scale( (@ship.min_move_dist()+@ship.max_move_dist())/2 ))
    this.set_path(end_pos: pos, center: null, radius: null)
    this.x= pos.x
    this.y= pos.y
    this.w  = 5
    this.h  = 5
    this.enableDrag()
    @alpha = 0.4

  activate: ->
    for controller_id in Crafty("Controller")
      Crafty(controller_id).deactivate()
    @alpha = 1
    @active = true

  deactivate: ->
    @alpha = 0.4

  set_path: (path) ->
    @path = path
    @ship.keyframes = [path] if path

  is_valid_drag_position: (x,y) ->
    this.activate()
    @alpha = 1
    path = @ship.get_path_to(new Vec2(x,y)) 
    this.set_path(path)
    return path.end_pos if path
    return null
}

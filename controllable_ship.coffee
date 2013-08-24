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
    this.origin(40,40)
    @speed = 1
    @maneuverability = 1
    @armor = 1
    @weapons = []
    @shields = 1
}

Crafty.c "Controller", {
  init: ->
    this.requires "2D, DOM, Image, RestrictedDraggable, Color" 
    #this.image "assets/move_target.png"
    #this.bind "Dragging", this.drag
    this.color( "#00ff00")

  activate: ->
    this.enableDrag()
    pos = @ship.get_pos().add(@ship.get_dir().scale( (@ship.min_move_dist()+@ship.max_move_dist())/2 ))
    this.x= pos.x
    this.y= pos.y
    this.w  = 5
    this.h  = 5
    dbg_point(pos.x, pos.y, "controller")
    console.log "activated this controller"

  is_valid_drag_position: (x,y) ->
    @path = @ship.get_path_to(new Vec2(x,y))
    @ship.path = @path
    return @path.end_pos
}

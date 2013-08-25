Crafty.c "ControllableShip", {
  init: ->
    this.requires "Ship, Mouse"
    this.bind "Click", this.on_click
    @controller = Crafty.e "Controller"
    @controller.ship = this
  uninit: ->
    @controller.destroy()

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
    @weapons = [Crafty.e("Weapon").weapon(0, 0, 0, 90, 10, this)]
    @shields = 1
}

Crafty.c "Controller", {
  init: ->
    this.requires "2D, DOM, Image, RestrictedDraggable, Color"
    #this.image "assets/move_target.png"
    #this.bind "Dragging", this.drag
    this.color( "#00ff00")

  activate: ->
    return if @active
    @active = true
    this.enableDrag()
    pos = @ship.get_pos().add(@ship.get_dir().scale( (@ship.min_move_dist()+@ship.max_move_dist())/2 ))
    this.x= pos.x
    this.y= pos.y
    this.w  = 5
    this.h  = 5

  is_valid_drag_position: (x,y) ->
    @path = @ship.get_path_to(new Vec2(x,y))
    @ship.keyframes = [@path] if @path
    return @path.end_pos  if @path
    return null
}

Crafty.c "ControllableShip", {
  init: ->
    this.requires "Ship, Mouse"
    if this.is_alive()
      this.bind "Click", this.on_contrallable_ship_on_click
      @controller = Crafty.e "Controller"
      @controller.controller(this)
    else
      pos = this.get_pos().add(this.get_dir().scale(this.get_min_move_dist()))
      @keyframes = [{end_pos: pos, center: null, radius: null, end_time: 1}]

  controllable_ship_on_click: ->
    this.unbind "Click", this.on_click
    @controller.activate() if @controller

  remove_controll: () ->
      this.unbind "Click", this.on_contrallable_ship_on_click
      @controller.destroy() if @controller
      @controller = null
      this.removeComponent("ControllableShip")
}

Crafty.c "Controller", {
  init: ->
    this.requires "2D, DOM, Image, RestrictedDraggable, Centered"
    this.image "assets/move_target.png"
    @w = 32
    @h = 32
    this.origin("center")

  controller: (ship) ->
    @ship = ship
    pos = @ship.get_pos().add(@ship.get_dir().scale( (@ship.get_min_move_dist()+@ship.get_max_move_dist())/2 ))
    this.set_path(end_pos: pos, center: null, radius: null, end_time: 1)
    this.set_pos pos
    this.enableDrag()
    this.bind "DragStart",->Crafty.viewport.lookmouse(false)
    this.bind "DragEnd",->Crafty.viewport.lookmouse(true)
    @alpha = 0.4

  activate: ->
    for controller_id in Crafty("Controller")
      Crafty(controller_id).deactivate()
    @alpha = 1
    @active = true
    @selected = true
    @ship.trigger("SelectedShip")

  deactivate: ->
    @alpha = 0.4
    @selected = false
    @ship.trigger("DeselectedShip")

  set_path: (path) ->
    if path
      @path = path
      @ship.keyframes = [path]
      @rotation = this.get_final_rotation(path)

  get_final_rotation: (path) ->
    if path.center
      target_dir = path.end_pos.clone().subtract(path.center)
      self_dir = @ship.get_pos().clone().subtract(path.center)
      return @ship.rotation - radToDeg(target_dir.angleBetween(self_dir))
    else
      return radToDeg(@ship.get_pos().angleTo(path.end_pos))

  is_valid_drag_position: (x,y) ->
    this.activate()
    @alpha = 1
    path = @ship.get_path_to(new Vec2(x,y))
    this.set_path(path)
    return path.end_pos if path
    return null
}

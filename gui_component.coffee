
Crafty.c "ViewportStatic",{
    xOff : 0,
    yOff : 0,
    startGui : () ->
      this.requires("2D");
      this.bind "EnterFrame", ->
        relative_x = -Crafty.viewport.x + @xOff;
        relative_y = -Crafty.viewport.y + @yOff;
        if @_x !=  relative_x || @_y != relative_y
          @x = relative_x
          @y = relative_y
  }

Crafty.c "NextTurnButton", {
  init: () ->
    this.requires("2D, DOM, Image, Mouse, ViewportStatic")
    this.image("assets/next_turn.png")
    @xOff = 20
    @yOff = 20
    this.bind "Click" , this.on_click
    this.startGui()
  on_click : (e) ->
    count_unused_ships = 0
    for ship_id in Crafty("ControllableShip")
      count_unused_ships += 1 if !Crafty(ship_id).controller.active
    ok = true
    if count_unused_ships > 0
      ok = confirm("you have unused ships, do you really want to continue?")
    currentLevel.next_planning_turn() if ok
  }





Crafty.c "ViewportStatic",{
    xOff : 0,
    yOff : 0,
    startGui : () ->
      this.requires("2D");
      this.bind "EnterFrame", ->
        @x = -Crafty.viewport.x + @xOff;
        @y = -Crafty.viewport.y + @yOff;
        console.log this.x, this.y
  }

Crafty.c "NextTurnButton", {
  init: () ->
    this.requires("2D, DOM, Image, Mouse")
    this.image("assets/next_turn.png")
    @xOff = 20
    @yOff = 20
    this.bind "Click" , this.on_click
    #this.startGui()
  on_click : (e) ->
    currentLevel.next_planning_turn()
  }
  



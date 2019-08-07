Crafty.c "Team", {
  init: () ->
    @fleet = []
  planning_turn: () ->
    this.perform_planning()
}

Crafty.c "StateVis", {
  init: ->
    this.requires '2D, Canvas, Image,Centered, Tween'

  stateVis:(ship) ->
    if ship.is_alive()
      this.image("assets/symbol_own.png")
    else
      this.image("assets/symbol_dead.png")
    @w = 32
    @h = 32
    this.origin("center")
    this.set_pos(ship.get_pos())

}

Crafty.c "SittingDuckAI", {
  init: () ->
    this.requires "Team"

  perform_planning: () ->
    for ship in @fleet
      ship.keyframes = [{end_pos: ship.get_pos(), center: null, radius: null, end_time: 3}]
    window.currentLevel.next_planning_turn()

}

Crafty.c "FadingImage", {
  init: () ->
    this.requires "2D, Image, Canvas, Tween, Delay"

  fadingImage: (path) ->
    @x = 500
    @y = 100
    this.image(path)
    @alpha = 1
    this.tween(alpha:0, 200)
    this.delay(this.destroy, 4000, 0)
}

Crafty.c "HumanPlayer", {
  init: () ->
    this.requires "Team"

  perform_planning: () ->
    if this.name == "Player 1"
      Crafty.e("FadingImage").fadingImage("assets/player1.png")
    else if this.name == "Player 2"
      Crafty.e("FadingImage").fadingImage("assets/player2.png")
    else
      console.log "unknown team", this.name
    for ship in @fleet
      ship.addComponent("ControllableShip")
      Crafty.e("StateVis").stateVis(ship)
    for ship_id in Crafty("Ship")
      ship = Crafty(ship_id)
      if !ship.is_alive()
        Crafty.e("StateVis").stateVis(ship)
    btn = Crafty.e("NextTurnButton")
    btn.nextTurnButton(this)
    for ship in @fleet
      e = Crafty.e("ShipIcon")
      e.shipIcon(ship)

  cleanup_planning: () ->
    for id in Crafty("ShipIcon, NextTurnButton")
      Crafty(id).remove()
    for id in Crafty("StateVis")
      Crafty(id).destroy()
    for ship in @fleet
      ship.remove_controll()

}

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
      ship.plan = {end_pos: ship.get_pos(), center: null, radius: null, end_time: 3}
    currentLevel.next_planning_turn()

}

Crafty.c "HumanPlayer", {
  init: () ->
    this.requires "Team"

  perform_planning: () ->
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

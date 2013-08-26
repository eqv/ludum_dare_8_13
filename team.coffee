Crafty.c "Team", {
  init: () ->
    @fleet = []
  planning_turn: () ->
    this.perform_planning()
}

Crafty.c "HumanPlayer", {
  init: () ->
    this.requires "Team"

  perform_planning: () ->
    for ship in @fleet
      ship.addComponent("ControllableShip")
    btn = Crafty.e("NextTurnButton")
    btn.nextTurnButton(this)
    for ship in @fleet
      e = Crafty.e("ShipIcon")
      e.shipIcon(ship)

  cleanup_planning: () ->
    for id in Crafty("ShipIcon, NextTurnButton")
      Crafty(id).remove()
    for ship in @fleet
      ship.remove_controll()
}

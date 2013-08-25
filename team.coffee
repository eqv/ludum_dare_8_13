Crafty.c "Team", {
  init: () ->
    @fleet = []
  planning_turn: () ->
    alert("#{@name}s Turn")
    this.perform_planning()
}

Crafty.c "HumanPlayer", {
  init: () ->
    this.requires "Team"
  perform_planning: () ->
    btn = Crafty.e("NextTurnButton")
    btn.nextTurnButton(this)
    for ship in @fleet
      e = Crafty.e("ShipIcon")
      e.shipIcon(ship)

  cleanup_planning: () ->
    console.log "destorying shity gui shit"
    for id in Crafty("ShipIcon, NextTurnButton")
      Crafty(id).remove()
}

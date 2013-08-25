Crafty.c "Team", {
  init: () ->
    3+4
  planning_turn: () ->
    this.perform_planning()
}

Crafty.c "HumanPlayer", {
  init: () ->
    this.requires "Team"
  perform_planning: () ->
    Crafty.e("NextTurnButton")
}

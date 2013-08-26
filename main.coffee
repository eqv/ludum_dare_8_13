$(document).ready ->
  done_loading = () ->
    Crafty.scene("menu")
  process_loading = (e) ->
    console.log e
  error_loading = (e) ->
    console.log e
  get_list_of_assets = () ->
    return [ "assets/fighter_icon.png", "assets/cruiser_icon_dead.png",
      "assets/fighter_icon_selected.png", "assets/cruiser.png",
      "assets/battleship_icon_selected.png", "assets/fighter_icon_dead.png",
      "assets/wip/cruiser.png", "assets/wip/battleship.png",
      "assets/wip/fighter.png", "assets/testship_icon.png",
      "assets/next_turn.png", "assets/cruiser_icon.png", "assets/battleship.png",
      "assets/fighter.png", "assets/battleship_icon_dead.png",
      "assets/cruiser_icon_selected.png", "assets/move_target.png",
      "assets/battleship_icon.png"]
  Crafty.init 640, 480
  Crafty.canvas.init()
  assets = get_list_of_assets()
  Crafty.load assets ,done_loading, process_loading, error_loading 
  Crafty.scene("menu")
  Crafty.viewport.clampToEntities = false
  Crafty.sprite(40, 40, "assets/explosion.png", { Explosion: [0, 0] })

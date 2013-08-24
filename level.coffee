levelScene = (file) ->
  console.log "Now I load " + file

Crafty.scene("level_" + i, levelScene.bind(null, "level_" + i + ".json")) for i in [1..5]

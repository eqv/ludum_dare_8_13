buildButton = (label, pos, click_handler) ->
  entity = Crafty.e("2D, Canvas, Mouse, Text").attr(x : 280, y: 150 + pos * 25, h: 20)
  entity.text(label).textColor("#FFFFFF").textFont(family: "Helvetica", size: "20px")
  entity.bind "Click", click_handler

load_level = (lvl) ->
  Crafty.scene("level_" + lvl)

Crafty.scene "menu", () ->
  Crafty.background "#444"
  Crafty.viewport.mouselook(false)
  for i in [1..5]
    name = if window.levels[i] then ": " + window.levels[i].name else ""
    buildButton "Level " + i + name, i - 1, load_level.bind(null, i)

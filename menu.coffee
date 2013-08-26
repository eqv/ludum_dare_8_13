winner = null

buildButton = (label, pos, click_handler) ->
  entity = Crafty.e("2D, Canvas, Mouse, Text").attr(x : 500, y: 250 + pos * 40, h: 20, w: 100)
  entity.text(label).textColor("#FFFFFF").textFont(family: "Helvetica", size: "20px")
  entity.bind "Click", click_handler

load_level = (lvl) ->
  Crafty.scene("level_" + lvl)

Crafty.scene "menu", () ->
  Crafty.background "url('assets/titlescreen.png')"
  Crafty.viewport.mouselook(false)
  if winner
    Crafty.e("2D, Canvas, Text").attr(x : 400, y: 180, h: 30).text(winner.name + " has won")
          .textColor("#FFFFFF").textFont(family: "Helvetica", size: "30px")
  for i in [1..5]
    name = if window.levels[i] then ": " + window.levels[i].name else ""
    buildButton "Level " + i + name, i - 1, load_level.bind(null, i)

levels = []
currentLevel = null

levels[1] =
  ships: [
    type: "TestShip"
    x: 320
    y: 240
    rot: 0
  ],
  npcs: [
    type: "TestShip"
    x: 150
    y: 0
    rot: 90
  ]

class Level
  constructor: (lvl) ->
    @ships = lvl.ships
    @npcs = lvl.npcs
    for ship in @ships
      Crafty.e("ControllableShip, " + ship.type).attr(rotation: ship.rot).set_pos(ship.x, ship.y)
    for npc in @npcs
      Crafty.e(npc.type).attr(x: npc.x, y: npc.y, rotation: npc.rot).set_pos(npc.x, npc.y)

startScene = (i) ->
  currentLevel = new Level levels[i]

Crafty.scene("level_" + i, startScene.bind null, i) for i in [1..5]

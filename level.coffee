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
    x: 100
    y: 0
    rot: 90
  ]

class Level
  constructor: (lvl) ->
    @ships = lvl.ships
    @npcs = lvl.npcs
    for ship in @ships
      Crafty.e("ControllableShip, " + ship.type).attr(x: ship.x, y: ship.y, rot: ship.rot)
    for npc in @npcs
      Crafty.e(npc.type).attr(x: npc.x, y: npc.y, rot: npc.rot)

startScene = (i) ->
  currentLevel = new Level levels[i]

Crafty.scene("level_" + i, startScene.bind null, i) for i in [1..5]

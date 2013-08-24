$(document).ready ->
  Crafty.init 640, 480
  Crafty.canvas.init()
  Crafty.scene("menu")
  Crafty.e("TestShip, ControllableShip").attr x: 20, y: 20
